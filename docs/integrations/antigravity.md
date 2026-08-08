# Antigravity Integration

Antigravity (including Antigravity CLI, the successor to Gemini CLI) enforces
per-role models through Markdown agent files with YAML frontmatter. Model
tiers, discovery paths, and the sandbox rule are version-sensitive; verify
against the installed CLI.

## Current Paths

| Scope | Path | Use |
|---|---|---|
| Workspace | `.agents/agents/` | Checked into version control, shared with the team |
| Global | `~/.gemini/config/agents/` | Personal, available in every workspace |

The `/agents` panel prints the exact template locations it scans. Some CLI
versions expect `.agents/agents/<name>.md` flat files; others accept a nested
`<name>/agent.md` directory per agent. Confirm the layout the running version
reports before writing files.

## Minimal Role-Agent Configuration

`model` accepts `inherit` (default), `flash`, or `pro`. Use `inherit` to follow
the main session model.

`.agents/agents/processed-beef-orchestrator.md`
```markdown
---
name: processed-beef-orchestrator
description: Orchestrator for the processed-beef process. Use as the top-level session for processed-beef work.
model: inherit
---

You are the processed-beef Orchestrator. Load the processed-beef skill and
follow it exactly. You perform no implementation work yourself.
```

`.agents/agents/processed-beef-lead.md`
```markdown
---
name: processed-beef-lead
description: Lead for the processed-beef process. Plans, dispatches Workers serially, and inspects evidence.
model: inherit
---

You are the processed-beef Lead. Load the processed-beef-orchestrate skill and
follow it exactly.
```

`.agents/agents/processed-beef-worker.md`
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

`model` defaults to `inherit` and uses the main session model. Set it to
`flash` or `pro` to pin a tier, so the Lead can run a stronger model than the
Worker. The same file also accepts a tool allowlist (`tools`); omit it to
inherit from the parent session.

## Nested Subagents

Antigravity supports nested subagent delegation sufficient for the
Orchestrator to Lead to Worker requirement. Nested invocation happens through
the runtime's subagent mechanism, not through file configuration alone; verify
the effective limit in the installed version.

Workers never delegate by portable policy, but this guide establishes no
Antigravity delegation-denial configuration: the agent files above carry no
spawn or task restriction, the `tools` allowlist described under Model Selection
is a tool filter, not a verified delegation-denial mechanism, and no exact
denial syntax is verified for the installed host. Do not invent one here. If
your installed Antigravity supports a spawn or task restriction, verify it on
the installed host and document it separately; until then, enforcement is
process policy only and must be verified from the installed host.

## Context-Limit Reality

Antigravity does not provide a per-agent hard context ceiling in v1. The
`150000` limit is skill-enforced: nearing its return threshold, or when the
next unit may exceed the remaining budget, a role with a live parent returns a
terminal curated report through chat and stops; the return is a terminal chat
handover even when reported as `blocked`, and the outgoing role does not
resume. Only a top-level session or a boundary without a live parent writes a
terminal `handover.md`.

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

With no agent files, the process still runs from the main session as
Orchestrator with the inherited model. Role behavior and serial dispatch come
from the skills. Per-role model routing is unavailable until the agent files
exist; the entry skill reports that mismatch.

## Known v1 Limitations

- No per-agent hard context ceiling; enforcement is process-level only.
- The execution sandbox may restrict background subagent invocations to
  pre-registered type names, which can block direct calls to custom type names
  such as `processed-beef-worker`. Verify invocation works in the running
  version; a documented workaround is to invoke through an approved type name
  and inject the role instructions.
- Discovery layout (flat file versus nested directory) differs across versions.
- Global agents live under `~/.gemini/config/agents/`, retaining the Gemini CLI
  path even though the product is Antigravity.
