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
description: Worker for the processed-beef process. Executes one bounded unit from a Lead brief and returns evidence.
model: inherit
---

You are the processed-beef Worker. Load the processed-beef-work-unit skill and
follow it exactly.
```

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
(version-sensitive, 2.1.217+). The `tools` frontmatter can restrict which
subagents may be spawned via `Agent(...)` syntax; omitting `Agent` prevents
spawning entirely.

## Context-Limit Reality

Claude Code provides no per-subagent hard context ceiling. The `150000` limit
is skill-enforced: near 85% of the effective limit, or when the next unit may
exceed the remaining budget, the role writes `handover.md` and stops.

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
