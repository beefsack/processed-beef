# Canonical Guidance Names

**Status:** Archived 2026-08-29

## Goal And Acceptance

Establish `docs/principles.md` and `docs/decisions.md` as the process-governance
canonical names, preserve inherited lifecycle/handover changes, and encode the
runtime distinction between user-owned principles, active decisions, and a
separate product vision. Acceptance requires current public, maintainer,
runtime, and validation guidance to use the new names; historical archives stay
intact except the inherited lifecycle note; and targeted behavioral evidence and
learning records are present.

## Material Decisions

- `docs/principles.md` is strict, project-wide, user-owned design boundaries.
- `docs/decisions.md` contains concise active decisions only; Git/history preserves
  superseded decisions.
- A separate `VISION.md` is goal input only. Missing root records are established
  for useful long-running work, not imposed on small work.

## Units And Evidence

- [x] Establish the canonical records and update live references.
- [x] Align startup, delegation, maintainer, public, and validation guidance.
- [x] Add behavioral Scenario 36 and learning L016.
- [x] Update the inherited archived lifecycle note's stale canonical names.
- [x] Independent review found stale evidence and missing obsolete-path checks;
  both were corrected.
- [x] `sh tests/validate.sh` and `git diff --check` pass after the final runtime
  and validation changes.

## Failures And Repair

None. No semantic failed approach or causal verification repair occurred.

## Risks

Historical records retain prior process descriptions for factual accuracy. A
separate product `VISION.md` could be misread by integrations unless
they follow the runtime distinction.

## Next Action

None; archived after independent review and final validation.
