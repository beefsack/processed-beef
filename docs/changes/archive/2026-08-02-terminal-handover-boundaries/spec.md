# Specification: Terminal Handover Boundaries

Ownership and approval:
- Owner: User
- Status: Approved 2026-08-02 by user and Orchestrator

## Intent and Desired Outcome

Make completed reports and handovers terminal so future work always begins with
a fresh subagent unless a same unfinished unit is specifically eligible for
resumption. Keep reporting useful and durable recovery information minimal and
authoritative.

## Scope and Non-Goals

In scope:

- Make completed reports and handovers terminal.
- Permit resumption only for the same unfinished unit after a specific
  `decision-needed` answer or resolved concrete `blocked` condition, within
  context budget.
- Require fresh subagents after completion, handover, changed scope,
  corrections, or further work.
- Return curated comprehensive reports through chat without exhaustive
  transcripts or persisted report files.
- Return Worker-to-Lead and Lead-to-Orchestrator handovers through chat.
- Reserve `handover.md` for top-level session transfers or boundaries without a
  live parent.
- Preserve `log.md` and Git as crash-recovery truth.
- Align skills, templates, README, architecture, and integration guides.

Non-goals:

- Change governance, serial delegation, context limits, or completion process.
- Retain exhaustive transcripts or add persisted report artifacts.

## Applicable Principles and Decisions

- No applicable user-owned principles or decisions were identified.

## Constraints

- Every handover is terminal.
- `handover.md` is prescribed only where chat cannot bridge the transfer.
- Reports are curated.
- Validation and diff checks must pass apart from confirmed pre-existing
  environment failures.

## Acceptance Criteria

- [ ] Rules are explicit and consistent across skills, templates, README,
  architecture, and integration guides.
- [ ] Every handover is terminal; resumption is limited to the same unfinished
  unit after a specific resolved `decision-needed` or concrete `blocked` case,
  within context budget.
- [ ] `handover.md` is prescribed only for top-level transfers or boundaries
  without a live parent; Worker-to-Lead and Lead-to-Orchestrator handovers use
  chat.
- [ ] Reports are curated and no persisted exhaustive report files are
  prescribed.
- [ ] Governance, serial delegation, context limits, and completion behavior
  remain unchanged.
- [ ] `git diff --check` and `sh tests/validate.sh` pass apart from confirmed
  pre-existing environment failures.

## Unresolved Questions

- None.

## Consequential Decisions

- Completed and handover reports terminate their agent. A fresh subagent is the
  default for all subsequent work to preserve clear ownership and context
  boundaries.
- A Worker may resume only its same unfinished unit after the parent answers a
  specific `decision-needed` report or resolves its concrete `blocked`
  condition, and only while the Worker remains within its context budget.
