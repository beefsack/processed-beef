# Lean Project Lifecycle

**Status:** Completed 2026-08-29

## Specification

- **Goal:** Restore high-value project management without execution ceremony.
- **Scope:** A concise ordered backlog, one Lead-owned meaningful-change note
  combining specification and current plan, meaningful-only record updates, and
  concise completion archival.
- **Non-goals:** Approval gates, logs, state or recovery files, routine progress
  records, retry ledgers, ticks, or elaborate completion transactions.
- **Acceptance:** Principles, active decisions, role skills, maintainer and
  public documentation, behavioral evidence, and validation describe the same
  ownership and value/overhead boundary; no note is forced for trivial work.

## Current Plan

- Align role skills: complete.
- Align records, human documentation, behavioral evidence, and validation:
  complete, including the canonical-record relocation.
- Verify `sh tests/validate.sh`, `git diff --check`, complete-diff inspection,
  and one fresh Worker review: complete.

## Material Decisions

- The Orchestrator owns backlog prioritization. The Lead owns the active note.
  Workers maintain no project records.
- A meaningful-change note combines compact specification and current plan; it
  changes only for intent, material decisions, plan, blockers, accepted evidence,
  or outcome.

## Accepted Evidence

- The role-skill Worker reported `sh tests/validate.sh` passed. Lead inspection
  found the ownership and omitted-ceremony rules in all three skills.
- A fresh independent Worker review found missing backlog priority context,
  stale "substantial" wording, a product-vision/validator conflict, and an
  unsupported behavioral scenario; all new-work findings were corrected.
- The record-preservation correction restored L014 verbatim and retained this
  active note and its backlog line; L017 now refers to the active note.
- Lead reran `sh tests/validate.sh` and `git diff --check` after the correction;
  both passed, and the complete diff was inspected.
- Root canonical record aliases were relocated to `docs/principles.md`,
  `docs/decisions.md`, and `docs/backlog.md`; all checked references and
  validation rules use the new canonical paths.
- `sh tests/validate.sh` and `git diff --check` passed after the relocation.

## Outcome

- Accepted 2026-08-29: canonical principles, decisions, and backlog now live
  under `docs/`; active decisions, Orchestrator backlog ownership, the combined
  meaningful-change note, direct trivial requests, and disposable-agent
  handovers are aligned across runtime guidance and maintainer records.
- Final pre-archive `sh tests/validate.sh` and `git diff --check` passed.

## Failures And Repair

None. No semantic failed approach or causal verification repair occurred.

## Next Action

None.
