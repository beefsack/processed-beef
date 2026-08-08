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
  "subagent_depth": 2,
  "agent": {
    "processed-beef-orchestrator": {
      "mode": "primary",
      "permission": {
        "task": {
          "*": "deny",
          "processed-beef-lead": "allow"
        }
      }
    },
    "processed-beef-lead": {
      "mode": "subagent",
      "permission": {
        "task": {
          "*": "deny",
          "processed-beef-worker": "allow"
        }
      }
    },
    "processed-beef-worker": {
      "mode": "subagent"
    }
  }
}
```

`.opencode/agents/processed-beef-orchestrator.md`
```markdown
---
description: Orchestrator for the processed-beef process. Use as the primary session for processed-beef work.
mode: primary
permission:
  task:
    "*": deny
    processed-beef-lead: allow
---
You are the processed-beef Orchestrator. Load the processed-beef skill and
follow it exactly. You perform no implementation work yourself.
```

`.opencode/agents/processed-beef-lead.md`
```markdown
---
description: Lead for the processed-beef process. Plans, dispatches Workers serially, and inspects evidence.
mode: subagent
permission:
  task:
    "*": deny
    processed-beef-worker: allow
---
You are the processed-beef Lead. Load the processed-beef-orchestrate skill and
follow it exactly.
```

`.opencode/agents/processed-beef-worker.md`
```markdown
---
description: Worker for the processed-beef process. Executes one bounded unit from a Lead brief and returns evidence. Never delegates.
mode: subagent
---
You are the processed-beef Worker. Load the processed-beef-work-unit skill and
follow it exactly.
```

`permission.task` matches the subagent type with glob patterns; rules are
evaluated in order and the last matching rule wins, so the deny-all rule is
listed first and the single allowed child after it. The Orchestrator may spawn
only the Lead, and the Lead only the Worker. The Worker declares no `task`
permission at all: OpenCode injects a `task: deny` default into a subagent that
has no task rule in its own permission ruleset, so the Worker's subagent session
denies the Task tool. Do not add an explicit deny object to the Worker instead -
leaving the rule out is what the default catches, and some versions treat the
presence of any task rule as permission to run the tool. Users can always invoke
any subagent directly from the `@` menu regardless of task permissions, so this
restricts model-driven delegation, not manual invocation.

## Model Selection

An agent's `model` takes a `provider/model-id` value (for example
`anthropic/claude-sonnet-4-5`). When unset:

- primary agents use the globally configured model;
- subagents inherit the model of the primary agent that invoked them.

Omit `model` to express the `inherit` preference; add it per role when you want
a cheaper Worker than Lead. The Task tool accepts no model parameter, so
per-invocation model switching is not available; role models come only from
agent definitions.

## Tool Availability

Role agents resolve to different models, and different models expose different
tool sets. For example, a GPT parent may rely on `apply_patch` while a DeepSeek
Worker exposes only `edit` and `write`; a brief that forwards the parent's tool
assumptions makes the Worker non-functional. Briefs may specify tool constraints
only when intrinsic to the project or objective, and never forward or restate
the parent role's model-specific tool-use restrictions or capability
assumptions; each child follows its own active instructions and available
tools.

## Nested Subagents

`subagent_depth` controls how deeply subagents may invoke other subagents. The
default is `1` (primary agents can launch subagents, but those subagents cannot
launch more). Set it to `2` for one additional nested level, which covers the
Orchestrator to Lead to Worker depth. Set `0` to disable subagent launches.
Full operation requires both `subagent_depth: 2` and a `permission.task` rule
for the Orchestrator and Lead: the depth setting lets a subagent spawn at all,
and the task rule names which subagent types it may spawn. The Worker carries no
task rule, so its subagent session receives the documented default `task: deny`
and cannot dispatch anything.

## Context-Limit Reality

OpenCode compacts or otherwise manages session context automatically and does
not expose a per-agent hard ceiling the process relies on. The `150000` limit
is skill-enforced: nearing its return threshold, or when the next unit may
exceed the remaining budget, a role with a live parent returns a terminal
curated report through chat and stops; the return is a terminal chat handover
even when reported as `blocked`, and the outgoing role does not resume. Only a
top-level session or a boundary without a live parent writes a terminal
`handover.md`.

Before each new work package, the role checks whether it is nearing its return
point and stops scheduling when it is. `150000` is a documented budget, not a
quantity any role can measure about itself. Prefer exact host token telemetry
wherever the host provides it; otherwise return on a countable proxy from the
role's own history: completed work units, dispatches made, and its own tool
calls. These are provisional thresholds, due for revalidation over the next
2-3 sessions: a Worker returns after about 30 of its own tool calls; a Lead
returns after 3 completed work units or about 50 of its own tool calls,
whichever comes first; the Orchestrator hands over after about 20 dispatches.
Reaching a threshold is the normal end of a bounded stint, not an emergency:
it hands a fresh, focused successor the next unit of work. Cancellations,
retries, and failed units trigger reassessment and a compressed replacement
brief.

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
- The `permission.task` configuration above is not tested in this repository.
  The syntax is current per OpenCode documentation as of 2026-07, but
  task-permission behavior has changed across releases (for example, explicit
  task-deny objects on a subagent have not always been honored); verify the
  effective behavior on the installed version.
- Plugin and skill configuration is process policy only: the plugin registers
  skills but does not activate the workflow, create role agents, or set
  `subagent_depth` and permissions. The actual selected role, model, and limit
  may mismatch the configured role; the entry skill reports the mismatch rather
  than silently applying it.
