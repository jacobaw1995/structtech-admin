-- ============================================================
-- PLAYBOOK v3 — run in Supabase SQL Editor (project: structtech)
-- Changes from v2:
--   1. ASSESS collapsed into "Strategize & Build" (one StructTech milestone)
--   2. q1+q2 both weak -> merged "Sales Pipeline System" level
--   3. PROVE thresholds calibrated by crew size:
--        1-4 crew:  1 week  / 3 jobs
--        5-9 crew:  2 weeks / 5 jobs
--        10+ crew:  3 weeks / 8 jobs
--   4. Adds 'q11' Material Ordering playbook entry (scan question comes later)
--   Every level ends with TRAIN & HANDOFF.
-- Templates use {{W}} = prove window, {{J}} = prove job count.
-- ============================================================

create or replace function public.roadmap_playbook(q text)
returns jsonb language sql immutable as $$
select case q
  when 'sales' then '{
    "title": "Sales Pipeline System",
    "why": "Leads are slipping in twice — slow first response AND estimates dying in silence. One custom sales system fixes the whole pipe: capture, respond, quote, follow up, close.",
    "milestones": [
      {"label":"StructTech maps your current sales flow and builds your custom pipeline — instant lead response, estimate tracking, and automatic follow-up in one system","owner":"jacob"},
      {"label":"Every lead answered inside the response window and logged in the pipeline — no tracking in your head","owner":"client"},
      {"label":"Every estimate logged the day it goes out, with win/loss reason captured on close","owner":"client"},
      {"label":"{{W}} straight: every lead answered under 5 minutes AND one job won from a revived estimate","owner":"client"},
      {"label":"StructTech trains your team on the pipeline and documents the process — runs without you","owner":"jacob"}
    ]}'::jsonb
  when 'q1' then '{
    "title": "Instant Lead Response System",
    "why": "Speed wins jobs. The contractor who answers first gets the walkthrough — this system makes sure that is always you, even when you are on a job.",
    "milestones": [
      {"label":"StructTech maps how leads reach you today and builds your custom capture + instant-response system — every call and form fill answered immediately","owner":"jacob"},
      {"label":"Every lead gets a personal follow-up within the response window — no lead sits overnight","owner":"client"},
      {"label":"Log the outcome of every lead conversation in the pipeline","owner":"client"},
      {"label":"{{W}} straight: every new lead answered in under 5 minutes","owner":"client"},
      {"label":"StructTech trains your team and documents the response process — runs without you touching it","owner":"jacob"}
    ]}'::jsonb
  when 'q2' then '{
    "title": "Estimate Follow-Up Engine",
    "why": "Most estimates die from silence, not price. Consistent follow-up revives jobs you already quoted.",
    "milestones": [
      {"label":"StructTech reviews your open estimates and builds your custom follow-up engine — automatic touchpoints at set intervals, tracked in your pipeline","owner":"jacob"},
      {"label":"Every estimate logged with amount and expected decision date the day it goes out","owner":"client"},
      {"label":"Win/loss reason captured on every closed estimate — your pricing intelligence","owner":"client"},
      {"label":"Win one job from a revived estimate that would have died silent","owner":"client"},
      {"label":"StructTech documents the cadence and trains the team — the engine runs itself","owner":"jacob"}
    ]}'::jsonb
  when 'q3' then '{
    "title": "Field-to-Office Communication Flow",
    "why": "Work happens in the field but the office finds out whenever someone remembers to mention it. This closes that gap the same day.",
    "milestones": [
      {"label":"StructTech maps what the field knows that the office does not, then builds your custom crew check-in system — photos, hours, materials in under 5 minutes from a phone","owner":"jacob"},
      {"label":"Crew lead completes the daily check-in on every active job — end of day, no exceptions","owner":"client"},
      {"label":"Scope changes logged the moment they happen, not at invoice time","owner":"client"},
      {"label":"{{W}} of consistent daily logs from every active job","owner":"client"},
      {"label":"StructTech trains every crew member and documents the process — office dashboard live","owner":"jacob"}
    ]}'::jsonb
  when 'q4' then '{
    "title": "Real-Time Job Cost Tracking",
    "why": "If you cannot see what a job actually costs while it is running, you find out you lost money when it is too late to fix.",
    "milestones": [
      {"label":"StructTech breaks down how you price and track costs today, then builds your custom per-job cost tracker — labor, materials, and margin in real time","owner":"jacob"},
      {"label":"Log labor hours and material costs against each active job as they happen","owner":"client"},
      {"label":"Review estimated vs actual margin on every job close-out","owner":"client"},
      {"label":"{{J}} jobs fully costed — you know your real margin on each","owner":"client"},
      {"label":"StructTech trains the office and documents costing — margin reports automatic","owner":"jacob"}
    ]}'::jsonb
  when 'q5' then '{
    "title": "One Hub, Fewer Apps",
    "why": "Every app your data hops between is a place it gets lost. We consolidate into one hub your whole crew actually uses.",
    "milestones": [
      {"label":"StructTech inventories every tool, spreadsheet, and paper process, then builds your custom ops hub — connecting what is worth keeping, replacing what is not","owner":"jacob"},
      {"label":"Whole crew works out of the hub — no side spreadsheets, no I-will-add-it-later","owner":"client"},
      {"label":"Cancel the redundant subscriptions and confirm nothing breaks","owner":"client"},
      {"label":"{{W}} with the entire operation running through one system","owner":"client"},
      {"label":"StructTech documents the hub and trains the team — one system, owned by you","owner":"jacob"}
    ]}'::jsonb
  when 'q6' then '{
    "title": "Key-Person Backup System",
    "why": "If one person getting sick stops your operation, you do not have a system — you have a liability.",
    "milestones": [
      {"label":"StructTech identifies what knowledge lives only in someone''s head and documents your critical workflows into SOPs built into your hub — not a binder on a shelf","owner":"jacob"},
      {"label":"Name a backup person for each critical role","owner":"client"},
      {"label":"Backup shadows the primary through one full cycle of the workflow","owner":"client"},
      {"label":"Backup person runs the workflow solo for one full week","owner":"client"},
      {"label":"StructTech finalizes SOPs and cross-training — single point of failure eliminated","owner":"jacob"}
    ]}'::jsonb
  when 'q7' then '{
    "title": "Same-Day Invoicing System",
    "why": "Every day an invoice sits unsent is a day you are funding your client''s business instead of yours.",
    "milestones": [
      {"label":"StructTech maps your job-completion-to-payment cycle and builds custom invoice automation — the moment a job closes, the invoice drafts itself, connected to your existing accounting","owner":"jacob"},
      {"label":"Review and send the drafted invoice the same day the job completes","owner":"client"},
      {"label":"Log payment status so overdue invoices trigger follow-up automatically","owner":"client"},
      {"label":"{{J}} straight jobs invoiced same-day","owner":"client"},
      {"label":"StructTech trains the office and documents the flow — cash cycle measurably shorter","owner":"jacob"}
    ]}'::jsonb
  when 'q8' then '{
    "title": "Visual Crew Scheduling Board",
    "why": "Scheduling from memory and texts means double-booked crews and dead days. One board, whole week visible, no surprises.",
    "milestones": [
      {"label":"StructTech maps how jobs get scheduled today and builds your custom scheduling board — every job, every crew member, whole week visible, updates pushed to phones","owner":"jacob"},
      {"label":"All scheduling happens on the board — no side texts, no verbal-only changes","owner":"client"},
      {"label":"Crew checks the board before every shift instead of calling you","owner":"client"},
      {"label":"{{W}} with zero scheduling conflicts or dead days","owner":"client"},
      {"label":"StructTech trains whoever runs scheduling and documents it — you are out of the middle","owner":"jacob"}
    ]}'::jsonb
  when 'q9' then '{
    "title": "Automated Client Updates",
    "why": "Clients who know what is happening do not call, do not stress, and do not dispute scope.",
    "milestones": [
      {"label":"StructTech maps every client touchpoint from contract to final payment and builds your custom update system — en-route texts, daily progress with photos, completion notice, all automatic","owner":"jacob"},
      {"label":"Approve the message templates so they sound like you","owner":"client"},
      {"label":"Crew captures the job photos that feed the updates","owner":"client"},
      {"label":"One full job start-to-finish with automated updates — zero what-is-happening calls","owner":"client"},
      {"label":"StructTech locks the templates and documents the flow — runs on every job automatically","owner":"jacob"}
    ]}'::jsonb
  when 'q10' then '{
    "title": "Owner Independence Dashboard",
    "why": "The business should run when you take a day off.",
    "milestones": [
      {"label":"StructTech lists every decision that routes through you and builds your custom owner dashboard — jobs, cash, crew, pipeline at a glance, plus delegation workflows","owner":"jacob"},
      {"label":"Delegate scheduling and invoicing to your second-in-command with clear authority limits","owner":"client"},
      {"label":"Weekly review rhythm — you check the dashboard instead of being in every conversation","owner":"client"},
      {"label":"Take a full day off — business runs without a single call to you","owner":"client"},
      {"label":"StructTech documents the delegation map and trains your second — you own growth, not operations","owner":"jacob"}
    ]}'::jsonb
  when 'q11' then '{
    "title": "Material Ordering System",
    "why": "Wrong materials, late deliveries, and emergency supply-house runs kill crew days. Ordering should flow straight from the estimate — not from memory.",
    "milestones": [
      {"label":"StructTech maps how materials get ordered today — who orders, from where, what goes wrong — and builds your custom ordering system tied to each job''s estimate","owner":"jacob"},
      {"label":"Every job''s material list generated from the estimate before the crew rolls","owner":"client"},
      {"label":"Deliveries confirmed against the list — shortages flagged before they cost a crew day","owner":"client"},
      {"label":"{{J}} jobs with zero emergency supply runs","owner":"client"},
      {"label":"StructTech trains whoever owns ordering and documents the flow — materials just show up right","owner":"jacob"}
    ]}'::jsonb
  else null
