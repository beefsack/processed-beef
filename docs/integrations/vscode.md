# VS Code Integration

VS Code enforces per-role models through custom agent files (`.agent.md` with
YAML frontmatter). Nested subagents are disabled by default and require a
setting. Model strings, settings names, and cost-tier behavior are
version-sensitive; verify against the installed VS Code release.

## Current Paths

| Scope | Path | Use |
|---|---|---|
| Workspace | `.github/agents/` | Checked into version control, shared with the team |
| Workspace (Claude format) | `.claude/agents/` | Compatibility with Claude Code and Claude-based tools |
| User profile | profile-specific user data (for example `~/.copilot/agents`) | Personal, available across workspaces |

Additional locations can be configured with `chat.agentFilesLocations`. In
monorepos, enable `chat.useCustomizationsInParentRepositories` to discover
agent files above the open workspace folder.

## Minimal Role-Agent Configuration

`model` is optional; omit it to inherit the currently selected model. A
delegating role needs the `agent` tool and an `agents` list naming the roles it
may spawn; the Worker must not delegate, so it gets neither.

`.github/agents/processed-beef-orchestrator.agent.md`
```markdown
---
name: processed-beef-orchestrator
description: Orchestrator for the processed-beef process. Use as the top-level agent for processed-beef work.
tools: ['agent']
agents: [processed-beef-lead]
---
You are the processed-beef Orchestrator. Load the processed-beef skill and
follow it exactly. You perform no implementation work yourself.
```

`.github/agents/processed-beef-lead.agent.md`
```markdown
---
name: processed-beef-lead
description: Lead for the processed-beef process. Plans, dispatches Workers serially, and inspects evidence.
tools: ['agent']
agents: [processed-beef-worker]
---
You are the processed-beef Lead. Load the processed-beef-orchestrate skill and
follow it exactly.
```

`.github/agents/processed-beef-worker.agent.md`
```markdown
---
name: processed-beef-worker
description: Worker for the processed-beef process. Executes one bounded unit from a Lead brief and returns evidence. Never delegates.
---
You are the processed-beef Worker. Load the processed-beef-work-unit skill and
follow it exactly.
```

Workers never delegate by portable policy, and VS Code enforces the denial
directly: the Worker file declares neither the `agent` tool nor an `agents`
allowlist, so it cannot spawn any subagent. The Orchestrator holds
`tools: ['agent']` with `agents: [processed-beef-lead]` and the Lead holds
`tools: ['agent']` with `agents: [processed-beef-worker]`, so each delegating
role can spawn only its single child.

## Model Selection

`model` accepts a single model name (string) or a prioritized list (array); the
system tries each in order until one is available. When a subagent runs, the
model is resolved in this order:

1. an explicit model parameter passed when the subagent is invoked;
2. the agent's `model` frontmatter;
3. the main conversation's model.

A subagent cannot run above the main session's cost tier. The `disable-model-invocation`
flag prevents a custom agent from being used as a subagent by other agents.

## Nested Subagents

Nested subagents are disabled by default. Enable the setting
`chat.subagents.allowInvocationsFromSubagents` to let subagents spawn their own
subagents, up to a maximum nesting depth of 5. This covers the Orchestrator to
Lead to Worker depth. A delegating role needs the `agent`/`runSubagent` tool
(`tools: ['agent']`) and an `agents` list naming the roles it may spawn; the
Worker must not delegate, so it gets neither.

## Context-Limit Reality

VS Code does not provide a per-agent hard context ceiling. The `150000` limit
is skill-enforced: nearing its return threshold, or when the next unit may
exceed the remaining budget, a role reports `handover` and stops - through chat
when a live parent exists, otherwise as `handover.md`.

Set the per-agent context budget to `150000` where this host supports one; it
is a configuration value, not a limit any role can observe about itself. The
return thresholds that actually govern behavior, and the handover rules that
follow from them, are stated once in
`skills/processed-beef-orchestrate/references/scheduling.md` under Context
Limits. Do not restate them here: this guide covers only what is specific to
this host.

## Zero-Config Fallback

With no agent files, zero config works only when generic depth-two subagents
are already available. Nested subagents are disabled by default in VS Code, so
until the `chat.subagents.allowInvocationsFromSubagents` setting is enabled the
entry skill stops and reports that depth two is unavailable. When it does run,
the process runs from the main chat session as Orchestrator with the currently
selected model; role behavior and serial dispatch come from the skills.
Per-role model routing is unavailable until the agent files exist; the entry
skill reports that mismatch.

## Known v1 Limitations

- Nested subagents are off by default; the `chat.subagents.allowInvocationsFromSubagents`
  setting is mandatory for full operation.
- No per-agent hard context ceiling; enforcement is process-level only.
- A subagent cannot exceed the main session's cost tier, which caps the Lead
  and Worker models at the tier of the conversation that dispatches them.
- Depth is capped at 5 nesting layers.
- Model names and cost tiers are version- and vendor-sensitive; verify against
  the installed release.
