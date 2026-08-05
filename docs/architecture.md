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

Every role reads `docs/principles.md` at startup when present. The Orchestrator
also reads `docs/backlog.md` and `docs/decisions.md` when present to build a
current view of priorities and cross-change dependencies. It does not normally
consume full change specifications or plans, implementation files, review
corpora, raw diffs, test logs, or large trackers. Leads deeply read the active
change's relevant specification and plan before implementation or review, then
return concise evidence maps, acceptance status, governance conflicts, material
risks, and decisions needed. Leads and Workers read `docs/backlog.md` only when
assigned work involves prioritization, selecting or ordering work, cross-change
coordination, or otherwise needs current priorities. Workers read only their
bounded brief inputs beyond the universal files, not unrelated plans or the
wider backlog. Evidence gathering does not transfer product or governance
authority; for a consequential ruling, the Orchestrator may inspect the
narrowly cited governing clause directly. It approves specifications and plans
from the Lead's report unless an ambiguity or consequential decision requires a
narrowly cited proposal section.

## Effective Role Configuration

Effective role configuration resolves in this order:

1. explicit user instruction for the current session;
2. project `docs/agent-process.md`;
3. host agent definitions at project and user scope;
4. inherited host and session defaults.

Host agent definitions live in both scopes for every host (for example project
`.opencode/agents/` or `.claude/agents/` versus the user-level equivalents).
Which scope wins is decided by the host adapter, not the process: one host takes
the definition closest to the working directory, another merges project settings
over global ones. Precedence is therefore host-resolved rather than a fixed
user-level-only rule, and must be verified against the installed host.

At session start, the `processed-beef` entry skill resolves and reports the
effective agent names, model preferences, and context limits for all three
roles, including configured overrides, and reports any host mismatch without
claiming the preference was applied. Each role reports its actual selected role
against its configured role, model preference, and context limit; a mismatch is
reported, never concealed.

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
  remaining budget, a role with a live parent returns a terminal curated
  report through chat and stops; a top-level session or a boundary without a
  live parent writes a terminal `handover.md`. No role continues past its
  limit.
- Before each new work package, the responsible role checks whether the
  remaining context can accommodate its evidence and report, and stops
  scheduling before the ceiling when it cannot. Without exact host token
  telemetry, use `wc -c` or equivalent before each raw read to count each byte
  loaded into the role as one token; return before a read or package reaches
  85% of the effective limit (`127500` bytes by default). Cancellations,
  retries, and failed units trigger a reassessment and a compressed replacement
  brief.
- Where a host offers a per-agent limit, treat it as an additional safeguard,
  not as the enforcement mechanism.

## Lead-Owned Lifecycle

One Lead owns one major unit across serial Worker slices. Every Worker dispatch
is reconciled against the objective, scope, acceptance criteria, constraints,
dependencies, and stop conditions before it is sent. Workers never delegate: no
subagent or task invocation, enforced by portable policy and, where a host's
configuration supports it, by the host. A Worker returns
`review-ready`, which is a review input, not acceptance or completion:

- `review-ready` is accepted or rejected only by Lead inspection of the actual
  diff, files, and evidence; a rejected result returns exactly one same-scope
  correction round, and only with semantic scope and context unchanged. Changed
  scope requires a fresh Worker after approval.
- Missing, malformed, cancelled, and `host-unknown` Worker results are
  unsuccessful, counted, non-resumable host attempts, never evidence. The Lead
  runs `host-unknown reconciliation`: it reconciles the diff, Git, log, and
  evidence, then accepts usable work, dispatches a fresh compressed recovery
  Worker, or abandons the attempt. Two unsuccessful attempts on one work unit
  force Orchestrator reassessment.
- The Lead, not the Worker, makes coherent commits of accepted groups (possibly
  spanning several accepted units) and performs archive/completion
  administration. Workers are never dispatched only to stage or commit and may
  commit only when substantive scope explicitly includes it.
- Independent review is dispatched only when a bounded trigger applies -
  security, authorization, migration, destructive behavior, public contracts,
  difficult rollback, broad or subtle changes, a suspicious or failed Worker
  result, or a consequential design choice introduced by the Lead - and routine
  work does not receive duplicated independent reviews.

## Handover Boundaries

Every actual handover is terminal: it ends the reporting or handing-off agent,
and a fresh subagent is required after acceptance, handover, changed scope,
corrections, or further work. An ordinary `blocked` or `decision-needed` return
is a pause report, not a handover: the sole resumption exception is the same
unfinished Worker unit after the parent answers a specific `decision-needed`
report or resolves its concrete `blocked` condition, and only while the Worker
remains within its context budget. A context-ceiling return is a terminal chat
handover even if its status is `blocked`: the outgoing agent stops for
succession and does not resume.

Worker-to-Lead and Lead-to-Orchestrator reports and actual handovers return
through chat as curated, comprehensive reports, never as persisted report files
or exhaustive transcripts. `handover.md` is reserved for a top-level session
transfer or a boundary without a live parent where chat cannot bridge; writing
it ends the outgoing agent and a successor starts fresh.

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
