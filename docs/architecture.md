# Architecture

Processed Beef is a portable, skill-only three-role agent process: Orchestrator,
Lead, and Worker. This document describes how the portable policy and each host's
enforcement mechanisms relate, how role configuration is resolved, and what the
v1 constraints are. It is human documentation and is never loaded into installed
skill context.

## Repository Canon

This standalone repository is the canonical source for the process, skills, and
documentation. Environment and dotfiles repositories, including Nix-managed
home configuration, consume a pinned release or source revision; they do not
maintain copied or generated skill implementations.

## Portable Policy Versus Host Enforcement

Agent Skills cannot select the model of a delegated subagent in a cross-host
way. The repository therefore separates two concerns:

- Portable policy - the process rules, role behavior, approvals, context
  limits, and serial dispatch. These live in the three skills under
  `skills/` and work identically on every host.
- Host enforcement - whether a named agent or a per-role model can actually
  be selected. This is configured per host, in that host's own agent files.
  See the integration guides in `docs/integrations/`.

A host adapter is the authority for whether an agent name or model can be
selected. The process reports any mismatch explicitly instead of claiming the
preference was applied.

## Stable Role Names

The stable role agent names are configuration interfaces, not bundled custom
agents. Users create host agent definitions with these names and map them to
their chosen models. Renaming the project before release renames these
pre-release interfaces without compatibility aliases.

| Role | Stable agent name | Skill | Default model | Default context limit |
|---|---|---|---|---|
| Orchestrator | `processed-beef-orchestrator` | `processed-beef` | inherit | 150000 |
| Lead | `processed-beef-lead` | `processed-beef-orchestrate` | inherit | 150000 |
| Worker | `processed-beef-worker` | `processed-beef-work-unit` | inherit | 150000 |

The Orchestrator normally runs as the top-level session. The Lead is a
subagent one level down, and the Worker is a nested subagent two levels down.

## Why Three Tiers

The hierarchy separates context and model cost from judgment. Cheap Workers
execute narrow, explicit units and are assumed fallible. A capable Lead becomes
the feature SME, writes precise briefs, and inspects every result. A frontier
Orchestrator retains project-wide product and engineering context, advises the
user, directs successive Leads, and avoids implementation detail. This allows
large quantities of work without any one role exceeding its context budget.

## Effective Role Configuration

Effective role configuration resolves in this order:

1. explicit user instruction for the current session;
2. project `docs/agent-process.md`;
3. user-level host agent definition;
4. inherited host and session defaults.

At session start, the `processed-beef` entry skill resolves and reports the
effective agent names, model preferences, and context limits for all three
roles, including configured overrides, and reports any host mismatch without
claiming the preference was applied.

`docs/agent-process.md` is an optional, ordinary Markdown file copied from the
bundled template `skills/processed-beef-orchestrate/assets/agent-process.md`.
It expresses portable policy only; the host adapter still decides whether a
name or model can actually be honored.

## Zero-Config Inheritance

With no host agent files and no `docs/agent-process.md`, the process runs only
when the host already provides generic depth-two subagents: a subagent that can
spawn another subagent. Where nesting requires configuration (a
`subagent_depth` setting, an allow-list setting, or an enabled toggle), the
entry skill stops and reports that depth two is unavailable rather than
flattening the quality hierarchy.

When it does run:

- the main session acts as Orchestrator using the inherited host defaults;
- all three roles resolve to the default model preference `inherit` and the
  `150000` context limit;
- the skills drive role behavior and serial dispatch.

Host agent definitions add per-role model selection on top of this baseline.
They are optional for the process itself but required for per-role model
routing.

## Nested-Agent Requirement

Full operation requires nested subagents to depth two: the Orchestrator
dispatches a Lead, and the Lead dispatches a Worker. A host that cannot nest
subagents reports the limitation rather than silently flattening the quality
hierarchy. Each integration guide documents whether its host supports nesting
and what setting enables it.

## Context-Limit Reality

Process context limits are always skill-enforced and optionally host-enforced.

- The target hosts do not consistently provide per-agent hard context
  ceilings, so v1 enforces the `150000` limit at the process level.
- Near 85% of the effective limit, or when the next unit may exceed the
  remaining budget, the role writes `handover.md` and stops. No role
  continues past its limit.
- Where a host offers a per-agent limit, treat it as an additional safeguard,
  not as the enforcement mechanism.

## Concurrency

Concurrency is fixed at `1`: exactly one subagent is active at a time across
the whole hierarchy, in every mode including autonomous mode. It is never
increased to parallelize independent work. V1 does not expose a concurrency
setting.

Parallel Leads or Workers require worktree isolation, conflict ownership,
per-unit recovery logs, deterministic merge order, quota accounting, and
changed review semantics. Those are a separate design and release.

## Documents

- `docs/framework-comparison.md` - reviewed research evidence that motivated
  the design, and retained design decisions with their precedents.
- `docs/integrations/claude-code.md`
- `docs/integrations/antigravity.md`
- `docs/integrations/codex.md`
- `docs/integrations/opencode.md`
- `docs/integrations/vscode.md`

Each integration guide provides a minimal copyable role-agent configuration,
project and user paths, model selection semantics, nested-agent settings,
context-limit reality, the zero-config fallback, and known v1 limitations.
