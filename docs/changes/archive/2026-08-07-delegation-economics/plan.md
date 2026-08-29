# Plan: Delegation Economics

> Historical record. Paths and controls describe the repository at the time.

Ownership and approval:
- Owner: Lead
- Status: Result accepted 2026-08-07 by Lead under user and Orchestrator approval

## Technical Approach

Encode the delegation guidance changes directly in `references/scheduling.md`,
`skills/processed-beef-work-unit/SKILL.md`, `references/verification.md`,
`skills/processed-beef-orchestrate/SKILL.md`, and `references/artifacts.md`.
Extend `tests/validate.sh`'s literal-phrase contract to guard the new wording,
matching the convention set for the `2026-08-05-lead-lifecycle` change. Record
baseline evidence, attribution, decision rationale, and measurable desired
outcomes in this change's `rationale-and-watchlist.md`. Add RED behavioral
scenarios capturing the observed pressure, with GREEN left pending future
observation. Update `CHANGELOG.md`.

Governance artifacts (`spec.md`, `plan.md`) are Lead-owned by policy and are
not delegated. The skill and reference edits and the `tests/validate.sh`
contract extension were self-executed by the Lead: the Lead had already loaded
the full content of every target file while scoping this brief's precise
line-number references, which is a forfeit under the new `Corpus Ownership and
Forfeit` rule this change itself introduces, not an ordinary Lead-execution
default. The non-normative rationale, behavioral, and changelog documentation
was dispatched to Workers, since its bulk content was stateable from the
approved brief without the Lead re-loading further material.

## Work Units

| ID | Objective | Depends on | File or subsystem scope | Verification |
|---|---|---|---|---|
| unit-01 | Add `Delegation Decision`, `Corpus Ownership and Forfeit`, `Late Size Discovery`, `Review Points` subsections; add `checkpoint`/`continue` to the Worker Brief fields and Lifecycle Statuses table; replace the commit, investigation, and Lead-reading clauses. | - | `references/scheduling.md` | Direct consistency inspection; `sh tests/validate.sh` |
| unit-02 | Add `checkpoint` status row, brief-field note, and lifecycle bullet. | unit-01 | `skills/processed-beef-work-unit/SKILL.md` | Direct consistency inspection; `sh tests/validate.sh` |
| unit-03 | Add the production-diff review boundary. | - | `references/verification.md` | Direct consistency inspection; `sh tests/validate.sh` |
| unit-04 | Add the Orchestrator raw-extraction prohibition; align the Roles paragraph with the new Lead-reading clause. | unit-01 | `skills/processed-beef-orchestrate/SKILL.md` | Direct consistency inspection; `sh tests/validate.sh` |
| unit-05 | Align the commit-only-Worker restatement with the new wording. | unit-01 | `references/artifacts.md` | Direct consistency inspection; `sh tests/validate.sh` |
| unit-06 | Extend the literal-phrase contract to guard the new wording. | unit-01 through unit-05 | `tests/validate.sh` | `sh tests/validate.sh` |
| unit-07 | Author `rationale-and-watchlist.md`: measured baseline, attribution, decision rationale, alternatives considered, and measurable desired outcomes. | unit-01 through unit-06 | `docs/changes/2026-08-07-delegation-economics/rationale-and-watchlist.md` | Direct inspection against the approved content; `sh tests/validate.sh` |
| unit-08 | Add four RED behavioral scenarios; add the `CHANGELOG.md` Unreleased entry. | unit-01 through unit-06 | `tests/behavioral.md`, `CHANGELOG.md` | Direct inspection against the existing file's format; `sh tests/validate.sh` |
| unit-09 | Independent review of the complete diff (unit-01 through unit-08) for internal consistency and no contradicting clauses. | unit-01 through unit-08 | complete diff and evidence | Concrete findings only; `sh tests/validate.sh` |

