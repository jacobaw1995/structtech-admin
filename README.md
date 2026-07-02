# StructTech OS — Admin Portal

Internal admin portal for StructTech LLC. **Never link this from public sites.**

## What it does
- **Scans** — every Revenue Leak Scan submission (from audit.structtek.com), with per-area score breakdowns
- **Roadmaps** — view/edit/export client execution roadmaps (auto-generated from scans by the Supabase playbook trigger)
- **Export** — PDF one-pager + branded PPTX deck for strategy calls
- Coming: Pipeline, Automation

## Stack
- Single-page static HTML (`index.html`) — no build step
- Data: Supabase project `structtech` (ejlhrykcdfcyeooooodx)
  - `audit_leads` — scan submissions
  - `client_roadmaps` — roadmaps (levels/milestones JSONB)
  - `roadmap_playbook()` — the "brains": area → milestones mapping
  - `generate_roadmap_for_lead(uuid)` — RPC to build a roadmap for a scan
- `ROADMAP_PLAYBOOK.md` — human-readable playbook doc (edit here, then update the DB function)

## Access
- Password gate (SHA-256, sessionStorage). Change: see comment near `PW_HASH` in index.html.
- ⚠ Current auth is a soft gate. Before adding pipeline/CRM data, migrate to Supabase Auth + RLS scoped to authenticated role.

## Related projects
- `../structtech-audit` — public funnel (audit.structtek.com), includes client-facing `roadmap.html`
- `../../StructTech Website Revamp` — structtek.com main site

## Deploy
GitHub Pages. Suggested domain: admin.structtek.com (CNAME + DNS A/CNAME records at your DNS host).
