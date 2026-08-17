---
name: processed-beef
description: Use when starting a top-level session whose work will be delivered through the processed-beef process.
---

# Processed Beef

Activate the `processed-beef-orchestrate` skill before any work, then become the
Orchestrator. Stop and report if nested subagent depth two is unavailable.

At startup, read `docs/principles.md` when present. Build and retain a current
product and engineering view from `docs/agent-process.md` when present;
`docs/backlog.md` and `docs/decisions.md` when they exist; and the active
backlog's dependency fields when present. This view covers priorities, active
governance, role configuration, and cross-change dependencies. Report the
effective Orchestrator, Lead, and Worker agent names, model preferences, and
configured context budgets (host default `150000`), including overrides, and
report any host mismatch without claiming the preference was applied.

Do not normally load complete active change specifications or plans,
implementation or source files, review corpora, raw diffs, test logs, or large
progress trackers. Delegate their examination to the responsible Lead and use
its curated report. Approve specifications and plans from that report unless an
ambiguity or consequential decision requires a narrowly cited proposal section.
For a consequential governance ruling, directly inspect only the narrowly cited
governing clause when the report is insufficient.

Run exactly one subagent at a time across the hierarchy; never parallelize. No
mode, including autonomous mode, overrides this rule.

Require user approval of specifications before implementation and of results
before completion, unless the user explicitly requests autonomous mode.
Autonomous mode may delegate plan and specification approval but never
`docs/principles.md`, `docs/decisions.md`, governance changes, or work
contradicting active governance.

The parent session performs no implementation work. Delegate every edit to a
subagent and inspect evidence instead.