Semantic IDs remain stable. Execution slices use `unit-<n>/attempt-<n>` and do
not amend this plan unless semantic scope, acceptance, dependencies, or
governance changes.

## Progress

- [x] unit-01 Scheduling reference (self-executed, forfeit recorded)
- [x] unit-02 Work-unit skill (self-executed, forfeit recorded)
- [x] unit-03 Verification reference (self-executed, forfeit recorded)
- [x] unit-04 Orchestrate skill (self-executed, forfeit recorded)
- [x] unit-05 Artifacts reference (self-executed, forfeit recorded)
- [x] unit-06 Validation contract (self-executed, forfeit recorded)
- [x] unit-07 Rationale and watchlist (Worker-dispatched, accepted)
- [x] unit-08 Behavioral and changelog (Worker-dispatched, accepted)
- [x] unit-09 Independent review (Worker-dispatched; one non-blocking plan-staleness
  finding resolved by this update, one substantive note resolved by adding the
  Worker-side Late Size Discovery path to `references/scheduling.md`, one
  note-only finding accepted with no fix needed)

## Pending User Decisions

- None.

## Acceptance-Criterion Evidence

| Acceptance criterion | Evidence |
|---|---|
| Delegation Decision, Corpus Ownership and Forfeit | `unit-01`; inspected `references/scheduling.md`. |
| Late Size Discovery | `unit-01`; inspected `references/scheduling.md`. |
| checkpoint/continue status, per-checkpoint correction budget | `unit-01`, `unit-02`; inspected `references/scheduling.md` and `skills/processed-beef-work-unit/SKILL.md`. |
| Commit, investigation, Lead-reading clause replacement; artifacts.md consistency | `unit-01`, `unit-05`; inspected `references/scheduling.md` and `references/artifacts.md`. |
| Production-diff review boundary | `unit-03`; inspected `references/verification.md`. |
| Orchestrator raw-extraction prohibition | `unit-04`; inspected `skills/processed-beef-orchestrate/SKILL.md`. |
| Watchlist and measurable desired outcomes | `unit-07`; accepted after inspecting `rationale-and-watchlist.md` (190 lines) against the required content list. |
| Four RED behavioral scenarios, GREEN pending | `unit-08`; accepted after inspecting the `git diff` of `tests/behavioral.md` and `CHANGELOG.md`. |
| Validation contract extension | `unit-06`; `sh tests/validate.sh` passes. |
| Internal consistency, no contradicting clauses | `unit-09`; independent review found no reject-with-reason findings across 7 checklist areas; one plan-staleness item and one Worker-side Late Size Discovery gap were fixed. |
| Complete `sh tests/validate.sh` pass | Final run after unit-09's fix: exit 0. |

## Residual Risks

- The `checkpoint`/`continue` status is defined in policy but not yet exercised
  operationally in this session: the actively installed skill package predates
  this edit, so no Worker in this session used `checkpoint`. It is unverified
  under live dispatch.
- `tests/validate.sh`'s literal-phrase checks are proxy guards against wording
  drift, not a full-document snapshot; they can pass while a subtler
  contradiction remains, which is why direct consistency inspection is also
  required.
- The desired-outcome targets in `rationale-and-watchlist.md` depend on the
  current model assignment (near-zero-cost Workers, premium Leads and
  Orchestrator) and are unverified until observed in a future comparable
  session.

## Rationale and Follow-Up Observation

See [`rationale-and-watchlist.md`](rationale-and-watchlist.md) for the measured
baseline, the rationale behind this change, and the concrete post-change
watchlist and desired outcomes. It distinguishes historical evidence and future
targets from the normative contract in the installed skills and references.

## Final Outcome

- Accepted. All nine work units complete; `sh tests/validate.sh` passes. Independent
  review (`unit-09`) found no contradicting clauses and no reject-with-reason
  findings; its one substantive note (the Late Size Discovery trigger's
  Worker-side path was unstated despite being "applicable to every role") was
  fixed by adding an explicit paragraph to `references/scheduling.md` stating
  that a Worker hitting the trigger stops and reports rather than dispatching
  itself, consistent with "Workers never delegate." This record documents the
  eight approved wording items and the measurable desired outcomes for a future
  comparable session.

