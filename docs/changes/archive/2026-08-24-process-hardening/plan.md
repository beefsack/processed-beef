# Plan: Process Hardening From Plasma Auto Tiler Retrospective

Ownership and approval:
- Owner: Lead
- Status: Approved 2026-08-24 by user and Orchestrator

## Technical Approach

Update existing authoritative portable process files and their templates. Record
the source-session evidence here rather than retaining a root-level report. The
P0 patch is documentation and validation work; host enforcement remains a
bounded P1 integration item.

### Approved 2026-08-25 Amendment

Retain every existing breaker and add a single causality-bound verification
repair for a regression introduced by the immediately preceding correction.
The repair restores a formerly passing canonical gate only; it cannot widen
behavior, alter an invariant, change ownership, route, oracle, fixture contract,
or acceptance mechanism. It is tracked as `verification_harness_repairs`, not as
a semantic attempt or ordinary correction. A second claimed repair, failed
restoration, new finding, serious unresolved finding, or semantic change parks
and escalates.

Track semantic attempts separately from pre-review corrections, finding-fix
corrections, verification/harness repairs, and preflight invalidity. Only a
semantic attempt increments no-progress. Verified `finding_closed`,
`canonical_gate_advanced`, or `acceptance_criterion_newly_met` resets that
streak. A repair records `canonical_gate_restored` and does not reset it.

Evidence binds each acceptance claim to a scoped source snapshot, canonical gate
ID, literal command or observation, expected baseline, output reference, and a
post-latest-change freshness result. The scoped snapshot includes the Git
revision, relevant diff, and relevant untracked inputs. Before source work,
dependency checks reject cycles and integration units lacking accepted
fixture/harness dependencies as `dispatch-invalid`. A graph correction remains a
semantic plan change.

Preservation uses one manifest and a canonical scoped status inventory covering
approved, modified, deleted, and untracked candidates. The manifest records
reason, owner, retention, cleanup disposition and deadline, plus separate
read/mutate authorization. Warning baselines are optional allowed patterns and
maximum counts; they cannot mask assertion, command, output, or live-safety
failures. Existing artifacts carry this information compactly by reference.

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

### Amendment Work Units

| ID | Objective | Depends on | Scope | Gate IDs | Review trigger |
|---|---|---|---|---|---|
| unit-05 | Implement correction-regression, counter, freshness, and dependency semantics with deterministic COSMIC and pointer-resize behavioral records | approved amendment | core policy files and behavioral record only | `gate.process-validation`, `gate.diff-hygiene`, `gate.behavioral-contract`, `gate.dependency-consistency`, `gate.evidence-freshness` | broad, subtle lifecycle and breaker change |
| unit-06 | Add plan/state/log template evidence, warning, and tracked/untracked preservation fields | unit-05 | template and artifact-reference surfaces only | `gate.process-validation`, `gate.diff-hygiene`, `gate.candidate-inventory` | preservation and destructive-action boundary |
| unit-07 | Align public README and architecture summaries with approved policy | unit-05, unit-06 | public documentation only | `gate.process-validation`, `gate.diff-hygiene` | Lead consistency inspection only |

### Amendment Gate Map

| Gate ID | Literal canonical command or observation | Type | Expected baseline |
|---|---|---|---|
| `gate.process-validation` | `sh tests/validate.sh` | static | exits 0; the active log records a historical pass and the amended diff requires a fresh run |
| `gate.diff-hygiene` | `git diff --check` | static | exits 0 with no whitespace errors |
| `gate.behavioral-contract` | Direct inspection of `tests/behavioral.md` scenarios 25-29 | static | each GREEN case enforces bounded repair, fresh evidence, preservation coverage, or parking |
| `gate.dependency-consistency` | Direct inspection of the approved work-unit dependency graph | static | acyclic; every integration unit names an accepted fixture/harness dependency |
| `gate.candidate-inventory` | `git status --short --untracked-files=all -- <approved-candidate-paths>` | static | manifest exactly classifies in-scope tracked and untracked candidates |
| `gate.evidence-freshness` | Direct comparison of each evidence row's source snapshot with its output reference | static | every acceptance claim is current after the latest relevant source change |

No amendment gate is live. `node tests/opencode-plugin.mjs` remains covered by
`gate.process-validation`; this amendment changes no plugin behavior.

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
- [x] unit-05 Correction-regression, lifecycle evidence, and behavioral records
- [x] unit-06 Template evidence and preservation alignment
- [x] unit-07 Public documentation alignment

## Amendment Startup VCS Policy

- Agent commits: no
- Agent pushes: no
- Staging owner: Lead at final completion only
- User commit required: yes
- Candidate preservation container: none unless triggered
- Cleanup owner: Lead

## Amendment Attempt Accounting

No amendment unit has inherited an active attempt. Historic accepted units are
not retroactively reclassified; their completion does not reset a live counter.

| Unit | Semantic attempts | Pre-review corrections | Finding-fix corrections | Verification/harness repairs | Independent reviews |
|---|---:|---:|---:|---:|---:|
| unit-05 | 1 | 1 | 1 | 0 | 1 |
| unit-06 | 1 | 0 | 1 | 0 | 1 |
| unit-07 | 1 | 0 | 0 | 0 | 0 |

### Amendment Change-Wide Ledger

