-- ============================================================
-- ADMIN v2 — run in Supabase SQL Editor (after playbook_v3.sql)
-- Adds edit history snapshots to client_roadmaps.
-- The portal pushes a snapshot of `levels` into `history`
-- before every save; restore = copy a snapshot back to levels.
-- ============================================================

alter table public.client_roadmaps
  add column if not exists history jsonb not null default '[]'::jsonb;

-- history entries: [{ "ts": "...", "levels": [...] }, ...] newest first, capped at 15 by the portal
