# Maintainer Instructions

This file is for project maintainers only. It is not installed skill runtime
policy and does not make learning-record maintenance a requirement for users of
the installed skills.

## Canonical Records

- `VISION.md` states project purpose and principles.
- `docs/decisions.md` is the register of active durable decisions.
- `docs/changes/` holds active substantial-change state; archive completed notes
  under `docs/changes/archive/`.
- `docs/learnings.md` is maintainer-only historical evidence.

## Record Maintenance

Small work needs no change note. A substantial, long-running, risky, interrupted,
or multi-unit change uses one lightweight note under `docs/changes/`; it covers
the goal, material decisions, current plan, and accepted evidence. There is no
separate spec, plan, or log requirement, and the note changes only when state
meaningfully changes.

For a behavioral process change, maintainers append a stable learning entry to
`docs/learnings.md` covering the observed problem, contributing mechanism,
minimal change and rationale, and status. Preserve existing history.

Resolve ordinary record drift locally. Surface material conflicts instead of
silently choosing, and promote durable project decisions to `docs/decisions.md`.
