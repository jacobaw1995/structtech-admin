# Present Mode — Plan (not built yet)

## Goal
A full-screen "PRESENT" button inside StructTech OS for live video-call walkthroughs:
roadmap → quote/proposal → close. Everything presented lives in the OS — no PowerPoint, no tab juggling.

## What's already in place (foundation)
- Roadmap data + editor in the portal (single source of truth)
- Client roadmap page already uses the presentation design language (cream/ink/blue, Barlow Condensed, Space Mono)
- PPTX/PDF export already builds slide-shaped views of the same data — present mode is the same content rendered live instead of exported
- `proposals` table already exists in Supabase (tier, price, custom_notes) from the earlier OPS Center — reuse it for the quote step

## Build steps (when ready)
1. **Present button** on the roadmap editor → fullscreen takeover (`requestFullscreen`), keyboard nav (←/→), Esc to exit
2. **Slide sequence** rendered from live data:
   - Cover: client name, THREAT bar, monthly leak (the "holy sh*t" opener)
   - One slide per level: title, problem, milestones, WIN CONDITION
   - Investment slide: pulled from `proposals` (tier/price per level — "Level 1 gets you X for $Y")
   - Next-steps slide: start date, first 30 days, book/sign CTA
3. **Presenter controls**: bottom-corner nav dots + notes toggle only Jacob sees (before fullscreen share)
4. **Quote builder** in the portal (small form on the prospect record → proposals table) — prerequisite for the investment slide
5. Later: client-facing "replay" link — same deck, view-only, sent after the call

## Design rule
Present mode reuses the roadmap.html visual system 1:1 — cream cards, ink background,
blue level gradients, Space Mono labels. One design language everywhere the client looks.
