# Plan: Process Hardening From Plasma Auto Tiler Retrospective

Ownership and approval:
- Owner: Lead
- Status: Approved 2026-08-24 by user and Orchestrator

## Technical Approach

Update existing authoritative portable process files and their templates. Record
the source-session evidence here rather than retaining a root-level report. The
P0 patch is documentation and validation work; host enforcement remains a
bounded P1 integration item.

## Source Session Evidence

- Report target: `processed-beef` at `01cae7ca8a324c1e68383fe16210b0856fb62cab`.
- Evaluated source: `plasma-auto-tiler` at parked commit
  `0726537a9da5322611495df73be16463d8380c27` (`docs: park COSMIC fixture foundation`).
- Scope: resumed controller-source-split completion and subsequent COSMIC
  directional-movement proposal, implementation, resets, and parked state on
  2026-08-24.
- Evidence labels: `A` is inspected repository/Git evidence, `S` is
  user-supplied chronology, and `I` is an inference. Recommendations are not
  findings.

### Current Accepted, Rejected, and Parked State

| Category | State and evidence |
|---|---|
| Accepted COSMIC seam | `012351e4ef2b7b0765adedec498cce6e305cb513` - `feat: add COSMIC directional movement seam` |
| Accepted COSMIC planner | `b8731e4e17275ef51fbce63e7bdb6aa0947e9238` - `feat: add COSMIC directional movement planner` |
| Accepted transaction safety | `eebd535d9e7f7b32c261f8c03f24309226768fb7` - `feat: add COSMIC runtime transaction safety` |
| Historical reset record | `f7683563d32c6c4566cf971c91defe21a7aa7998` - 03C/03D reset, never dispatched |
| Parked record | `0726537a9da5322611495df73be16463d8380c27` - Unit 03E parked |
| Rejected candidates | Four named candidate stashes recorded below |
| Unaccepted integration | No accepted controller integration proves COSMIC R1-R4 or full re-decoded snapshot restoration |
| Blocked work | Unit 04 depends on parked 03E; Unit 05 depends on Unit 04 |

Unit 03E directly constructed `createDirectionalMovementRuntime` with a
replacement environment. That was prohibited production behavior integration,
not fixture evidence. It froze with no correction, reset, review, or production
integration dispatch permitted. The source repository had three unrelated
untracked paths, `CMakeFiles/`, `Project Technical Report and Implementation
Plan.md`, and `test-output`, which were not changed for this evidence record.

### Session Chronology

| Phase | Event, consequence, and classification |
|---|---|
| Startup | Root activated the process skill while some child reports said it was unavailable; depth two and selectors existed. This was a host-integration mismatch. |
| Startup | User selected `lead-openai`/`worker-openai`, required serial work, then changed autonomous and VCS policy mid-session. This was a process/briefing failure. |
| Controller split | Unit 04 recovered an inherited cancelled attempt and dirty candidate with correction and review; preservation worked. |
| Controller split | Original Unit 05 spent two attempts on malformed parent/configured-role/untracked-path preflights before source work; 05A/05B reset local counters. Process amplified cost. |
| Controller split | Host investigation found valid configuration; `worker-openai`, model, persona, and process role had been conflated, causing false stops. |
| Controller split | Unit 06 repeated the false mismatch; missing role lines were inconsistently blocking versus compliance debt. |
| Controller split | Full 965/91 tests, dual typechecks, 347 dogfood, deterministic builds, reviews, artifacts, commits, and successions were repeated. Assurance was strong but broad-gate churn was high. |
| COSMIC proposal | A read-only proposal task was cancelled/stuck; user ended autonomous mode and required stage-only, no-agent-commit/push behavior. |
| COSMIC setup | User committed approved spec, plan, and backlog link in `05b5487`; durable scope existed before implementation. |
| Unit 01 | Worker used `scripts/start-test.test.sh` (255 assertions), not canonical `scripts/dogfood-install.test.sh` (347), and escalated a local reconciliation as a decision. |
| Unit 02 | A narrow pure planner completed without review or reset. |
| Unit 03 | One broad runtime-integration unit mixed empty-output R4, maximized guard, partial rollback, duplicate occupancy, and legacy fallback defects. Breaker correctly stopped it. |
| Reset 1 | 03 split into 03A transaction safety and 03B integration closure. 03A corrected six findings and was accepted. |
| 03B | Correction reduced keyboard evidence while still lacking R1-R4 and snapshot proof; breaker correctly froze it. |
| Reset 2 | 03C/03D were committed as a plan-only reset then superseded before dispatch, adding ceremony without evidence. |
| Checkpoint recovery | Private runtime construction/replacement bypassed public routing; correction restored routing but recursive children remained non-stateful. |
| Fixture investigation | Established `Harness`, `TestTile`, `TestWindow`, `attachTileWriter`, and `installDwindleSplitter` precedent was found. Read-only rejected-candidate inspection versus mutation needed clearer policy. |
| Final reset | 03E made one fixture-only attempt but constructed production runtime with replacement callbacks; it parked and produced a fourth rejected stash. |

