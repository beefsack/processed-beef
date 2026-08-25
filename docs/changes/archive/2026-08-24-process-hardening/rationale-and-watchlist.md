# Rationale And Watchlist

This is an explicitly requested candid session retrospective. It is not an
approved change specification and it is not an implementation plan. The
recommendations below preserve the safety properties that stopped bad product
changes while reducing process cost for defects introduced by the process's own
corrections.

## Executive Assessment

The controls prevented genuine loops and unsafe claims, but they were
overbearing for correction-introduced, behavior-neutral verification defects.
Dispatch and context effort was disproportionate to the delivered product code.
The session did not show that serial execution, independent review, canonical
gates, or parking were wrong. It showed that the process classified a narrow
class of repairable harness and evidence regressions like semantic retries, and
then spent more orchestration effort proving that it was refusing to proceed
than the defect warranted.

## Timeline And Outcome

| Effort | Factual timeline | Current outcome |
|---|---|---|
| Native-effect alignment | Host KWin was `6.7.4` while the project assumed `6.7.3`. The correction updated `devenv.nix`, `devenv.lock`, and the dogfood script. The result was `347/347` tests, with the effect built, loaded, and rendered. Two restarts and many serial inquiries were spent on the false current-package assumption and a known-benign `find`/devenv warning stop. | KWin alignment complete and user committed. The canonical dogfood baseline is also recorded in the source-session gate evidence in `docs/changes/2026-08-24-process-hardening/plan.md`. |
| COSMIC successor | The pre-source plan had a circular dependency: Unit 01's public controller route depended on Unit 02's adapter. The plan and spec were corrected before source work. Unit 01 produced a fixture, received a pre-review correction, passed independent review, and used its sole finding-fix correction; that correction omitted a test import and triggered a trivial repair breaker. Parking then misclassified an untracked generated/new test as tracked baseline because it relied on `git diff`. A later pointer baseline exposed seven type errors. Preservation repaired the existing patch and deleted the omitted untracked file. | COSMIC successor parked with a verified single preservation patch and active source restored. Resetting the acceptance boundary would have broadened acceptance, so the work remained parked. The historical record distinguishes parked work, rejected candidates, and unaccepted integration in `docs/changes/2026-08-24-process-hardening/plan.md`. |
| Pointer resize | Source investigation showed that KWin owns divider selection, ratios, reflow, minimums, rounding, and final Escape; the controller is observation-only. Unit 01's native-fixture review correction contained an unsupported ordered-write assertion. A user-approved changed-kind reset reduced it to an identity-keyed final state plus ownership/count checks, which succeeded and was accepted. Unit 02's focused gates passed after a pre-review correction. Review found missing output, tile invalidation, and direct release. Its sole finding-fix correction failed typecheck because payload-free fixture signals were assigned to `TestSignal1<unknown>`. Three no-progress dispatches, the limit, and reset exhaustion parked the unit despite the defect being local test typing. | Pointer Unit 01 accepted; Unit 02 process-parked with an unaccepted diff still in the worktree because cleanup paused for this retrospective. |

The chronology above is bounded to the source-session evidence captured for this
change. The plan identifies the evaluated source commit, evidence-label
discipline, historical chronology, and attribution in
`docs/changes/2026-08-24-process-hardening/plan.md`.

## Quantitative And Process Cost

