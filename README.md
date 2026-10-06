# Processed Beef

Processed Beef is a portable, skill-only delegation process for high-quality
software delivery with low parent context and progressively cheaper subagents.
Its strict project-wide design boundaries are [docs/principles.md](docs/principles.md),
owned by the user and constraining plans, designs, decisions, and work.
Maintainer process records live outside installed skills: [AGENTS.md](AGENTS.md)
is the maintainer authority. The canonical records are [docs/principles.md](docs/principles.md)
for strict, user-owned project-wide design boundaries, [docs/backlog.md](docs/backlog.md) is the Orchestrator-owned
concise prioritized list with one linked priority/dependency line per pending or
active meaningful change, and [docs/decisions.md](docs/decisions.md) holds concise active
decisions. Supporting records include [docs/changes/](docs/changes/) for active
meaningful-change notes and [docs/learnings.md](docs/learnings.md) for separate
historical evidence. A separate product `VISION.md`, when present, is goal input only, not
Processed Beef governance.

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
   decision boundaries, and evidence expectations, passing useful knowledge to
   the Lead rather than making it rediscover known facts.
2. One Lead owns a coherent change. It delegates implementation, investigation,
   repetitive work, and output-heavy commands before loading expensive corpora.
3. Workers execute coherent bounded assignments using relevant context and facts
   passed by the Lead. The Lead accepts work only after inspecting the
   real diff, repository state, and current evidence.
4. Parents resume agents for unknowns, direction, corrections, and small
   follow-ups; prefer fresh agents briefed from handovers for new items or units,
   crowded, stale, or unrelated context, or independent review. Substantial
   completed work is assumed to leave little capacity. Independent review is
   added only for risk, subtle breadth, suspicious output, or repeated semantic
   failure.
5. Subagents return results and lean handovers with reusable discoveries and
   source locations for successor briefs. The Orchestrator checks user alignment
   without repeating implementation review or tests.

Trivial requests use the request directly. Each meaningful change has one
Lead-owned `docs/changes/<slug>.md` combining compact specification and current
plan, plus an Orchestrator-prioritized backlog line. Update the note only for
meaningful changes. At completion, verify acceptance, promote authorized durable
decisions, retain concise outcome/evidence, archive the note, and advance or
remove its backlog line. No approval gate, log, state or recovery file, routine
progress record, retry ledger, tick, or completion transaction is required.

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

The three skills work together; install all of them. Installing registers skills
only. It does not activate the workflow, create role agents, select models, or
configure nesting and permissions; see [Configure](#configure).

### OpenCode (auto-updating)

Add the skill index to global `~/.config/opencode/opencode.json` or a project
`opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "skills": {
    "urls": [
      "https://raw.githubusercontent.com/beefsack/processed-beef/main/skills/"
    ]
  }
}
```

Restart OpenCode. On every start it fetches `skills/index.json` and re-downloads
any skill whose version changed. If the index cannot be fetched, for example
offline, the skills are unavailable for that session.

Upgrading from the former `processed-beef@git+https://...` plugin entry: remove
it from `plugin`, then delete its stale cache directory,
`~/.cache/opencode/packages/processed-beef@git+https_` (the same path under
your user profile on Windows).

### Claude Code, Codex, Cursor, Gemini CLI, GitHub Copilot, and others

Use either installer. Both support many more hosts than listed here and update
on request, not automatically.

With [`npx skills`](https://github.com/vercel-labs/skills):

```sh
npx skills add beefsack/processed-beef --skill '*' -g -a claude-code
npx skills update -g
```

With [`gh skill`](https://cli.github.com/manual/gh_skill) (GitHub CLI):

```sh
gh skill install beefsack/processed-beef --all --agent claude-code --scope user
gh skill update --all
```

Replace `claude-code` with `codex`, `cursor`, `gemini-cli`, `github-copilot`,
`antigravity`, or `opencode`, or repeat `-a` to target several hosts with
`npx skills`. Omit `-g` or `--scope user` to install into the current project
instead. `gh skill` installs the latest tagged release, or the default branch
when no release is tagged.

### Manual

Copy each directory under [`skills/`](skills/) into your host's skills
directory, for example `~/.claude/skills/` for Claude Code. Repeat to update.

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

- Role agent names are not stable compatibility interfaces.
- Per-role model routing and Worker delegation denial depend on host support.
- Hosts do not consistently expose context telemetry or hard per-agent limits;
  bounded work and deliberate handover remain process policy.
