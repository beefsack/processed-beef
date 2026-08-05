# Plan: <title>

Ownership and approval:
- Owner: Lead
- Status: Pending Orchestrator approval | Approved <date> by <approver>

## Technical Approach

<approach>

## Work Units

| ID | Objective | Depends on | File or subsystem scope | Verification |
|---|---|---|---|---|
| unit-01 | <objective> | - | <scope> | <command or observation> |
| unit-02 | <objective> | unit-01 | <scope> | <command or observation> |

Only the Lead mutates plans and state. Semantic unit IDs are stable; execution
slices use `unit-<n>/attempt-<n>`.

## Progress

- [ ] unit-01 <objective>
- [ ] unit-02 <objective>

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