### Quantified Churn

| Measure | Count or result |
|---|---:|
| Controller executable semantic units accepted | 8 |
| Controller Worker attempts in original 05 and Units 04-07 | 9 |
| Controller cancellations in that table | 1 |
| Controller malformed preflight attempts | At least 3 |
| Controller independent reviews | 5 |
| Controller breaker resets | 1 |
| COSMIC dispatched implementation attempts | 7 |
| COSMIC corrections | 5 |
| COSMIC independent reviews | 2 |
| COSMIC breaker-frozen units | 4 |
| COSMIC changed-kind resets | At least 3 |
| COSMIC superseded-before-start units | 2 |
| Rejected candidate stashes | 4 |
| Documented broad COSMIC gate result sets | At least 3 |
| Controller full-suite baselines for Units 04, 05A, 05B, 06, 07 | At least 5 |
| Deterministic build pairs for those units | At least 5 pairs |
| Policy transitions | 2: autonomous-to-normal and no-agent-commit/push |
| Lead sessions, task dispatches, task IDs, token use, tool calls | Unknown; no complete durable ledger |

### Attribution and Lessons

Process/skill failures were counted invalid preflights as implementation attempts,
kept counters and resets local to units, exhausted correction/review paths on
fixture work, conflated role fields, replayed policy in briefs, repeated broad
gates, required reset documentation/commit/stash ceremony, lacked candidate
cleanup ownership, and had no change-wide stop telemetry. The artifact protocol
retained recovery truth, but its immediate records accompanied each reset and
increased historical clutter.

Agent/brief failures included treating selector/persona as a role mismatch,
inconsistent role-line enforcement, using the wrong dogfood command, an original
Unit 03 that mixed transaction safety, composition, fixtures, and snapshot proof,
weakened 03B keyboard evidence, private runtime bypass, non-stateful fixture
children, and 03E's fixture-scope breach. These candidate defects were not all
process-caused; the process exposed and stopped them.

Host limitations were real: the plugin registers skills only; it does not
activate workflow, create role agents, set depth/permissions, inject dispatch
metadata, or prove child skill availability. OpenCode owns selector/model
routing, and a child cannot prove it. Serial execution remains an intentional
quota-safety tradeoff, not a defect. The required depth-two configuration was
documented, but current project/global host configuration could not be
independently recovered; a historical backup was not active-configuration proof.

Genuine project complexity included opaque native split shape/cardinality,
geometry-local ordering, controller-only routing, stateful native fixtures,
multi-step recovery, and complete re-decoded snapshots. The transaction and
occupancy findings were product-safety defects the process correctly prevented.

What worked: breakers prevented incomplete candidates shipping; independent
review found material defects; rejected candidates were preserved; controller
05A/05B demonstrated a useful reduced-scope reset; static gates caught weakened
evidence and scope violations; and Lead inspection, rather than a passing test
summary, rejected 03E's prohibited integration. User approval created a
recoverable parked boundary instead of a hidden dirty candidate.

What failed or amplified cost: invalid preflights consumed implementation budget,
reset-local counters enabled relabeling, fixture work exhausted correction budget,
role semantics were ambiguous, broad gates repeated, and a user had to impose the
final no-further-reset stop. The record does not attribute native fixture
complexity, rollback requirements, or original implementation defects to process.

### Preserved Identifiers and Gate Evidence

| Rejected stash | Association |
|---|---|
| `06f5ab76826927394ae46e529f746f3b703e7c8b` | rejected cosmic stateful fixture foundation, Unit 03E |
| `2c15d895b128200070f7f772e2f98b6e8fe96b90` | rejected cosmic checkpointed integration fixture candidate |
| `f2553e69eefe0433ab0c1ae2a79c8c97756a18f4` | rejected cosmic Unit 03B candidate |
| `8578bbf4f0e4e953be8c0128506c051de863fe0f` | rejected cosmic Unit 03 candidate |

