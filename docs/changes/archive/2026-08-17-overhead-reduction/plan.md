# Plan: Process Overhead Reduction

Ownership and approval:
- Owner: Lead
- Status: Approved 2026-08-17 by user

## Technical Approach

Each finding maps to one work unit. The skills and references are edited first,
then the describing documents, then `tests/validate.sh` last, since pruning the
wording locks must follow the rewording they would otherwise block.

## Work Units

| ID | Objective | Depends on | File or subsystem scope | Verification (static or live) |
|---|---|---|---|---|
| unit-01 | Restrict Orchestrator plan approval to semantic sections | - | `references/governance.md`, `references/artifacts.md`, `references/scheduling.md`, orchestrate `SKILL.md`, `assets/plan.md` | static: phrase inspection |
| unit-02 | Add the `handover` status; delete the `blocked` overload caveats | - | both `SKILL.md`, `references/scheduling.md`, `README.md`, `docs/architecture.md` | static: `grep` finds no blocked-is-terminal caveat |
| unit-03 | Demote `150000` to a configuration default | - | both `SKILL.md`, `references/scheduling.md`, `assets/agent-process.md`, `README.md`, `docs/architecture.md` | static: `grep -c` occurrence count falls |
| unit-04 | Brief-named principles clauses replace the per-dispatch read | - | `references/scheduling.md`, work-unit `SKILL.md`, orchestrate `SKILL.md` | static: phrase inspection |
| unit-05 | Compress the delegation-decision rules | - | `references/scheduling.md` | static: line count falls, behavior unchanged |
| unit-06 | Counters recorded only above 1 | - | orchestrate `SKILL.md`, `references/scheduling.md`, `assets/plan.md`, `assets/state.md` | static: phrase inspection |
| unit-07 | Single-source the threshold and lifecycle prose | unit-02, unit-03 | `README.md`, `docs/architecture.md`, `docs/integrations/*.md` | static: one full statement per role skill |
| unit-08 | Prune retired contract checks; state the retirement rule | unit-01..unit-07 | `tests/validate.sh`, `CONTRIBUTING.md` | static: `sh tests/validate.sh` |
| unit-09 | Behavioral record and changelog; completion transaction | unit-08 | `tests/behavioral.md`, `CHANGELOG.md`, `docs/changes/` | static: `sh tests/validate.sh`; `git status` |

Only the Lead mutates plans and state. Semantic unit IDs are stable; execution
slices use `unit-<n>/attempt-<n>`.

## Progress

- [x] unit-01 Plan approval surface
- [x] unit-02 `handover` status
- [x] unit-03 `150000` demotion
- [x] unit-04 Principles clauses
- [x] unit-05 Delegation compression
- [x] unit-06 Counter threshold
- [x] unit-07 Single-sourcing
- [x] unit-08 Contract-check pruning
- [x] unit-09 Record and completion

## Attempt Accounting

Recorded only for units whose attempts, corrections, or independent reviews
exceed 1. No entries.

## Pending User Decisions

- None. Serial execution is out of scope by the user's standing design
  decision, recorded in the specification's non-goals.

## Acceptance-Criterion Evidence

| Acceptance criterion | Evidence |
|---|---|
| Semantic-only plan approval | `references/governance.md` approval matrix; `assets/plan.md` section marking |
| Threshold stated once per role skill | `grep -rn` across README, architecture, integration guides |
| Contract checks pruned with a retirement rule | `tests/validate.sh`; `CONTRIBUTING.md` |
| `150000` demoted | `grep -rc "150000"` |
| Principles read on demand | `references/scheduling.md` Worker Brief; work-unit `SKILL.md` |
| `handover` status exists | `references/scheduling.md` status table |
| Counters only above 1 | `assets/plan.md`, `assets/state.md` |
| Delegation rules compressed | `wc -l references/scheduling.md` |
| Validation passes | `sh tests/validate.sh` |

## Residual Risks

- Pruning contract checks removes regression detection for older changes. The
  behavior remains recorded in `tests/behavioral.md`, and the checks could only
  ever detect wording. Accepted as the stated retirement rule.
- Single-sourcing means a reader of the integration guides alone no longer sees
  the full threshold text. Mitigated by an explicit pointer at each site.

## Final Outcome

- Completed 2026-08-17. All acceptance criteria met; `sh tests/validate.sh` passes.
  Serial execution was left unchanged as a user-owned design decision.
