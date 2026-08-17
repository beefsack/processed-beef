# Claude Code Integration

Claude Code enforces per-role models through Markdown subagent files with YAML
frontmatter. Place one file per role. Details are current for Claude Code CLI
2.1.x; model aliases and depth controls are version-sensitive.

## Current Paths

| Scope | Path | Use |
|---|---|---|
| Project | `.claude/agents/` | Checked into version control, shared with the team; scanned by walking up from the working directory |
| User | `~/.claude/agents/` | Personal, available in every project |

Files can be organized in subfolders; identity comes only from the `name`
frontmatter field, not the path. On a name collision, the definition closest to
the working directory wins. Restart the session after creating a brand-new
`agents` directory.

## Minimal Role-Agent Configuration

Three small files. `model` is optional; omit it or use `inherit` to follow the
main session model.

`.claude/agents/processed-beef-orchestrator.md`
```markdown
---
name: processed-beef-orchestrator
description: Orchestrator for the processed-beef process. Use as the top-level session for processed-beef work.
model: inherit
---

You are the processed-beef Orchestrator. Load the processed-beef skill and
follow it exactly. You perform no implementation work yourself.
```

`.claude/agents/processed-beef-lead.md`
```markdown
---
name: processed-beef-lead
description: Lead for the processed-beef process. Plans, dispatches Workers serially, and inspects evidence.
model: inherit
---

You are the processed-beef Lead. Load the processed-beef-orchestrate skill and
follow it exactly.
```

`.claude/agents/processed-beef-worker.md`
```markdown
---
name: processed-beef-worker
description: Worker for the processed-beef process. Executes one bounded unit from a Lead brief and returns evidence. Never delegates.
tools: Read, Glob, Grep, Edit, Write, Bash, WebFetch, WebSearch, Skill
model: inherit
---

You are the processed-beef Worker. Load the processed-beef-work-unit skill and
follow it exactly.
```

The Worker's `tools` list is an allowlist that deliberately omits `Agent`: a
subagent with no `Agent` entry cannot spawn any subagents. Keep the other
entries because the list replaces the inherited tool pool; add any tool the
Worker needs for its bounded unit. The Orchestrator and Lead files above have no
`tools` field, so they inherit every tool available to subagents, including
`Agent`, and can spawn; restricting which types they may spawn is covered under
Nested Subagents below.

## Model Selection

`model` accepts an alias (`sonnet`, `opus`, `haiku`, `fable`), a full model ID,
or `inherit` (default). The effective model resolves in this order:

1. `CLAUDE_CODE_SUBAGENT_MODEL` environment variable, when set;
2. the per-invocation model parameter passed when Claude delegates;
3. the subagent file's `model` frontmatter;
4. the main conversation's model.

Because the per-invocation parameter outranks frontmatter, an Orchestrator can
route a specific Worker to a cheaper model without editing files. Values are
checked against the organization `availableModels` allowlist; an excluded value
falls back to the inherited model.

## Nested Subagents

Supported by default. A subagent can spawn its own subagents up to three layers
below the main conversation, which covers the Orchestrator to Lead to Worker
depth. The default can be changed with `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`
(version-sensitive, 2.1.217+).

Workers never delegate by portable policy. Claude Code enforces the denial only
through the existing `tools`/`Agent(...)` mechanism:

- Omitting `Agent` from a role's `tools` list prevents it from spawning any
  subagent with the Agent tool. The Worker file above does this.
- `Agent(agent_type)` in a `tools` list is an allowlist that restricts which
  subagent types may be spawned. This applies only to an agent running as the
  main thread via `claude --agent <name>`; in a subagent definition, listing
  `Agent` lets that subagent spawn while the depth limit allows it, but any type
  list inside the parentheses is ignored.
- So the Orchestrator, launched as the top-level session with
  `claude --agent processed-beef-orchestrator`, can be restricted to spawn only
  the Lead with `tools: Agent(processed-beef-lead), ...`. The Lead is a subagent,
  so Claude Code does not host-enforce which types it spawns: the Lead's
  dispatch of only Workers is enforced by process policy, not by this
  configuration.
- The exact behavior is version-sensitive; verify the effective nesting depth
  and spawn restrictions against the installed CLI.

## Context-Limit Reality

Claude Code provides no per-subagent hard context ceiling. The `150000` limit
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

With no agent files, the process still runs from the main session as
Orchestrator with the inherited model. Role behavior and serial dispatch come
from the skills. Per-role model routing is unavailable until the three agent
files exist; the entry skill reports that mismatch.

## Known v1 Limitations

- No per-agent hard context ceiling; enforcement is process-level only.
- The `model` allowlist can silently downgrade a requested model.
- Model aliases and the depth environment variable change between CLI versions;
  verify against the installed version.
- Managed (organization) agent definitions override project and user files.
- A subagent at the depth limit does its delegated work itself and returns one
  summary, so verify the effective nesting depth before relying on it.