- Approximately 39 Lead task invocations or resumptions were counted from the session transcript. This is a manual transcript count, not host telemetry. The durable plan explicitly says that the complete Lead-session/task ledger was unknown, so the number is approximate rather than a repository measurement: `docs/changes/2026-08-24-process-hardening/plan.md`.
- `150000` is a configured context ceiling, not measured usage. The process defines countable tool-call or dispatch proxies when exact host telemetry is unavailable and calls the thresholds provisional: `skills/processed-beef-orchestrate/SKILL.md` and `skills/processed-beef-orchestrate/references/scheduling.md`.
- Serial execution made quota consumption observable and protected in-flight work, but restarts and successor handovers repeatedly reloaded coordination context. That tradeoff is intentional in the policy, yet the session exposed its latency and context cost: `skills/processed-beef-orchestrate/references/scheduling.md`.
- Artifact and preservation records improved recovery truth, but repeated plan, state, review, reset, stash, and handover ceremony accumulated around behavior-neutral defects. The protocol itself requires immediate records for blockers, findings, corrections, handovers, and commits: `skills/processed-beef-orchestrate/references/artifacts.md`.
- The process therefore delivered strong negative assurance and weak cost proportionality. The source plan records repeated broad gates, successions, reviews, rejected candidates, and unknown task telemetry rather than a clean accepted-product-to-dispatch ratio: `docs/changes/2026-08-24-process-hardening/plan.md`.

## What Worked

- **Serial safety.** One active Worker at a time prevented concurrent quota loss and gave Git and logs a recoverable boundary: `skills/processed-beef-orchestrate/SKILL.md`; `skills/processed-beef-orchestrate/references/scheduling.md`.
- **Role and preflight validation.** Actual/configured/parent role assertions, selector/persona separation, and pre-source rejection prevented work under malformed metadata: `skills/processed-beef-orchestrate/SKILL.md`; `tests/behavioral.md`.
- **Governance.** User-owned decisions, Orchestrator approval of semantic plan changes, and parking on governance conflict preserved authority boundaries: `skills/processed-beef-orchestrate/SKILL.md`; `skills/processed-beef-orchestrate/references/artifacts.md`.
- **Canonical gates.** Stable gate IDs, literal commands, expected baselines, and static/live typing made a wrong command diagnosable instead of silently accepted: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/references/scheduling.md`.
- **Source-version diagnosis.** The native alignment corrected the host/project KWin version mismatch rather than claiming a product failure; the process's insistence on current evidence and expected baselines supported that diagnosis: `skills/processed-beef-orchestrate/references/verification.md`; `docs/changes/2026-08-24-process-hardening/plan.md`.
- **No unsafe live mutation.** Live commands required prerequisites, approval, cleanup, and evidence; destructive actions required explicit authorization, and irreversible untracked destruction escalated: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/references/scheduling.md`.
- **Pre-start circular-dependency catch.** Stable unit dependencies and fixture-before-integration contracts provided a place to catch the COSMIC Unit 01/Unit 02 cycle before source work: `skills/processed-beef-orchestrate/assets/plan.md`; `skills/processed-beef-orchestrate/SKILL.md`.
- **Independent review.** Review found real ownership, output, invalidation, release, and fixture defects instead of treating passing focused gates as acceptance: `skills/processed-beef-orchestrate/references/verification.md`; `docs/changes/2026-08-24-process-hardening/plan.md`.
- **Preservation intent.** Rejected work had a bounded preservation model with manifest, owner, retention, and cleanup disposition, which supported recovery rather than silent loss: `skills/processed-beef-orchestrate/references/artifacts.md`; `docs/changes/2026-08-24-process-hardening/plan.md`.

## What Failed Or Cost Too Much

