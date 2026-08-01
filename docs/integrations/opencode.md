# OpenCode Integration

OpenCode enforces per-role models through named agents, configured either as
Markdown files or as an `agent` map in `opencode.json`. Nested delegation is
enabled with `subagent_depth`. The JSON agent map key is singular `agent`.
Agent directories accept either `agent/` or `agents/`; prefer Markdown files
for stability. Details are current for OpenCode as of 2026-07.

## Current Paths

| Scope | Path | Use |
|---|---|---|
| Project | `.opencode/agents/<name>.md` | Checked into version control, shared with the team |
| Global | `~/.config/opencode/agents/<name>.md` | Personal, available in every project |
| Project config | `opencode.json` | `subagent_depth`, agent map, global model |
| Global config | `~/.config/opencode/opencode.json` | User defaults |

The Markdown file name becomes the agent name, so `processed-beef-lead.md`
creates the `processed-beef-lead` agent. The `.opencode` and
`~/.config/opencode` directories accept either `agent/` or `agents/`
subdirectories.

## Install as a Plugin

Add the Git-backed package to the `plugin` array in project or global
`opencode.json`:

```json
{
  "plugin": [
    "processed-beef@git+https://github.com/beefsack/processed-beef.git"
  ]
}
```

Restart OpenCode after changing plugin configuration. The plugin registers the
repository's bundled skills only. It does not activate the workflow, create
role agents, or set `subagent_depth` and permissions; configure those below.

## Minimal Role-Agent Configuration

Project `opencode.json`:
```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "subagent_depth": 2
}
```

`.opencode/agents/processed-beef-orchestrator.md`
```markdown
---
description: Orchestrator for the processed-beef process. Use as the primary session for processed-beef work.
mode: primary
---
You are the processed-beef Orchestrator. Load the processed-beef skill and
follow it exactly. You perform no implementation work yourself.
```

`.opencode/agents/processed-beef-lead.md`
```markdown
---
description: Lead for the processed-beef process. Plans, dispatches Workers serially, and inspects evidence.
mode: subagent
---
You are the processed-beef Lead. Load the processed-beef-orchestrate skill and
follow it exactly.
```

`.opencode/agents/processed-beef-worker.md`
```markdown
---
description: Worker for the processed-beef process. Executes one bounded unit from a Lead brief and returns evidence.
mode: subagent
---
You are the processed-beef Worker. Load the processed-beef-work-unit skill and
follow it exactly.
```

## Model Selection

An agent's `model` takes a `provider/model-id` value (for example
`anthropic/claude-sonnet-4-5`). When unset:

- primary agents use the globally configured model;
- subagents inherit the model of the primary agent that invoked them.

Omit `model` to express the `inherit` preference; add it per role when you want
a cheaper Worker than Lead. The Task tool accepts no model parameter, so
per-invocation model switching is not available; role models come only from
agent definitions.

## Nested Subagents

`subagent_depth` controls how deeply subagents may invoke other subagents. The
default is `1` (primary agents can launch subagents, but those subagents cannot
launch more). Set it to `2` for one additional nested level, which covers the
Orchestrator to Lead to Worker depth. Set `0` to disable subagent launches.
Full operation also requires task permission for the Orchestrator and Lead,
which is what lets them dispatch subagents.

## Context-Limit Reality

OpenCode compacts or otherwise manages session context automatically and does
not expose a per-agent hard ceiling the process relies on. The `150000` limit
is skill-enforced: near 85% of the effective limit, or when the next unit may
exceed the remaining budget, a role with a live parent returns a terminal
curated report through chat and stops; the return is a terminal chat handover
even when reported as `blocked`, and the outgoing role does not resume. Only a
top-level session or a boundary without a live parent writes a terminal
`handover.md`.

## Zero-Config Fallback

With no project agent files, zero config works only when the host already
provides generic depth-two subagents. The default `subagent_depth` is `1`, so
unless it is raised to `2` and the Orchestrator and Lead hold task permission,
the primary session cannot dispatch a Lead that dispatches a Worker; the entry
skill stops and reports that depth two is unavailable. When it does run, role
behavior and serial dispatch come from the skills. Per-role model routing is
unavailable until the agent files exist; the entry skill reports that mismatch.

## Known v1 Limitations

- No per-agent hard context ceiling; enforcement is process-level only.
- The Task tool has no model parameter, so model routing depends entirely on
  agent definitions.
- The JSON agent map uses the singular `agent` key; Markdown files avoid
  config-file ambiguity entirely.
- Without `subagent_depth: 2` and task permission for the Orchestrator and
  Lead, they cannot dispatch subagents, so both are mandatory for full
  operation.
