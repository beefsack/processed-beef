# Agent Lifecycle And Handover

**Status:** Archived 2026-08-29

## Goal And Acceptance

Make Leads and Workers short-lived disposable contexts and make their final
results lean terminal handovers, while preserving L004's coherent-change Lead
economics and L008's cross-succession semantic history. Acceptance requires the
behavior to be explicit in `docs/principles.md` and the role skills, consistent in public
docs, covered by behavioral scenarios, and free of redundant integration
lifecycle reports.

## Material Decisions

- Retain one Lead through one coherent change; use a fresh Lead at real
  ownership boundaries and a fresh Worker for each bounded unit, with a terminal
  result.
- Never resume completed agents. Resume unfinished work only exceptionally for
  a clearly unblocking, cheaper, safe continuation of the same narrow objective
  while context remains useful.
- Every role final response is a terminal handover containing only
  successor-relevant attempts or failures, discoveries, decisions, gotchas or
  risks, evidence, and an exact next action; use `none` when no action remains.
  Nonzero semantic failures and one causal repair use cross the handover and,
  when one exists, the active change note. Do not require routine
  changed-path/outcome recaps, transcripts, repeated briefs, schemas,
  lifecycle/status machines, fixed token/tool ceilings, counters, or ledgers.

## Units And Dependencies

- [x] Align `docs/principles.md`, architecture, README, `docs/decisions.md`, and role
  skills.
- [x] Add behavioral coverage and learning L015.
- [x] Remove redundant broad lifecycle prose from all five integration guides.
- [x] Add the Unreleased changelog entry.
- Dependency: `AGENTS.md` required an active change note when substantial work
  required one; this change also required the learning record.

## Evidence

- `sh tests/validate.sh`: pass.
- `git diff --check`: pass.
- Final diff inspection: complete; only allowed paths changed.
- Review correction: Scenarios 34-35 now label the pre-change issue as a
  policy/documentation gap rather than observed incident evidence, with GREEN
  explicitly pending future observation.

## Failures And Repair

None. No semantic failed approach or causal verification repair occurred.

## Risks

Behavioral effectiveness is not yet measured under the new lifecycle policy;
Scenarios 34-35 record the pre-change documentation gap and corrected evidence
status, not an observed incident or result.
Host integration limits remain version-sensitive.

## Next Action

None; note archived after final review.
