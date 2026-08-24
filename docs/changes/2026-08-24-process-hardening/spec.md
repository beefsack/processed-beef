# Specification: Process Hardening From Plasma Auto Tiler Retrospective

Ownership and approval:
- Owner: User
- Status: Approved 2026-08-24 by user and Orchestrator

## Intent and Desired Outcome

Prevent the invalid-dispatch, role-metadata, correction-budget, reset-loop,
fixture-contract, verification-churn, VCS, candidate-preservation, and
no-progress failures observed in the 2026-08-24 `plasma-auto-tiler` session.
The process must retain its effective safety breakers while distinguishing
process/host failure from implementation failure.

## Scope and Non-Goals

In scope:

- Portable skills, references, templates, documentation, and behavioral record.
- `dispatch-invalid`, unambiguous process-role metadata, child capability
  preflight, separate correction classes, and change-wide reset/no-progress
  breakers.
- Fixture-contract, canonical-gate, VCS, candidate-preservation, and compact
  brief policy.
- Evidence and recommendations preserved from the source-session retrospective.

Non-goals:

- Plugin, host configuration, machine-injected metadata, or automatic child
  skill detection.
- Changes to `plasma-auto-tiler`, dependencies, generated files, publication,
  commit, or push.
- A second standalone retrospective outside this change directory.

## Acceptance Criteria

- Pre-source malformed dispatches, missing parent metadata, process-role
  mismatches, selector/persona confusion, unavailable required child skills,
  and host/preflight rejection are `dispatch-invalid`, not implementation
  attempts, corrections, or reviews. One parent repair is allowed; repetition
  escalates process or host failure.
- Only `process_role` and `parent_process_role` block role validity.
  `agent_selector` is parent-recorded, model preference is optional, host
  persona is separate, and a child does not claim selector/model application.
- One pre-review implementation correction and one review finding-fix correction
  are separate budgets. Confirmation checks the frozen finding set only.
- One changed-kind reset survives every descendant. A second reset, or three
  implementation dispatches without acceptance movement, parks and escalates.
- Fixture/harness contracts are bounded, independently accepted dependencies of
  production integration. A fixture defect does not authorize a production
  workaround.
- Plans bind gate IDs, literal canonical commands, and expected baselines;
  focused gates run per unit and broad gates run only at named risk/final
  checkpoints unless justified.
- Startup captures no-commit/no-push default VCS policy, user-owned staging,
  bounded candidate preservation, and cleanup ownership.
- Behavioral documentation covers the observed role, command, correction,
  descendant-reset, fixture, scope, and stage-only regressions.
- `sh tests/validate.sh` and `git diff --check` pass.

## Constraints

- ASCII-only Markdown and existing skill size/link conventions.
- Preserve unrelated target working-tree paths and the source repository.
- Host automation is deferred only with a concrete P1 acceptance record.

## Consequential Decisions

- This approved patch adds policy and templates rather than unverifiable plugin
  automation. A host adapter must later expose a small, fake-host-testable
  parent-side metadata and skill-availability mechanism before automation is
  added.
- The one-time bootstrap correction that aligned checkpoint, state, and
  pre-source host semantics is a migration exception only; it does not create a
  second correction right for future changes.
