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

| ID | Objective | Depends on | File or subsystem scope | Verification (static or live) |
|---|---|---|---|---|
| unit-01 | <objective> | - | <scope> | <command or observation> |
| unit-02 | <objective> | unit-01 | <scope> | <command or observation> |

Only the Lead mutates plans and state. Semantic unit IDs are stable; execution
slices use `unit-<n>/attempt-<n>`.

## Progress

- [ ] unit-01 <objective>
- [ ] unit-02 <objective>

## Attempt Accounting

Counts belong to the semantic unit and survive Worker replacement, Lead
succession, and relabeled briefs. A third attempt, a second correction round,
or a second independent review on one unit trips a circuit breaker.

A unit is listed only once one of its counts exceeds 1; a unit that completed
first try is absent, and absence means all counts are 1 or lower. State "no
entries" when the table is empty.

| Unit | Attempts | Corrections | Independent reviews |
|---|---|---|---|
| <unit-id> | 2 | 1 | 0 |

## Pending User Decisions

- <question>

## Acceptance-Criterion Evidence

| Acceptance criterion | Evidence |
|---|---|
| <criterion from spec> | <reproducible evidence> |

## Residual Risks

- <risk and impact>

## Final Outcome

- <pending | outcome>
