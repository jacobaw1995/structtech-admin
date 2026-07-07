# StructTech OS — Buildout Schedule Feature (Spec v1)

**Session:** Plan + schema design (7/6/26). No app code this session — this doc is the alignment artifact.
**Owner:** Jacob · **Controller:** pm-app-controller skill

---

## What this is

The **buildout / delivery schedule**: the layer that turns a static client roadmap into a
living timeline the client watches in their portal. It answers the questions the roadmap
alone can't — *which level are we on, what's happening now, and when does each piece land.*

It is the bridge between **sold** (`closed_won`) and **delivered**.

## Where it fits in the lifecycle

Wired today (sales side):
```
Scan (audit_leads) → Roadmap auto-gen (client_roadmaps + roadmap_playbook)
  → Deal pipeline (deals) → Present Mode → closed_won
```

The gap this fills (delivery side):
```
closed_won → Engagement starts → Schedule materialized (each level gets a target window)
  → StructTech works levels, ticks milestones + logs check-ins
  → Client portal shows live Gantt + current status
  → PROVE hit → level complete → next level → Handoff → engagement complete
```

**Cross-feature payoffs:**
- Present Mode "next-steps / start date" slide pulls from the schedule.
- `org_invoices` can later bill **per level** as each completes.
- Client portal becomes a living document instead of a read-only list.

---

## Decisions locked (7/6/26)

1. **Dates the client sees:** level bars display as **"week of"** target windows. **Client
   check-ins carry hard calendar dates.** Real internal actual-dates tracked but not
   necessarily surfaced.
2. **View:** a **Gantt** in the client portal. Convention: **bars = levels** (sequential
   order-of-ops), **milestones + check-ins = diamonds** on the bars. No per-milestone bars —
   keeps it visual, not overwhelming.
3. **Data model:** **normalize** the roadmap out of JSONB into real rows so each level /
   milestone can carry dates + status and be queried. JSONB stays as the generated draft;
   materialize to rows at `closed_won`.

---

## Schema (proposed)

New tables. RLS scoped to authenticated/org (see Security workstream). All inserts and the
JSONB→rows materialization go through **security-definer RPCs**, per existing OS patterns.

```
engagements
  id                uuid pk
  deal_id           uuid → deals
  roadmap_id        uuid → client_roadmaps
  org_id            uuid → organizations
  start_date        date
  target_end_date   date
  status            text  (active | paused | complete)
  created_at        timestamptz default now()
  -- one row per closed-won client: the delivery instance of a roadmap

engagement_levels                    -- normalized from roadmap JSONB
  id                uuid pk
  engagement_id     uuid → engagements
  level_no          int
  title             text
  why               text
  sort_order        int
  depends_on_level_id uuid → engagement_levels   -- sequential gate (Level 2 after Level 1)
  planned_start     date            -- rendered "week of"
  planned_end       date            -- rendered "week of"
  actual_start      date            -- internal
  actual_end        date            -- internal
  status            text  (not_started | in_progress | blocked | complete)

engagement_milestones                -- deliverables / behaviors within a level
  id                uuid pk
  level_id          uuid → engagement_levels
  owner             text  (structtech | client)
  stage             text  (assess | build | adopt | prove | handoff)
  body              text
  is_win_condition  bool
  sort_order        int
  status            text  (open | complete)
  completed_at      timestamptz
  -- rendered as diamonds on the level bar

engagement_checkins                  -- hard-dated meetings, distinct from milestones
  id                uuid pk
  engagement_id     uuid → engagements
  level_id          uuid → engagement_levels   -- nullable
  title             text
  scheduled_at      timestamptz     -- HARD date/time
  status            text  (scheduled | done | missed | rescheduled)
  notes             text
  -- rendered as fixed-date diamonds; feeds "next check-in" chip in portal
```

**Derived, not double-entered:** level `status` and % complete are computed from milestone
completion + actuals, so the client Gantt updates just by ticking milestones off. No parallel
status bookkeeping.

**Key RPC:** `create_engagement_from_roadmap(p_deal_id)` — fires at `closed_won`, reads the
`client_roadmaps` JSONB, and materializes `engagements` + `engagement_levels` +
`engagement_milestones` in one transaction. Check-ins added manually after.

---

## Portal rendering

- **Client Gantt:** lightweight read-only (SVG/CSS), not DHTMLX PRO — that's overkill for a
  view-only client timeline. Level bars (week-of windows), milestone diamonds, check-in
  diamonds (hard dates), current level highlighted, WIN CONDITION strip on the active level.
- **"Next check-in" chip:** nearest `engagement_checkins.scheduled_at`.
- **Admin side:** Jacob edits planned windows, ticks milestones, logs/moves check-ins.

---

## Out of scope this session / follow-ups

- **Security workstream (separate dedicated session):** granular RLS on all tables, migrate
  admin off the soft SHA-256 gate to Supabase Auth, enable RLS on `structtech_state`
  (currently disabled — exposed to anon key). Required before client-visible schedule data
  goes live.
- Per-level invoicing (`org_invoices` link) — later phase.
- Present Mode next-steps slide wiring — after schema ships.
- Migration SQL + admin/portal UI — next build session.
```
