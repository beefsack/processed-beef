# Plan: Circuit Breakers and Revised Return Thresholds

Ownership and approval:
- Owner: Lead
- Status: Approved 2026-08-17 by user

## Technical Approach

Add one new section to the orchestrate skill and one clause to the work-unit
skill, then extend the three affected references. Every other edit is a
restatement of the revised threshold sentence in the documents that already
carry it, so that the wording stays identical everywhere.

The breaker is deliberately built from counters on artifacts that already
exist. `plan.md` already carries work units with stable semantic IDs; the
attempt, correction, review, and met-criteria counts hang off those rows. No
new file, status, or phase is introduced, because process weight is the cost
this change is also trying to avoid.

## Work Units

| ID | Objective | Depends on | File or subsystem scope | Verification |
|---|---|---|---|---|
| unit-01 | Add the Circuit Breakers section and the commit-acceptance rule | - | `skills/processed-beef-orchestrate/SKILL.md` | `sh tests/validate.sh`; section present and under line/byte limits |
| unit-02 | Add the Worker loop self-check and `Loop-suspected` report field | - | `skills/processed-beef-work-unit/SKILL.md` | `sh tests/validate.sh` |
| unit-03 | Add review termination and static/live command typing | - | `references/verification.md` | phrase inspection |
| unit-04 | Add the scheduling-boundary-not-evidence-boundary rule and unit-scoped attempt accounting detail | - | `references/scheduling.md` | phrase inspection |
| unit-05 | Sharpen the `state.md` trigger, record unit counters in the plan template, and add the completion acceptance gate | unit-01 | `references/artifacts.md`, `assets/plan.md` | phrase inspection |
| unit-06 | Restate the revised thresholds identically in every document that carries them | unit-01, unit-02, unit-04 | `README.md`, `docs/architecture.md`, `assets/agent-process.md`, `docs/integrations/*.md` | `grep` shows no stale `about 30`/`about 50`/`20 dispatches` wording |
| unit-07 | Add the contract check, behavioral scenarios, and changelog entry | unit-01..unit-06 | `tests/validate.sh`, `tests/behavioral.md`, `CHANGELOG.md` | `sh tests/validate.sh` passes |
| unit-08 | Completion transaction: archive the change, remove the retrospective | unit-07 | `docs/changes/`, `docs/processed-beef-session-review-2026-08-14.md` | `git status`; `sh tests/validate.sh` |

Only the Lead mutates plans and state. Semantic unit IDs are stable; execution
slices use `unit-<n>/attempt-<n>`.

## Progress

- [x] unit-01 Circuit Breakers section and commit-acceptance rule
- [x] unit-02 Worker loop self-check
- [x] unit-03 Review termination and static/live typing
- [x] unit-04 Scheduling boundary rule
- [x] unit-05 `state.md` trigger, plan template counters, completion gate
- [x] unit-06 Threshold restatement
- [x] unit-07 Contract check, behavioral scenarios, changelog
- [x] unit-08 Completion transaction

## Attempt Accounting

| Unit | Attempts | Corrections | Independent reviews | Acceptance criteria met |
|---|---|---|---|---|
| unit-01 | 1 | 0 | 0 | yes |
| unit-02 | 1 | 0 | 0 | yes |
| unit-03 | 1 | 0 | 0 | yes |
| unit-04 | 1 | 0 | 0 | yes |
| unit-05 | 1 | 0 | 0 | yes |
| unit-06 | 1 | 0 | 0 | yes |
| unit-07 | 1 | 0 | 0 | yes |
| unit-08 | 1 | 0 | 0 | yes |

## Pending User Decisions

- None.

## Acceptance-Criterion Evidence

| Acceptance criterion | Evidence |
|---|---|
| Unit-scoped attempt accounting survives succession | `skills/processed-beef-orchestrate/SKILL.md` Circuit Breakers; `references/scheduling.md` Attempt Accounting |
| Countable trip conditions | `skills/processed-beef-orchestrate/SKILL.md` Circuit Breakers |
| Short-circuit response and reset definition | `skills/processed-beef-orchestrate/SKILL.md` Circuit Breakers |
| Worker loop self-check on `decision-needed` | `skills/processed-beef-work-unit/SKILL.md` Scope, Stop and Report, Report Shape |
| One independent review per unit; frozen finding set | `references/verification.md` Review Protocol |
| Tests trace to acceptance criteria | `references/verification.md` Review Protocol |
| Threshold breach is not evidence invalidity | `references/scheduling.md` Context Limits |
| Revised thresholds stated identically | `grep -rn` across the nine documents carrying the wording |
| Commit requires accepted units | `skills/processed-beef-orchestrate/SKILL.md` Complete; `references/artifacts.md` Completion Transaction |
| Static/live command typing | `references/verification.md` Evidence Standard |
| `state.md` trigger | `references/artifacts.md` Conditional Artifacts |
| Validation passes | `sh tests/validate.sh` |

## Residual Risks

- The breaker is prompt-only. A role that does not maintain the plan counters
  can still loop; detection improves, enforcement does not. Accepted by the
  user for this release.
- The Lead's 20-call bound is tighter than the previous 50 and may increase
  succession frequency for inspection-heavy units. Watch over the next 2-3
  sessions; the 3-unit bound is the other side of the same measurement.
- Removing the Orchestrator's fixed dispatch cap trades a measurable proxy for
  judgement. Mitigated by keeping the deliberate-handover requirement and the
  preference for host context telemetry.

## Final Outcome

- Completed 2026-08-17. All acceptance criteria met; `sh tests/validate.sh`
  passes with the `check_circuit_breakers_contract` gate. The 2026-08-14
  retrospective was removed as planned; its durable findings survive in this
  spec and in behavioral scenarios 13-15.