- **Severity-blind correction budgets.** A missing import and a local fixture typing error consumed the same class of correction budget as semantic implementation problems. The current rules distinguish correction classes, but not behavioral severity within a class: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/SKILL.md`.
- **Correction regressions looked like semantic retries.** The process had no bounded path for restoring a gate broken by the immediately preceding correction, so a behavior-neutral repair was treated as another attempt or as an unsafe exception: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/references/scheduling.md`.
- **No-progress was too coarse.** The counter moved only when a whole acceptance criterion moved, so verified finding closure, gate restoration, and harness repair earned no progress credit even when they reduced risk: `skills/processed-beef-orchestrate/SKILL.md`; `skills/processed-beef-orchestrate/assets/plan.md`.
- **Change-wide reset exhaustion was safe but blunt.** A reset changed the acceptance mechanism, evidence boundary, fixture/oracle, or ownership, but one narrow local defect could consume the same scarce reset path as a substantive design failure: `skills/processed-beef-orchestrate/SKILL.md`; `skills/processed-beef-orchestrate/assets/state.md`.
- **Units were sometimes too coarse.** A fixture, production integration, snapshot proof, and multiple invariants in one unit multiplied review and correction coupling; the process itself says to split cleanly separable work before starting: `skills/processed-beef-orchestrate/references/scheduling.md`; `docs/changes/2026-08-24-process-hardening/plan.md`.
- **Artifacts and handovers repeated too much context.** Recovery truth was valuable, but repeated successor packets, reset records, and artifact updates became ceremony around parked or locally repairable work: `skills/processed-beef-orchestrate/references/scheduling.md`; `skills/processed-beef-orchestrate/references/artifacts.md`.
- **Known-warning stops were not baseline-aware.** A known-benign `find`/devenv warning stopped progress instead of being declared as an expected warning with a bounded assertion about the real gate result: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/assets/plan.md`.
- **Evidence freshness failed.** Reports could retain a formerly valid gate claim after a correction changed the source or output, while the acceptance machinery did not require a fresh source-output correspondence check: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/references/scheduling.md`.
- **Tracked/untracked reconciliation was wrong.** `git diff` did not represent the untracked generated/new test that mattered to the parked candidate, causing baseline misclassification and a later preservation repair: `skills/processed-beef-orchestrate/references/artifacts.md`; `tests/behavioral.md`.
- **Mechanical defects reached user escalation.** The user had to resolve or absorb false package assumptions, warning stops, omitted imports, and local typing failures that should have been mechanically reconciled under canonical gates: `skills/processed-beef-orchestrate/references/scheduling.md`; `docs/changes/2026-08-24-process-hardening/plan.md`.
- **Status and counter inconsistencies appeared.** The chronology records inconsistent role-line enforcement, invalid preflights counted as implementation attempts, reset-local counters, and no complete durable task ledger: `docs/changes/2026-08-24-process-hardening/plan.md`; `skills/processed-beef-orchestrate/references/scheduling.md`.

## Root-Cause Classification

### Policy Design Flaws

- Correction budgets lacked a severity and causality distinction for a defect introduced by the immediately preceding correction.
- No-progress accounting recognized only whole acceptance-criterion movement, not verified finding closure or canonical-gate advancement.
- Gate evidence lacked an explicit freshness and source-output correspondence field.
- Preservation status treated tracked `git diff` as an adequate candidate inventory and did not make tracked/untracked coverage explicit.
- Fixture-before-integration dependencies were represented in plans but lacked a mandatory pre-start consistency lint.
- Artifact and succession rules optimized for durable recovery but did not provide a compact path for behavior-neutral repairs.

These are policy design flaws because they predictably converted local verification defects into lifecycle exhaustion. The governing policy explicitly makes counts survive succession, parks after three no-progress dispatches, and treats a second changed-kind reset as a stop: `skills/processed-beef-orchestrate/SKILL.md`; `skills/processed-beef-orchestrate/references/scheduling.md`.

### Agent Execution Errors

The process should not receive blame for these concrete execution mistakes:

- The initial false KWin package-version assumption.
- The known-benign `find`/devenv warning stop.
- The correction that omitted a test import.
- The unsupported ordered-write assertion.
- The wrong `TestSignal1` typing for payload-free fixture signals.
- Stale or incomplete tracked/untracked baseline handling.

These were agent, brief, or reconciliation errors. Canonical-gate inspection, current evidence, and Lead inspection are specifically intended to catch them: `skills/processed-beef-orchestrate/references/verification.md`; `docs/changes/2026-08-24-process-hardening/plan.md`. The right response is better classification and mechanical repair, not removal of review or evidence requirements.

### Necessary Safety Stops

