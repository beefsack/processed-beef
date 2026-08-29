# Processed Beef

Processed Beef is a portable, skill-only delegation process for high-quality
software delivery with low parent context and progressively cheaper subagents.
Its governing target is [VISION.md](VISION.md). Maintainer process records live
outside installed skills: [AGENTS.md](AGENTS.md) is the maintainer authority,
[docs/decisions.md](docs/decisions.md) holds active durable decisions,
[docs/changes/](docs/changes/) holds active substantial-change state, and
[docs/learnings.md](docs/learnings.md) preserves separate historical evidence.

## Roles

| Role | Skill | Responsibility |
|---|---|---|
| Orchestrator | `processed-beef` | Long-lived frontier-model product and engineering partner; keeps priorities and material decisions aligned with the user and delegates coherent changes |
| Lead | `processed-beef-orchestrate` | Cheaper change owner; scopes work, delegates bounded units, inspects actual changes and evidence, and reports outcomes |
| Worker | `processed-beef-work-unit` | Cheapest capable execution tier; completes one bounded unit, verifies it, reports evidence, and never delegates |

The user has final authority over material decisions. Ordinary technical choices,
implementation, and verification proceed without artificial approval gates.

## Flow

1. The Orchestrator turns the user's goal into an outcome, constraints, material
   decision boundaries, and evidence expectations.
2. One Lead owns a coherent change. It delegates implementation, investigation,
   repetitive work, and output-heavy commands before loading expensive corpora.
3. Workers execute bounded units. The Lead accepts work only after inspecting
   the real diff, repository state, and current evidence.
4. Independent review is added only for risk, subtle breadth, suspicious output,
   or repeated semantic failure.
5. The Lead returns decisions, evidence, risks, and outcome. The Orchestrator
   checks user alignment without repeating implementation review or tests.

Small work needs no change note. A Lead uses one concise `docs/changes/` file
for substantial, long-running, risky, interrupted, or multi-unit work. It
covers the goal, material decisions, current plan, and accepted evidence; no
separate spec, plan, or log is required. Git and current verification remain
the primary truth.

## Core Controls

- One subagent at a time is the default subscription-quota control. The user may
  choose concurrency when work is isolated and recoverable.
- Parent context contains curated decisions and evidence, not raw implementation
  corpora, diffs, logs, or transcripts.
- A failed semantic approach is not retried without new evidence, a changed
  hypothesis, or a changed approach. Renaming agents or units creates no budget.
- Pre-effect command, environment, and record failures are repaired locally and
  do not consume semantic attempts.
- Destructive actions need explicit scope; irreversible external or non-versioned
  destruction needs user authority.
- Commits and pushes happen only when explicitly requested, and never with known
  acceptance gaps or unresolved serious findings.

## Prerequisites

Full operation uses nested subagents to depth two: Orchestrator to Lead to
Worker. When a host cannot provide that topology, the process reports the cost
or quality limitation and uses the shallowest safe alternative rather than
blocking unrelated work.

## Install

Install all three skills from this canonical repository:

```sh
npx skills add beefsack/processed-beef --all
```

```sh
gh skill install beefsack/processed-beef --all --agent <agent> --scope user
```

OpenCode can register them directly as a plugin:

```json
{
  "plugin": [
    "processed-beef@git+https://github.com/beefsack/processed-beef.git"
  ]
}
```

The plugin registers skills only. It does not activate the workflow, create role
agents, select models, or configure nesting and permissions.

## Configure

Per-role model selection belongs in each host's agent definitions. Use a
frontier model for the Orchestrator, a cheaper capable Lead, and the cheapest
capable Worker. Skills express the topology but cannot portably prove which
model the host selected.

Integration guides provide copyable role-agent configuration and host limits:

- [Claude Code](docs/integrations/claude-code.md)
- [Antigravity](docs/integrations/antigravity.md)
- [Codex](docs/integrations/codex.md)
- [OpenCode](docs/integrations/opencode.md)
- [VS Code](docs/integrations/vscode.md)

See [architecture.md](docs/architecture.md) for topology, authority, context,
and recovery design. [framework-comparison.md](docs/framework-comparison.md)
retains the research precedents.

## Limitations

- The project is pre-release; role agent names are not stable compatibility
  interfaces.
- Per-role model routing and Worker delegation denial depend on host support.
- Hosts do not consistently expose context telemetry or hard per-agent limits;
  bounded work and deliberate handover remain process policy.
