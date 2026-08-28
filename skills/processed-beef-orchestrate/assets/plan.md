# Plan: <title>

Ownership and approval:
- Owner: Lead
- Status: Pending Orchestrator approval | Approved <date> by <approver>

Semantic sections - Technical Approach, Work Units, Pending User Decisions -
need Orchestrator approval before each edit. Record-keeping sections -
Progress, Attempt Accounting, Acceptance-Criterion Evidence, Residual Risks,
Final Outcome - are Lead-owned and edited directly.

## Technical Approach

<approach>

Evidence scope and authorization:
- Source snapshot: <identifier / timestamp / scope>
- Output correspondence: <output reference linked to the source snapshot>
- Post-latest-change freshness: <observation>
- Read authorization: <authority / scope / expiry>
- Mutate authorization: <authority / scope / expiry, or none>
- Warning baseline: <informational baseline; never masks failed assertions,
  nonzero commands, missing output, or unmet live-safety prerequisites>

## Work Units

| ID | Objective | Depends on | File or subsystem scope | Gate ID and literal canonical command (static or live) | Expected baseline |
|---|---|---|---|---|---|
| unit-01 | <objective> | - | <scope> | `gate.<id>`: `<literal canonical command>` | <semantic pass condition; exact count only if contractual> |
| unit-02 | <objective> | unit-01 | <scope> | `gate.<id>`: `<literal canonical command>` | <semantic pass condition; exact count only if contractual> |

Only the Lead mutates plans and state. Semantic unit IDs are stable; execution
slices use `unit-<n>/attempt-<n>`.

## Work-Kind Ledger

| Work kind | Scope | Read authorization | Mutate authorization | Evidence |
|---|---|---|---|---|
| <read or mutate> | <approved scope> | <authority / scope / expiry> | <authority / scope / expiry, or none> | <reference> |

## Scoped Candidate Inventory

- Scope: <approved paths only>

| Candidate | Classification (`tracked` or `untracked`) | Evidence / disposition |
|---|---|---|
| <path> | <tracked or untracked> | <reference> |

## Progress

- [ ] unit-01 <objective>
- [ ] unit-02 <objective>

## Attempt Accounting

Counts belong to the semantic unit and change and survive Worker replacement,
Lead succession, and relabeled briefs. A third semantic attempt on one
unit trips its unit breaker. A second pre-review implementation correction trips
the pre-review breaker; a second finding-fix correction for one independent
review finding set trips the finding-fix breaker. Confirmation is neither a
correction nor a review. Only one changed-kind reset is allowed across all
descendants; a second parks and escalates. A real reset changes the acceptance
mechanism, evidence boundary, fixture/oracle, or ownership, not names or labels.

A unit is listed only once one of its counts exceeds 1; a unit that completed
first try is absent, and absence means all counts are 1 or lower. State "no
entries" when the table is empty.

| Unit | Semantic attempts | Pre-review corrections | Finding-fix corrections | Independent reviews |
|---|---:|---:|---:|---:|
| <unit-id> | 2 | 1 | 0 | 0 |

### Change-Wide Ledger

| Implementation dispatches | Semantic attempts | Dispatch-invalids | Pre-review corrections | Finding-fix corrections | Independent reviews | Changed-kind resets | Broad gate runs | Worker tool-call proxy | Lead tool-call proxy | Acceptance criteria moved | No-progress streak |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

Implementation dispatches count every valid Worker or live-runner dispatch
intended to perform semantic work, including bounded fixture/harness work.
Semantic attempts count only dispatches where approved semantic source changes
or the first target live scenario or intended host mutation begins. Tool,
environment, dependency, working-directory,
output-containment, evidence-path, and record-reconciliation failures before
that boundary are mechanical events; they consume no semantic, correction,
review, reset, packet-repair, or no-progress budget. `dispatch-invalid` is
counted separately and does not consume implementation budget. Broad gate runs
count each invocation of a gate marked broad in the work-unit table. Worker and
Lead tool-call proxies count their tool invocations for this change. Acceptance
criteria moved counts criteria newly met since the prior semantic attempt. The
no-progress streak
increments only after a semantic attempt and resets on `finding_closed`,
`canonical_gate_advanced`, or `acceptance_criterion_newly_met`. Three semantic
attempts without one of those credits park and escalate. At most one changed-
kind reset is permitted across this change. A
second parks and escalates. Record the reset's changed acceptance mechanism,
evidence boundary, fixture/oracle, or ownership.

Every implementation brief cites the plan-owned gate ID, literal canonical
command, and expected baseline from the evidence map. The parent compares the
gate being run before source work; a material mismatch in behavior, scope,
safety, dependencies, or that gate is `dispatch-invalid`. Record-only drift and
baseline-preserving command corrections are Lead-reconciled. If a Worker
accidentally runs a wrong command, rerun and reconcile the canonical gate
locally. For example, `scripts/start-test.test.sh` is not a substitute for the
plan-owned `bash scripts/dogfood-install.test.sh` command even when both pass.

## Fixture/Harness Contract

Before production integration, a bounded fixture/harness unit must be accepted
as a dependency. Fixture defects do not permit a production workaround and
remain subject to unit and change-wide budgets.

| Contract evidence | Gate ID | Literal canonical command or observation | Expected baseline | Evidence |
|---|---|---|---|---|
| State ownership | `gate.<id>` | `<command or observation>` | <semantic pass condition> | <evidence> |
| Recursive child behavior where relevant | `gate.<id>` | `<command or observation>` | <semantic pass condition or n/a> | <evidence> |
| Re-decode and snapshot restoration | `gate.<id>` | `<command or observation>` | <semantic pass condition> | <evidence> |
| Failure injection where relevant | `gate.<id>` | `<command or observation>` | <semantic pass condition or n/a> | <evidence> |
| Public-route constraints | `gate.<id>` | `<command or observation>` | <semantic pass condition> | <evidence> |

## Startup VCS Policy

- Agent commits: <no>
- Agent pushes: <no>
- Staging owner: <Lead | user>
- User commit required: <yes | no>
- Candidate preservation container: <one authorized bounded container>
- Preservation manifest: <paths, reason, owner, retention, deadline, cleanup disposition>
- Cleanup owner: <owner>

## Pending User Decisions

- <question>

## Acceptance-Criterion Evidence

| Acceptance criterion | Gate ID | Literal canonical command or observation | Expected baseline | Source snapshot | Output correspondence | Fresh after latest change | Warning baseline | Evidence |
|---|---|---|---|---|---|---|---|---|
| <criterion from spec> | `gate.<id>` | `<literal canonical command>` | <semantic pass condition; exact count only if contractual> | <snapshot reference> | <output reference> | <yes/no and observation> | <informational, non-masking> | <reproducible evidence>

## Residual Risks

- <risk and impact>

## Final Outcome

- <pending | outcome>
