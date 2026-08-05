# Specification: Lead-Owned Major-Unit Lifecycle

Ownership and approval:
- Owner: User
- Status: Approved 2026-08-05 by user and Orchestrator

## Intent and Desired Outcome

Replace the terminal-report lifecycle with a Lead-owned major-unit lifecycle.
One Lead carries a major unit through serial Worker slices, acceptance, commits,
and completion administration. Worker reports become review inputs rather than
completion evidence.

## Scope and Non-Goals

In scope:

- Define Lead, Worker, semantic-unit, attempt, dispatch, result, review, commit,
  and recovery rules in portable process policy and templates.
- Add pre-dispatch reconciliation and actual-host-role reporting.
- Prohibit Worker delegation, document supported host enforcement, and align all
  public and integration documentation.
- Add proportionate behavioral regression coverage and archive this superseding
  decision record.

Non-goals:

- Change the three-role hierarchy, serial execution rule, context ceiling, or
  user-owned governance rules.
- Add runtime orchestration software or guarantee host behavior beyond documented
  host enforcement.

## Applicable Principles and Decisions

- `docs/changes/archive/2026-08-02-terminal-handover-boundaries/` is superseded
  only for its terminal-completion and correction lifecycle.

## Constraints

- The archived terminal-handover record remains unchanged.
- The Lead performs acceptance, commits, and completion/archive administration.
- Exactly one same-Worker correction round is permitted only with unchanged
  semantic scope and context.
- `sh tests/validate.sh` must pass.

## Acceptance Criteria

- [x] One Lead owns one major unit across serial slices; plan units and attempts
  have separate stable and ephemeral identifiers.
- [x] Every Worker dispatch is reconciled against objective, scope, acceptance,
  constraints, dependencies, and stop conditions before dispatch.
- [x] Workers return `review-ready`; the Lead inspects diff and evidence before
  acceptance, handles recovery states, and makes coherent commits directly.
- [x] Worker delegation is prohibited in policy and denied by supported host
  configuration; actual selected roles are reported against configured roles.
- [x] Independent review remains mandatory for the specified high-risk work and
  routine work does not receive duplicate review.
- [x] Skills, references, templates, public documents, integrations, validation,
  and behavioral records consistently describe the lifecycle.
- [x] The archived record states how it supersedes the prior terminal-handover
  decision without modifying historical files.

## Unresolved Questions

- None.

## Consequential Decisions

- A Worker result is `review-ready`, not a completion or handover boundary. The
  same Worker may receive one correction round only when scope is unchanged.
- Missing, malformed, cancelled, and host-unknown results are unsuccessful,
  non-resumable host attempts that require Lead reconciliation.
- A Lead, rather than a Worker, owns commits and completion/archive work.
- This record supersedes the terminal-completion and correction lifecycle in
  `2026-08-02-terminal-handover-boundaries`; the historical record remains
  unchanged and terminal handovers remain terminal.

## Rationale and Follow-Up Observation

Historical baseline evidence, decision rationale, and future-session hypotheses
and watchlist are recorded in
[`rationale-and-watchlist.md`](rationale-and-watchlist.md). That record is
non-normative; installed skills and references define the lifecycle contract.
