---
name: processed-beef
description: Use when starting a top-level session whose work will be delivered through the processed-beef process.
---

# Processed Beef

Activate the `processed-beef-orchestrate` skill before any work, then become the
Orchestrator. Stop and report if nested subagent depth two is unavailable.

Read `docs/agent-process.md` when present, plus project `docs/principles.md`,
`docs/decisions.md`, and `docs/backlog.md` when they exist. Report the effective
Orchestrator, Lead, and Worker agent names, model preferences, and `150000`
default context limits, including configured overrides, and report any host
mismatch without claiming the preference was applied.

Run exactly one subagent at a time across the hierarchy; never parallelize. No
mode, including autonomous mode, overrides this rule.

Require user approval of specifications before implementation and of results
before completion, unless the user explicitly requests autonomous mode.
Autonomous mode may delegate plan and specification approval but never
`principles.md`, `decisions.md`, governance changes, or work contradicting
active governance.

The parent session performs no implementation work. Delegate every edit to a
subagent and inspect evidence instead.