## Follow-up Work Unit: Close Lead Delegation Gaps (2026-08-07)

| Acceptance criterion | Evidence |
|---|---|
| AC1 | `skills/processed-beef-orchestrate/SKILL.md` Context Discipline bullet reads "out of Lead context beyond the diff and evidence"; `tests/validate.sh` `check_delegation_economics_followup_contract` asserts the phrase. |
| AC2 | `skills/processed-beef-orchestrate/SKILL.md` raw-extraction paragraph reads "and neither does the Lead beyond the diff and", preserving "does not perform raw extraction"; asserted by both the pre-existing and new `validate.sh` contracts. |
| AC3 | `skills/processed-beef-orchestrate/references/scheduling.md` Late Size Discovery contains "bound by the same rule as a host-triggered rejection"; asserted by `validate.sh`. |
| AC4 | `scheduling.md` Delegation Decision contains "the same as change units"; asserted by `validate.sh`. |
| AC5 | `scheduling.md` Corpus Ownership contains "does not rediscover them"; asserted by `validate.sh`. |
| AC6 | `skills/processed-beef-work-unit/SKILL.md` Report Shape contains "has no diff to fall back on"; asserted by `validate.sh`. |
| AC7 | `scheduling.md` Cost paragraph contains "a Lead's byte typically costs more than a Worker's"; asserted by `validate.sh`. |
| Falsification recorded | `tests/behavioral.md` Scenario 8 (new) plus a cross-reference note below the Scenario 7 table; `rationale-and-watchlist.md` Falsification section. |
| All checks pass | `sh tests/validate.sh` exits 0. |

## Follow-up Work Unit: Role-Model Clarification (2026-08-07)

| Acceptance criterion | Evidence |
|---|---|
| AC1 (pre-start split) | `skills/processed-beef-orchestrate/SKILL.md` Lead role definition ("returned for a pre-start split") and `references/scheduling.md` Recovery ("judges a unit too large and cleanly separable"); asserted by `validate.sh`. |
| AC2 (host-reconciliation right) | `SKILL.md` Context Discipline ("Host reconciliation is the Lead's only other direct-extraction right"); asserted by `validate.sh`. |
| AC3 (delegable categories) | `scheduling.md` Delegation Decision ("This covers code and file changes, test and command runs, documentation writing, documentation search and summarisation, and web research alike"); asserted by `validate.sh`. |
| AC4 (Lead read whitelist) | `SKILL.md` startup-reads paragraph ("is a narrow exception, not the default"); asserted by `validate.sh`. |
| AC5 (Orchestrator read boundary) | `SKILL.md` startup-reads paragraph ("all other Orchestrator interaction is with"); asserted by `validate.sh`. |
| AC6 (Worker interaction boundary) | `skills/processed-beef-work-unit/SKILL.md` Worker role preamble ("with the dispatching Lead only, never the Orchestrator or user directly"); asserted by `validate.sh`. |
| AC7 (blast-radius escalation ladder) | `governance.md` Escalation ("Escalation tracks decision blast radius"); asserted by `validate.sh`. |
| AC8 (project dependencies escalate) | `governance.md` Escalation ("a project dependency such as"); asserted by `validate.sh`. |
| AC9 (cost-tier rationale) | `SKILL.md` Roles section top ("Model tiers track role cost"); asserted by `validate.sh`. |
| AC10 (Orchestrator technical consultation) | `governance.md` Escalation ("put a complex or ambiguous technical question to the"); asserted by `validate.sh`. |
| Scenario 9 recorded | `tests/behavioral.md` Scenario 9 (new), RED observed 2026-08-07, GREEN pending. |
| All checks pass | `sh tests/validate.sh` exits 0. |