| Gate | Recorded command and evidence |
|---|---|
| Focused runtime | `node --test kwin/dist/tests/directional-movement-runtime.test.js`: 11 tests, one suite, no failures/skips for 03A |
| Full suite | `npm --prefix kwin test`: COSMIC baseline 965 tests/91 suites; 03A 990/95, no failures/skips |
| Typecheck | `npm --prefix kwin run typecheck`: dual typechecks required |
| Dogfood | `bash scripts/dogfood-install.test.sh`: canonical 347 assertions, no failures |
| Package | `bash scripts/build-kpackage.test.sh` |
| Determinism | two `npm --prefix kwin run build` runs plus `sha256sum kwin/contents/code/main.js`; 03A hash `b90f9b23f9e2e290f7b581acaef9743a4ff48c320e895f7a06fa7de005d074dc` |
| Hygiene | `git diff --check` |

The erroneous Unit 01 command was `scripts/start-test.test.sh` with 255
assertions. No stable COSMIC task IDs, full Lead-session ledger, or token total
was persisted; do not infer them from commits, units, or stashes.

## Work Units

| ID | Objective | Scope | Evidence |
|---|---|---|---|
| unit-01 | Define dispatch-invalid and process-role metadata | role skills, scheduling, OpenCode guide | behavioral scenarios 17-18; `sh tests/validate.sh` |
| unit-02 | Separate correction classes and change-wide breakers | orchestrate skill, templates, verification | review and bootstrap correction record |
| unit-03 | Add fixture, gate, VCS, preservation, and compact-brief policy | references, templates, README/architecture | plan evidence-map templates and behavioral scenarios |
| unit-04 | Preserve source-session evidence and P1 follow-up in this change | this change directory | traceable sections above and below |

## P0-P2 Recommendations and Backlog

| Priority | Work item | Acceptance scenario |
|---|---|---|
| P0 | Change-wide breaker/reset ledger | Descendants cannot obtain fresh budget without a genuinely new acceptance mechanism. |
| P0 | Dispatch classification and role metadata | Missing role metadata and `worker-openai` plus OpenCode persona yield `dispatch-invalid`, not false role mismatch. |
| P0 | Brief/gate validation | A `start-test.test.sh` brief cannot replace a plan dogfood gate. |
| P0 | Review correction protocol | Review findings retain one finding-fix correction and confirmation is not review two. |
| P1 | Fixture-contract workflow | Stateful recursive children and snapshot/re-decode proof are accepted before controller/runtime integration. |
| P1 | Promotion/Lead-forfeit policy | Repeated Worker-invalid results can escalate without uncontrolled Lead implementation. |
| P1 | Risk-tier gates | Pure units run focused gates; full suite/dogfood/two-build gates run once at integration checkpoint. |
| P1 | Startup VCS and skill preflight | No-agent-commit policy and child skill availability are recorded before first dispatch. |
| P1 | Host integration: metadata and child skill availability | Host-observable metadata is injected/verified parent-side; child never self-proves selector/model; unavailable skill yields `dispatch-invalid`; a fake-host test covers it. Current plugin cannot provide this safely. |
| P2 | Candidate lifecycle | One recovery branch/worktree/patch bundle has owner, reason, retention, expiry, disposition, and separate read/mutate authorization. |
| P2 | Metrics and compact briefs | Plans expose invalid dispatch/no-progress counts without replaying policy. |

## Progress

- [x] unit-01 Dispatch and role metadata policy
- [x] unit-02 Correction, review, reset, and no-progress policy
- [x] unit-03 Fixture, gate, VCS, preservation, and brief policy
- [x] unit-04 Source-session evidence migration

## Acceptance-Criterion Evidence

| Acceptance criterion | Evidence |
|---|---|
| P0 policy contract | staged skills, references, templates, README, architecture, and OpenCode guide |
| Regression documentation | `tests/behavioral.md` scenarios 17-24 |
| Process validation | `sh tests/validate.sh` passes |
| Diff hygiene | `git diff --check` and `git diff --cached --check` pass |
| Independent review | one independent review found correction-breaker, validation, gate, telemetry, and fixture issues; one finding-fix correction resolved them |
| Bootstrap migration correction | user-approved bounded correction aligned checkpoint, state, and pre-source host semantics; targeted confirmation passed |

## Residual Risks

- The host cannot yet inject or verify dispatch metadata and child skill
  availability. This is the bounded P1 item above, not a claim that the plugin
  supplies enforcement.
- Policy remains dependent on parent discipline until a host integration exposes
  testable facts.
- The source COSMIC integration remains parked; this process patch does not
  claim project acceptance.

## Final Outcome

- Accepted P0 process patch, approved by user and Orchestrator. The root
  retrospective was migrated into this standard change record and removed.
