# Codex Integration

Codex enforces per-role models through custom agent TOML files. `AGENTS.md`
supplies project instructions only and cannot select a model. Skills live under
`.agents/skills` and provide the processed-beef role behavior; the TOML files
map role names to models. Config keys and cloud behavior are version-sensitive.

## Current Paths

| Scope | Path | Use |
|---|---|---|
| Project | `.codex/agents/*.toml` | Checked into version control; only loaded for trusted projects |
| User | `~/.codex/agents/*.toml` | Personal, available across projects |
| Project skills | `.agents/skills/` | Checked-in Agent Skills |
| User skills | `~/.agents/skills/` | Personal skills |

## Minimal Role-Agent Configuration

`model` is optional; when omitted the agent inherits the parent session model.

`.codex/agents/processed-beef-orchestrator.toml`
```toml
name = "processed-beef-orchestrator"
description = "Orchestrator for the processed-beef process. Use as the top-level session for processed-beef work."
developer_instructions = """
You are the processed-beef Orchestrator. Load the processed-beef skill and
follow it exactly. You perform no implementation work yourself.
"""
```

`.codex/agents/processed-beef-lead.toml`
```toml
name = "processed-beef-lead"
description = "Lead for the processed-beef process. Plans, dispatches Workers serially, and inspects evidence."
developer_instructions = """
You are the processed-beef Lead. Load the processed-beef-orchestrate skill and
follow it exactly.
"""
# Optional. Defaults to the parent session model when omitted. Insert a model
# ID shown by the installed host.
# model = "<model-id>"
```

`.codex/agents/processed-beef-worker.toml`
```toml
name = "processed-beef-worker"
description = "Worker for the processed-beef process. Executes one bounded unit from a Lead brief and returns evidence."
developer_instructions = """
You are the processed-beef Worker. Load the processed-beef-work-unit skill and
follow it exactly.
"""
# Optional. A cheaper model keeps Worker cost low. Insert a model ID shown by
# the installed host.
# model = "<model-id>"
```

## Model Selection

Each TOML file carries its own `model` key; the field is what enforces
per-role models. When omitted, the agent inherits the parent session model.
`AGENTS.md` is instructions only - it shapes behavior but cannot select a model
for a role. Skills are discovered and loaded independently of agents.

## Nested Subagents

Codex supports nested subagent delegation through custom agent definitions. The
available nesting depth is version- and configuration-sensitive; verify the
`[agents]` settings in `config.toml` for the running version.

Workers never delegate by portable policy, but this guide establishes no Codex
delegation-denial configuration: the agent TOML files above carry no task or
spawn-restriction syntax, and none is verified for the installed host. Do not
invent a deny key for `developer_instructions` or the agent TOML here. If your
installed Codex supports a spawn deny-list or a tool-exclusion mechanism,
verify it on the installed host and document it separately; until then,
enforcement is process policy only and must be verified from the installed
host.

## Context-Limit Reality

Codex does not provide a per-agent hard context ceiling the process can rely on.
The skills control context structurally with a long-lived strategic
Orchestrator, coherent Lead changes, bounded Worker units, and handover when the
next coherent objective will not fit. Configure a host limit as an additional
safeguard when available.

## Zero-Config Fallback

With no TOML files, the process still runs from the main session as
Orchestrator with the inherited model. Role behavior and serial dispatch come
from the skills. Per-role model routing is unavailable until the three TOML
files exist; the process reports the cost limitation when it is material.

## Known v1 Limitations

- No per-agent hard context ceiling; enforcement is process-level only.
- `AGENTS.md` cannot select per-role models; only agent TOML files can.
- Codex Cloud does not support per-role model selection in custom agents, so
  model routing is a CLI (local) capability.
- Project agent files load only for trusted projects.
- `developer_instructions`, not the filename, carries role behavior; keep the
  `name` field matching the stable role names.