end $$;

-- ============================================================
-- Shared level-builder with crew-size calibration + sales merge
-- ============================================================
create or replace function public.build_roadmap_levels(p_answers jsonb, p_crew int)
returns jsonb language plpgsql as $$
declare
  w text; j text;
  areas text[] := '{}';
  worst record;
  q1s int := coalesce((p_answers->>'q1')::int, 10);
  q2s int := coalesce((p_answers->>'q2')::int, 10);
  lvls jsonb := '[]'::jsonb;
  pb jsonb; ms jsonb; li int := 0; mi int; built_ms jsonb;
  a text;
begin
  -- PROVE calibration by crew size
  if coalesce(p_crew,5) <= 4 then      w := 'One week';   j := 'Three';
  elsif coalesce(p_crew,5) <= 9 then   w := 'Two weeks';  j := 'Five';
  else                                 w := 'Three weeks'; j := 'Eight';
  end if;

  -- Sales merge: both q1 and q2 at 2 or below -> one combined level
  if q1s <= 2 and q2s <= 2 then
    areas := array['sales'];
    for worst in
      select key as q from jsonb_each_text(coalesce(p_answers,'{}'::jsonb))
      where key ~ '^q([1-9]|1[01])$' and key not in ('q1','q2')
      order by (value)::int asc, substring(key from 2)::int asc limit 2
    loop
      areas := areas || worst.q;
    end loop;
  else
    for worst in
      select key as q from jsonb_each_text(coalesce(p_answers,'{}'::jsonb))
      where key ~ '^q([1-9]|1[01])$'
      order by (value)::int asc, substring(key from 2)::int asc limit 3
    loop
      areas := areas || worst.q;
    end loop;
  end if;

  foreach a in array areas loop
    pb := public.roadmap_playbook(a);
    if pb is null then continue; end if;
    pb := replace(replace(pb::text, '{{W}}', w), '{{J}}', j)::jsonb;
    built_ms := '[]'::jsonb; mi := 0;
    for ms in select * from jsonb_array_elements(pb->'milestones') loop
      built_ms := built_ms || jsonb_build_array(jsonb_build_object(
        'id','l'||li||'m'||mi,'label',ms->>'label','owner',ms->>'owner','done',false,'done_at',null));
      mi := mi + 1;
    end loop;
    lvls := lvls || jsonb_build_array(jsonb_build_object(
      'title',pb->>'title','why',pb->>'why','area',a,'milestones',built_ms));
    li := li + 1;
  end loop;

  return lvls;