The lifecycle breaker on the unaccepted pointer Unit 02 was a necessary safety stop. The unit had an unaccepted diff, unresolved review findings, and a failed correction; continuing with another semantic patch would have weakened acceptance discipline. The process-parked result is therefore correct even though the local type defect exposed an overbearing policy path: `skills/processed-beef-orchestrate/SKILL.md`; `skills/processed-beef-orchestrate/references/verification.md`.

The policy contributed to the overbearing result by counting the correction-introduced, behavior-neutral type defect as a finding-fix failure with no narrowly bounded regression repair. That contribution does not make the breaker itself wrong. The distinction is important: safety stops should remain, while the eligible repair path before parking becomes more precise.

## Prioritized Improvements

The following are proposals for `processed-beef` only. They do not authorize or
implement any Plasma project change.

### P0

- **Add one `correction-regression repair` opportunity.** Normative language:
  `ALLOW exactly one bounded correction-regression repair when and only when a defect was introduced by the immediately preceding correction; restrict it to restoring canonical-gate validity, prohibit semantic widening, and confirm the result against the original finding set.` The repair must not reset implementation, review, or changed-kind counters. This extends the existing one-pre-review/one-finding-fix distinction without creating an open-ended loop: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/SKILL.md`.
- **Split no-progress accounting by work kind.** Proposed ledger fields:
  `semantic_attempts`, `pre_review_corrections`, `finding_fix_corrections`,
  `verification_harness_repairs`, and `host_preflight_invalidity`. Only a
  semantic implementation attempt increments the semantic no-progress streak;
  every category remains visible and bounded. `dispatch-invalid` remains
  non-implementation work: `skills/processed-beef-orchestrate/SKILL.md`; `skills/processed-beef-orchestrate/assets/plan.md`.
- **Credit verified progress below whole-criterion completion.** Proposed
  pseudocode:
  `progress = finding_closed || canonical_gate_advanced || acceptance_criterion_newly_met`.
  Record each credit with the gate/finding and current evidence; do not count
  added tests or repeated output alone. This preserves the existing warning that
  rising test count is not acceptance progress: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/assets/plan.md`.
- **Require gate freshness and source-output correspondence.** Every Worker
  report should include `source_revision_or_hash`, `gate_id`, literal command,
  `output_revision_or_artifact`, baseline, and whether the gate ran after the
  latest correction. A stale claim is incomplete evidence, not acceptance:
  `skills/processed-beef-orchestrate/references/verification.md`;
  `skills/processed-beef-orchestrate/references/scheduling.md`.
- **Lint fixture-before-integration dependencies before dispatch.** Proposed
  pre-start check:
  `for integration in units; require accepted(fixture_dependency) before source_work(integration)`.
  Reject cycles and any integration unit whose fixture contract is not accepted;
  return `dispatch-invalid` before consuming implementation budget:
  `skills/processed-beef-orchestrate/SKILL.md`;
  `skills/processed-beef-orchestrate/assets/plan.md`.
- **Make scoped status inventory tracked and untracked candidates.** Before
  preservation or cleanup, record approved, modified, deleted, and untracked
  candidate paths from a canonical scoped status command. The single preservation
  container manifest must cover both tracked and untracked candidates, with owner,
  reason, retention, and cleanup disposition:
  `skills/processed-beef-orchestrate/references/artifacts.md`;
  `tests/behavioral.md`.

### P1

