# Maintainer Instructions

This file is for project maintainers only. It is not installed skill runtime
policy and does not make learning-record maintenance a requirement for users of
the installed skills.

## Canonical Records

- `docs/principles.md` states strict, project-wide design boundaries owned by the
  user. Plans, designs, decisions, and work are driven and constrained by it;
  agents may propose but never create or change principles without explicit
  user approval.
- `docs/decisions.md` is the concise register of active decisions, not append-only
  history. Agents may maintain it as authorized decisions become active, change,
  or are superseded; material decisions remain user-owned and Git/history
  preserves prior decisions.
- `docs/backlog.md` is the concise ordered list of pending and active meaningful
  changes, owned by the Orchestrator.

## Supporting Records

- `docs/changes/` holds active meaningful-change state; archive completed notes
  under `docs/changes/archive/`.
- `docs/learnings.md` is maintainer-only historical evidence.

## Record Maintenance

Trivial requests use the request directly and need no note. A meaningful change
has one Lead-owned `docs/changes/<slug>.md` combining compact specification
(goal, scope/non-goals, acceptance) and current plan (approach, bounded
units/dependencies, verification).
Update it only for meaningful intent, material decision, plan, blocker, accepted
evidence, or outcome changes. Workers do not maintain project records.

The Orchestrator maintains concise prioritized `docs/backlog.md` lines with link and
priority or dependency context. Completion verifies acceptance, promotes durable
decisions, adds concise outcome/evidence, archives the note, and advances or
removes its backlog line. Do not require approval gates, logs, state or recovery
files, routine progress records, retry ledgers, ticks, or completion transactions.

For a behavioral process change, maintainers append a stable learning entry to
`docs/learnings.md` covering the observed problem, contributing mechanism,
minimal change and rationale, and status. Preserve existing history.

Resolve ordinary record drift locally. Surface material conflicts instead of
silently choosing, and promote authorized durable project decisions to
`docs/decisions.md`.