end $$;

-- ============================================================
-- Rewire trigger + RPC to use the shared builder
-- ============================================================
create or replace function public.auto_create_roadmap()
returns trigger language plpgsql security definer as $$
declare lvls jsonb;
begin
  lvls := public.build_roadmap_levels(new.answers, new.crew_size);
  if jsonb_array_length(lvls) > 0 then
    insert into public.client_roadmaps
      (lead_id, client_name, company, trade, crew_size, score, risk_level, revenue_leak_monthly, levels)
    values
      (new.id, coalesce(new.name,'—'), coalesce(new.company,'—'), new.trade, new.crew_size,
       new.score, new.risk_level, new.monthly_leak, lvls);
  end if;
  return new;
end $$;

create or replace function public.generate_roadmap_for_lead(p_lead_id uuid)
returns text language plpgsql security definer as $$
declare
  lead record; lvls jsonb; new_token text;
begin
  select * into lead from public.audit_leads where id = p_lead_id;
  if not found then raise exception 'lead not found'; end if;
  lvls := public.build_roadmap_levels(lead.answers, lead.crew_size);
  insert into public.client_roadmaps
    (lead_id, client_name, company, trade, crew_size, score, risk_level, revenue_leak_monthly, levels)
  values
    (lead.id, coalesce(lead.name,'—'), coalesce(lead.company,'—'), lead.trade, lead.crew_size,
     lead.score, lead.risk_level, lead.monthly_leak, lvls)
  returning token into new_token;
  return new_token;
end $$;

-- ============================================================
-- Quick test (optional): run, inspect, then delete test rows
-- ============================================================
-- insert into public.audit_leads (name,email,company,trade,score,risk_level,monthly_leak,crew_size,answers)
-- values ('Sales Merge Test','t@t.com','Merge Co','Roofing',25,'CRITICAL',5000,3,
--   '{"q1":0,"q2":2,"q3":6,"q4":2,"q5":10,"q6":10,"q7":6,"q8":10,"q9":6,"q10":6}'::jsonb);
-- select levels->0->>'title', levels->1->>'title', levels->2->>'title'
--   from client_roadmaps where client_name='Sales Merge Test';
-- Expected: Sales Pipeline System | Real-Time Job Cost Tracking | (next worst)
-- Prove lines should say "One week"/"Three" since crew=3.
