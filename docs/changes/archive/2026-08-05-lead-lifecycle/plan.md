# Plan: Lead-Owned Major-Unit Lifecycle

Ownership and approval:
- Owner: Lead
- Status: Result accepted 2026-08-05 by Lead under user and Orchestrator approval

## Technical Approach

Define lifecycle terms and transitions once in the scheduling and verification
references, then align role skills and templates. Apply the portable policy to
public and host-specific guidance, using verified OpenCode task permissions.
Guard the contract with targeted static validation and behavioral records. The
Lead accepts inspected work, performs commits, and archives this change.

## Work Units

| ID | Objective | Depends on | File or subsystem scope | Verification |
|---|---|---|---|---|
| unit-01 | Encode Lead-owned lifecycle, dispatch, recovery, review, and commit policy. | - | role skills, orchestration references, templates | Direct consistency inspection; `sh tests/validate.sh` |
| unit-02 | Align architecture, README, and host integration guides with portable policy and verified host enforcement. | unit-01 | `README.md`, `docs/architecture.md`, `docs/integrations/` | Direct consistency inspection; `sh tests/validate.sh` |
| unit-03 | Add pragmatic lifecycle regression coverage and validate the complete contract. | unit-01, unit-02 | `tests/` | `sh tests/validate.sh`; direct test inspection |
| unit-04 | Independently review the public process-contract change. | unit-03 | complete diff and evidence | Concrete findings only |

Semantic IDs remain stable. Execution slices use `unit-<n>/attempt-<n>` and do
not amend this plan unless semantic scope, acceptance, dependencies, or
governance changes.

## Progress

- [x] unit-01 Lifecycle policy
- [x] unit-02 Public and integration guidance
- [x] unit-03 Regression coverage
- [x] unit-04 Independent review

## Pending User Decisions

- None.

## Acceptance-Criterion Evidence

| Acceptance criterion | Evidence |
|---|---|
| Lead ownership and separate unit/attempt IDs | Accepted `unit-01/attempt-03`; inspected skills, scheduling reference, and templates. |
| Reconciled dispatch | Accepted `unit-01/attempt-03`; inspected compact dispatch packet and stop rule. |
| Review-ready acceptance and recovery | Accepted `unit-01/attempt-03`; inspected lifecycle transitions and result handling. |
| Delegation and actual role enforcement | Accepted `unit-02/attempt-01`; inspected Worker policy and integration configurations, including verified OpenCode `permission.task` guidance. |
| Proportionate review | Independent `unit-04/attempt-01` found and verified correction of the host-definition precedence contradiction. |
| Cross-document consistency | Accepted `unit-02/attempt-01`; focused inspection and final `sh tests/validate.sh` success. |
| Lifecycle regression coverage | Accepted `unit-03/attempt-03`; 12 targeted contract assertions and the no-`complete` Worker-status check pass. |
| Superseding archive record | Archived specification and plan inspection. |

## Residual Risks

- Host enforcement depends on host versions and configuration; portable skills
  still enforce process policy and report mismatches.

## Rationale and Follow-Up Observation

See [`rationale-and-watchlist.md`](rationale-and-watchlist.md) for the brdgme
baseline, the rationale behind this lifecycle, and the concrete post-change
watchlist. It distinguishes historical evidence and future hypotheses from the
normative lifecycle contract in the installed skills and references.

## Final Outcome

- Accepted. One Lead owns each major unit across serial slices; Workers return
  `review-ready`, do not delegate, and never own completion administration.
  This record supersedes the terminal-completion and correction lifecycle in
  `2026-08-02-terminal-handover-boundaries` without altering its history.