| Semantic dispatches | Dispatch-invalids / host-preflight invalidity | Pre-review corrections | Finding-fix corrections | Verification/harness repairs | Independent reviews | Changed-kind resets | Broad gate runs | Worker tool-call proxy | Lead tool-call proxy | Findings closed | Canonical gates advanced | Criteria newly met | No-progress streak |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 3 | 1 | 1 | 2 | 0 | 2 | 0 | 0 | n/a | n/a | 2 | 0 | 2 | 0 |

`dispatch-invalid` increments only preflight invalidity. A semantic dispatch
with no qualifying progress credit increments the no-progress streak; a verified
finding closure, canonical-gate advancement, or newly met criterion resets it.
A `canonical_gate_restored` repair is visible evidence but is not a progress
credit. Repeated output, added test count, and rerunning an already passing gate
are not credits.

The Unit 05 Worker tool-call proxy was not host-reported. The one
`dispatch-invalid` is a pre-source correction packet that resolved against the
wrong repository root; it consumed no correction budget.

A fresh replacement correction Worker stopped before target-root verification
when its host tool context exposed excluded retrospective content. It made no
source edit or gate run; this pre-source host block does not alter Unit 05 or
change-wide counters.

The user-approved fresh target-bound correction changed only Scenario 28. It
consumed Unit 05's one pre-review correction and the change-wide pre-review
correction count. It did not create a semantic dispatch, progress credit, or
no-progress reset. Independent review 01 found one frozen Scenario 28 finding;
its one authorized finding-fix correction consumed the finding-fix budget. A
fresh Lead's one read-only confirmation accepted that finding as closed. It was
not a second independent review or another correction; the verified finding
closure reset the no-progress streak.

## Acceptance-Criterion Evidence

| Acceptance criterion | Evidence |
|---|---|
| P0 policy contract | scoped skills, references, templates, README, architecture, and OpenCode guide |
| Regression documentation | `tests/behavioral.md` scenarios 17-29; accepted Unit 05 Scenario 28 aligns with the approved changed-kind reset/escalation path while retaining repair anti-loopholes |
| Process validation | `sh tests/validate.sh` passed after the Unit 05 finding-fix correction on 2026-08-25 |
| Diff hygiene | `git diff --check` passed after the Unit 05 finding-fix correction on 2026-08-25; `git diff --cached --check` remains required only for final staged scope |
| Independent review | historic P0 review findings were resolved. Unit 05 independent review 01 found the Scenario 28 contradiction between denying an oracle-change reset and preserving the genuine changed-kind reset for fixture/oracle changes; its one finding-fix correction was confirmed closed by one read-only confirmation |
| Bootstrap migration correction | user-approved bounded correction aligned checkpoint, state, and pre-source host semantics; targeted confirmation passed |
| Unit 06 template evidence and preservation alignment | scoped actual diff covers the four approved template/reference paths; the finding-fix correction is confined to `assets/state.md` and `assets/log.md`; `sh tests/validate.sh` and `git diff --check` passed on 2026-08-25; the scoped candidate inventory classified both correction paths as modified tracked candidates with no scoped untracked candidate; direct observation confirms source snapshot/output correspondence, freshness, separate authorization, warning anti-masking, preservation manifest paths, reason, owner, retention, deadline, cleanup disposition, and irreversible-untracked-deletion escalation |
| Unit 06 independent review | review-01 returned one frozen finding. Finding-fix correction 01 was accepted after one read-only confirmation: `assets/state.md` and `assets/log.md` retain preservation manifest paths, reason, owner, and escalation that prohibits irreversible untracked deletion or overwrite on brief authorization alone; confirmation found the source/output/freshness, candidate classification, separate authorization, and warning anti-masking guards intact |
| Unit 07 public documentation alignment | actual diff is limited to `README.md` and `docs/architecture.md`; both concise summaries point to the normative skill and scheduling, verification, and artifact references, cover bounded correction-regression repair, work-kind progress, fresh evidence, dependency consistency, scoped tracked/untracked preservation, warning baselines, and compact ledgers, and preserve serial, context-default, correction/reset/parking, and host-portability language without compatibility or enforcement claims; `sh tests/validate.sh` and `git diff --check` passed on 2026-08-25 |

### Completion Evidence Snapshot

- Source snapshot: `02dfc894c406cdf0a051ca2916b24e3c3b46bd98` plus the scoped worktree
  diff inspected on 2026-08-25T21:40:20+10:00.
- Candidate inventory: 14 modified tracked paths in the approved policy,
  template, public-documentation, behavioral-record, and change-record scopes;
  one untracked candidate, `rationale-and-watchlist.md`, in this change
  directory; no unrelated candidate was present.
- Output correspondence: `gate.process-validation` (`sh tests/validate.sh`),
  `gate.diff-hygiene` (`git diff --check`), and the untracked rationale
  whitespace check (`git diff --no-index --check /dev/null
  docs/changes/2026-08-24-process-hardening/rationale-and-watchlist.md`) all
  passed at the snapshot time above.
- Freshness: these gates ran after the final policy and rationale content edits.
  This entry is completion record-keeping only; no policy source changed after
  the gates.

## Residual Risks

- The host cannot yet inject or verify dispatch metadata and child skill
  availability. This is the bounded P1 item above, not a claim that the plugin
  supplies enforcement.
- Policy remains dependent on parent discipline until a host integration exposes
  testable facts.
- The source COSMIC integration remains parked; this process patch does not
  claim project acceptance.

## Final Outcome

- Completed P0 process patch, approved by user and Orchestrator. The root
  retrospective was migrated into this standard change record and removed; this
  plan is retained as the archived completion record.
