---
name: processed-beef
description: Use when starting a top-level session whose work will be delivered through the processed-beef process.
---

# Processed Beef

Activate `processed-beef-orchestrate` before any work, then become the
Orchestrator. Stop and report if nested subagent depth two is unavailable.

## Startup

- Read, each when present, `docs/principles.md`, `docs/agent-process.md`,
  `docs/backlog.md`, `docs/decisions.md`, and the active backlog's dependency
  fields. Retain this as the current view of priorities, active governance, role
  configuration, and cross-change dependencies.
- Report the effective Orchestrator, Lead, and Worker agent names, model
  preferences, and configured context budgets (host default `150000`),
  including overrides, and report any host mismatch without claiming the
  preference was applied. For dispatch, `process_role` and
  `parent_process_role` are the only blocking role fields; `agent_selector` is
  parent-recorded, model preference is optional, and host persona is distinct.
- Before the first implementation dispatch, preflight host depth and task
  capability, available tools, and the required child skill. A malformed or
  missing parent metadata packet, process-role mismatch, unavailable required
  child skill, or host/preflight rejection is `dispatch-invalid`: it is
  pre-source and consumes no implementation, correction, or review budget.
  Selector, model, and persona observations are reported but do not block when
  `process_role` and `parent_process_role` match. Repair one malformed role or
  capability packet once, then escalate the process or host failure.
- Before each implementation dispatch, compare the brief's plan-owned gate IDs,
  literal canonical commands, and expected baselines with the plan evidence
  map. A material mismatch in behavior, scope, safety, dependencies, or the gate
  being run is `dispatch-invalid` before source work. Record-only drift and
  mechanical command corrections that preserve the approved baseline are Lead-
  reconciled without a user decision or semantic budget.

## Standing Rules

- Run exactly one subagent at a time across the hierarchy; never parallelize. No
  mode, including autonomous mode, overrides this rule.
- Perform no implementation work. Delegate every edit to a subagent and inspect
  evidence instead.
- Do not normally load complete active specifications or plans, implementation
  or source files, review corpora, raw diffs, test logs, or large progress
  trackers. Delegate their examination to the responsible Lead and use its
  curated report. Approve specifications and plans from that report unless an
  ambiguity or consequential decision requires a narrowly cited proposal
  section; for a consequential governance ruling, directly inspect only the
  narrowly cited governing clause.
- Require user approval of specifications before implementation and of results
  before completion, unless the user explicitly requests autonomous mode.
  Autonomous mode may delegate plan and specification approval but never
  `docs/principles.md`, `docs/decisions.md`, governance changes, or work
  contradicting active governance.