- **Make test-only and harness repairs proportionate while retaining invariant escalation.** A repair that changes only tests, fixtures, typing, or evidence plumbing may use the bounded correction-regression path when the original production invariant and finding set are unchanged. Ownership, public-route, snapshot, rollback, and other invariant failures still require ordinary review and escalation. This follows the existing distinction between targeted tests, proportionate mechanical checks, and bounded fixture contracts: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/SKILL.md`.
- **Declare known warnings in gate baselines.** Add an optional baseline field such as `known_warnings: ["find: ...", "devenv: ..."]`, with a stable expected count or pattern and a failure rule for new warnings. A warning declaration cannot suppress a failed assertion or live-safety prerequisite: `skills/processed-beef-orchestrate/references/verification.md`; `skills/processed-beef-orchestrate/assets/plan.md`.
- **Reduce artifact and succession overhead without weakening recovery.** Replace repeated narrative handovers with compact references to the plan ledger, current diff, gate evidence, and one preservation manifest. Retain immediate records for accepted units, blockers, findings, corrections, handovers, and commits; do not remove recovery truth or independent inspection: `skills/processed-beef-orchestrate/references/artifacts.md`; `skills/processed-beef-orchestrate/references/scheduling.md`.
- **Add deterministic process tests for COSMIC and pointer-resize failure patterns.** Scenarios should deterministically exercise a fixture/integration cycle, a correction that breaks only a test import, an untracked candidate omitted by `git diff`, an unsupported ordered-write assertion, and a payload-free signal typecheck failure. They should assert bounded repair, fresh evidence, preservation coverage, and parking for unresolved serious findings: `tests/behavioral.md`; `docs/changes/2026-08-24-process-hardening/plan.md`.

### P2

- **Expose a compact lifecycle metrics surface.** Add counters and classifications
  to the existing plan ledger rather than creating a parallel tracker. Keep the
  semantic unit/change ownership and succession persistence, but expose enough
  data to distinguish safety stops from process-induced churn:
  `skills/processed-beef-orchestrate/references/artifacts.md`;
  `skills/processed-beef-orchestrate/assets/plan.md`.
- **Make candidate lifecycle ownership explicit.** Give every preservation
  manifest a cleanup owner and disposition deadline while keeping the one-container
  stop condition. This addresses stale worktree ambiguity without authorizing
  unreviewed deletion: `skills/processed-beef-orchestrate/references/artifacts.md`;
  `skills/processed-beef-orchestrate/references/scheduling.md`.
- **Use risk-tiered gate execution.** Focused gates remain per unit, while full
  suite, dogfood, package, and deterministic build gates run at named integration
  checkpoints unless changed risk justifies another run. This reduces repeated
  broad-gate cost without weakening final evidence: `skills/processed-beef-orchestrate/references/verification.md`;
  `docs/changes/2026-08-24-process-hardening/plan.md`.

## Anti-Loophole Constraints

The bounded repair is a safety valve, not permission to keep patching.

- **Eligibility and preconditions:** The immediately preceding correction must
  have changed the relevant test, fixture, harness, gate, or evidence path; the
  canonical gate must have been valid immediately before that correction; the
  current failure must be reproducible; the diff must localize the regression to
  that correction; and the original independent-review finding set must remain
  unchanged. The Lead records the before/after source revision and gate evidence:
  `skills/processed-beef-orchestrate/references/verification.md`.
- **Single-use scope:** Exactly one `correction-regression repair` is permitted
  for that correction event and finding set. It may restore only the prior
  canonical-gate-valid state. It cannot increase acceptance scope, alter a
  product invariant, change ownership, add a new acceptance mechanism, or consume
  a fresh semantic attempt: `skills/processed-beef-orchestrate/SKILL.md`;
  `skills/processed-beef-orchestrate/references/scheduling.md`.
- **Forbidden cases:** No repair may relabel a semantic attempt, bypass an
  unresolved serious finding, repair a new finding, widen a fixture contract,
  replace a public route with a private one, weaken an oracle, suppress a warning
  outside the declared baseline, or delete untracked data without explicit
  authorization. The existing destructive-action rule and serious-finding
  escalation remain binding: `skills/processed-beef-orchestrate/references/scheduling.md`;
  `skills/processed-beef-orchestrate/references/verification.md`.
- **Mandatory evidence:** Before repair, capture the original finding set, prior
  passing gate, correction diff, failing gate, and scoped status. After repair,
  capture the changed paths, fresh source-output correspondence, canonical gate,
  original finding recheck, and unchanged production behavior boundary. Reports
  without current evidence are not accepted: `skills/processed-beef-orchestrate/references/verification.md`.
- **Result:** If the repair restores the gate and confirms the original finding
  set, it is a bounded verification repair and the unit continues only within
  existing budgets. If it fails, reveals semantic change, or encounters a second
  alleged correction regression, the unit parks and escalates with the invariant
  blocker, attempts, accepted/unaccepted state, and reset options. The existing
  breaker remains the final stop: `skills/processed-beef-orchestrate/SKILL.md`.

## Phased Implementation Plan

This is a suggested plan for `processed-beef` itself only. No phase is being
implemented by this retrospective.

1. **Phase 0 - model the failures.** Add deterministic behavioral scenarios for
   the COSMIC and pointer-resize patterns, and agree on the evidence fields for
   a correction regression. Use the existing scenario format and canonical-gate
   baseline model: `tests/behavioral.md`; `skills/processed-beef-orchestrate/references/verification.md`.
2. **Phase 1 - ledger and validation.** Extend the plan/state ledger with work-kind
   counters, sub-criterion progress credits, freshness fields, and a pre-start
   dependency/acceptance lint. Preserve stable semantic IDs and change-wide
   accounting across succession: `skills/processed-beef-orchestrate/assets/plan.md`; `skills/processed-beef-orchestrate/references/scheduling.md`.
3. **Phase 2 - bounded repair and status.** Implement the single-use
   `correction-regression repair` protocol, canonical scoped tracked/untracked
   status, known-warning declarations, and preservation manifest validation.
   Keep explicit destructive authorization and one-container escalation:
   `skills/processed-beef-orchestrate/references/artifacts.md`;
   `skills/processed-beef-orchestrate/references/scheduling.md`.
4. **Phase 3 - migrate and observe.** Update templates, behavioral contracts, and
   compact handover/report guidance; run the next two to three sessions under
   both old-state migration checks and the new metrics. Keep a migration note for
   existing plans with absent counters, stale baselines, or untracked candidates;
   do not reset their inherited safety counts: `skills/processed-beef-orchestrate/references/artifacts.md`;
   `skills/processed-beef-orchestrate/references/scheduling.md`.
5. **Phase 4 - review and adjust.** Review metrics and deterministic scenarios
   independently, then adjust thresholds only from observed evidence. Do not
   remove breakers because a bounded repair succeeds; verify that serious
   findings still park and escalate: `skills/processed-beef-orchestrate/references/verification.md`;
   `skills/processed-beef-orchestrate/SKILL.md`.

## Next 2-3 Session Metrics

Record these in the existing change-wide ledger or a compact linked report, not
as host telemetry claims:

- Dispatches per accepted unit.
- User escalations by class: product, governance, host/preflight, evidence, and mechanical repair.
- Correction-regression repairs used and succeeded.
- Acceptance criteria moved, findings closed, and gates advanced.
- Context/tool proxies: Worker tool calls, Lead tool calls, dispatches, resumptions, and handovers; never infer exact token usage from the configured ceiling.
- False parking rate: units parked despite a subsequently verified behavior-neutral repair, divided by parked units.
- Preservation omissions: candidate paths absent from the preservation manifest, separated into tracked and untracked.
- Gate-freshness failures: reports whose claimed evidence predates the latest source or correction change.

These metrics extend the existing persisted counters rather than replacing them:
`skills/processed-beef-orchestrate/assets/plan.md`;
`skills/processed-beef-orchestrate/references/scheduling.md`.

## Bottom Line

Keep serial execution, role checks, independent review, canonical gates,
preservation, and lifecycle breakers. Add a causality-aware, single-use repair
for correction-introduced verification regressions; make progress and evidence
more granular; inventory untracked candidates; and measure the cost. The desired
result is not fewer safety stops. It is fewer false parks and fewer user
escalations for defects that did not widen behavior.
