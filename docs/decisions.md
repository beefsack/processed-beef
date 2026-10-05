# Active Decisions

This register contains only active durable decisions for the lean runtime and
record split. It is not a template or a ceremony.

- Installed skills contain current role-local runtime policy only. Project
  records, templates, and historical payloads are not installed skill runtime.
- `docs/principles.md` contains strict project-wide design boundaries owned by
  the user; `docs/decisions.md` is the active decision register; `docs/changes/` is
  active change state;
  `docs/changes/archive/` is archived change history.
- `docs/learnings.md` remains separate maintainer-only historical evidence.
  Its maintenance is governed by root `AGENTS.md`, not by installed skills.
- The Orchestrator owns concise prioritized `docs/backlog.md`. It contains one line
  per pending or active meaningful change, with a link and priority or
  dependency context; trivial requests need no line.
- The Lead owns one active `docs/changes/<slug>.md` for a meaningful change. It
  combines goal, scope and non-goals, acceptance, approach, bounded units and
  dependencies, and verification. It changes only for meaningful intent,
  material decision, plan, blocker, accepted-evidence, or outcome changes.
  Workers never maintain project records.
- Completion verifies acceptance, promotes authorized durable decisions, adds
  concise outcome and evidence, archives the one note, and advances or removes
  its backlog line. No approval gate, log, state or recovery file, routine
  progress record, retry ledger, tick, or completion transaction is required.
- `docs/decisions.md` contains concise active decisions only, not append-only history.
  Agents may maintain it as authorized decisions become active, change, or are
  superseded; material decisions remain user-owned, and Git/history preserves
  prior decisions.
- Retain one Lead through a coherent change; resume agents for unknowns,
  direction, corrections, and small follow-ups within their work. Prefer fresh
  agents briefed from handovers for new items or units, independent review, or
  crowded, stale, or unrelated context. Assume substantial completed work leaves
  little capacity; handovers carry knowledge between items. No fixed counts.
- Orchestrator-to-Lead and Lead-to-Worker briefs pass relevant knowledge already
  available to the parent: learned facts, decisions, source locations, and
  useful evidence alongside the objective and constraints. For resumed agents,
  focus on the next objective and intervening changes. Avoid policy dumps and
  transcripts, not useful starting context; do not make children rediscover
  what the parent already knows.
- Final results are lean handovers; completed agents remain available for small
  follow-ups. Include only continuation- or successor-relevant attempts or
  failures, discoveries with
  source locations, decisions, gotchas or risks, evidence, and an exact next
  action; use `none` when no action remains. Do not require routine
  changed-path/outcome recaps, transcripts, repeated briefs, schemas,
  lifecycle/status machines, fixed token/tool ceilings, counters, or ledgers.
