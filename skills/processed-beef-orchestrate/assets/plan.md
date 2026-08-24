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

## Work Units

| ID | Objective | Depends on | File or subsystem scope | Gate ID and literal canonical command (static or live) | Expected baseline |
|---|---|---|---|---|---|
| unit-01 | <objective> | - | <scope> | `gate.<id>`: `<literal canonical command>` | <expected result/count/hash> |
| unit-02 | <objective> | unit-01 | <scope> | `gate.<id>`: `<literal canonical command>` | <expected result/count/hash> |

Only the Lead mutates plans and state. Semantic unit IDs are stable; execution
slices use `unit-<n>/attempt-<n>`.

## Progress

- [ ] unit-01 <objective>
- [ ] unit-02 <objective>

## Attempt Accounting

Counts belong to the semantic unit and change and survive Worker replacement,
Lead succession, and relabeled briefs. A third implementation attempt on one
unit trips its unit breaker. A second pre-review implementation correction trips
the pre-review breaker; a second finding-fix correction for one independent
review finding set trips the finding-fix breaker. Confirmation is neither a
correction nor a review. Only one changed-kind reset is allowed across all
descendants; a second parks and escalates. A real reset changes the acceptance
mechanism, evidence boundary, fixture/oracle, or ownership, not names or labels.

A unit is listed only once one of its counts exceeds 1; a unit that completed
first try is absent, and absence means all counts are 1 or lower. State "no
entries" when the table is empty.

| Unit | Implementation attempts | Pre-review corrections | Finding-fix corrections | Independent reviews |
|---|---:|---:|---:|---:|
| <unit-id> | 2 | 1 | 0 | 0 |

### Change-Wide Ledger

| Implementation dispatches | Dispatch-invalids | Pre-review corrections | Finding-fix corrections | Independent reviews | Changed-kind resets | Broad gate runs | Worker tool-call proxy | Lead tool-call proxy | Acceptance criteria moved | No-progress streak |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

Implementation dispatches count source-work dispatches, including bounded
fixture/harness implementation; `dispatch-invalid` is counted separately and
does not consume implementation budget. Broad gate runs count each invocation
of a gate marked broad in the work-unit table. Worker and Lead tool-call proxies
count their tool invocations for this change. Acceptance criteria moved counts
criteria newly met since the prior implementation dispatch. The no-progress
streak increments when that dispatch moves zero criteria and resets when one or
more move. Three implementation dispatches without a criterion moving parks and
escalates. At most one changed-kind reset is permitted across this change. A
second parks and escalates. Record the reset's changed acceptance mechanism,
evidence boundary, fixture/oracle, or ownership.

Every implementation brief cites the plan-owned gate ID, literal canonical
command, and expected baseline from the evidence map. The parent compares them
before source work; a mismatch is `dispatch-invalid`. If a Worker accidentally
runs a wrong command, rerun and reconcile the canonical gate locally. For
example, `scripts/start-test.test.sh` with 255 assertions is not a substitute
for `bash scripts/dogfood-install.test.sh` with 347 expected assertions.

## Fixture/Harness Contract

Before production integration, a bounded fixture/harness unit must be accepted
as a dependency. Fixture defects do not permit a production workaround and
remain subject to unit and change-wide budgets.

| Contract evidence | Gate ID | Literal canonical command or observation | Expected baseline | Evidence |
|---|---|---|---|---|
| State ownership | `gate.<id>` | `<command or observation>` | <expected result> | <evidence> |
| Recursive child behavior where relevant | `gate.<id>` | `<command or observation>` | <expected result or n/a> | <evidence> |
| Re-decode and snapshot restoration | `gate.<id>` | `<command or observation>` | <expected result> | <evidence> |
| Failure injection where relevant | `gate.<id>` | `<command or observation>` | <expected result or n/a> | <evidence> |
| Public-route constraints | `gate.<id>` | `<command or observation>` | <expected result> | <evidence> |

## Startup VCS Policy

- Agent commits: <no>
- Agent pushes: <no>
- Staging owner: <Lead | user>
- User commit required: <yes | no>
- Candidate preservation container: <one authorized bounded container>
- Manifest and cleanup owner: <path / owner>

## Pending User Decisions

- <question>

## Acceptance-Criterion Evidence

| Acceptance criterion | Gate ID | Literal canonical command or observation | Expected baseline | Evidence |
|---|---|---|---|---|
| <criterion from spec> | `gate.<id>` | `<literal canonical command>` | <expected result/count/hash> | <reproducible evidence>

## Residual Risks

- <risk and impact>

## Final Outcome

- <pending | outcome>
