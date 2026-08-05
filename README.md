# Processed Beef

Processed Beef is a portable, skill-only three-role agent process: Orchestrator, Lead, and Worker. "Processed Beef" is a fun working name for a pre-release project; the design makes no stability claim.

Start a session by invoking only the `processed-beef` entry skill. It replaces manual SOP and orchestration loading: the entry skill activates the `processed-beef-orchestrate` skill, resolves effective role configuration, and reports the agent names, model preferences, and context limits for all three roles. Each role reports its actual selected role against its configured role, model preference, and context limit; a mismatch is reported, never concealed.

## Roles

| Role | Skill | Responsibility |
|---|---|---|
| Orchestrator | `processed-beef` | Maintains backlog priorities, principles, decisions, role configuration, and cross-change dependencies; approves every `spec.md` and `plan.md` creation or edit; delegates major units to Leads; performs no implementation work |
| Lead | `processed-beef-orchestrate` | Owns one major unit across serial Worker slices; deeply reads the active change's relevant specification, plan, and evidence; creates Worker briefs and dispatches Workers serially; inspects the actual diff, files, and evidence and accepts or rejects a `review-ready` Worker result only by that inspection; makes coherent commits and archive/completion |
| Worker | `processed-beef-work-unit` | Executes one bounded unit from a Lead brief and returns `review-ready` evidence; never delegates |

The Orchestrator normally runs as the top-level session. The Lead is a subagent one level down, and the Worker is a nested subagent two levels down.

Every role reads `docs/principles.md` at startup when present. The Orchestrator
also reads `docs/backlog.md` and `docs/decisions.md` when present; Leads and
Workers read `docs/backlog.md` only when assigned work needs current priorities
or cross-change coordination. Workers otherwise read only their bounded brief
inputs, while Leads deeply read the active change's relevant specification and
plan before implementation or review.

## Adaptive Flow

The process routes work to the smallest suitable level and upgrades in place when complexity appears:

- **Micro** - clear, low-risk, single-purpose work with no lasting decision; the user request is the approved scope and no artifacts are created.
- **Standard** - normal features, non-trivial bugs, and work needing acceptance criteria; `spec.md`, `plan.md`, and `log.md`.
- **Expanded** - complexity discovered after routing; upgrades Standard in place, adding only triggered controls such as `state.md`, successive Leads, specialist review, or migration evidence.

## Governance

- The user owns `docs/principles.md` and `docs/decisions.md`; agents may propose changes, but only the user approves them.
- The Orchestrator approves every `spec.md` and `plan.md` creation or edit before it happens.
- The user approves specifications before implementation and results before completion, unless the user explicitly requests autonomous mode.
- Autonomous mode delegates plan and specification approval but never governance authority or permission to contradict active governance.
- One Lead owns one major unit through serial Worker slices: each Worker returns `review-ready`, the Lead inspects the actual diff and evidence before accepting or rejecting, and exactly one same-scope correction round is permitted with unchanged scope and context. Missing, malformed, cancelled, and `host-unknown` Worker results are unsuccessful, non-resumable host attempts that the Lead reconciles, never evidence.
- Independent review is mandatory only when a bounded trigger applies - security, authorization, migration, destructive behavior, public contracts, difficult rollback, suspicious results, or two failed attempts on one unit - and routine work receives no duplicate review.
- The Lead, not the Worker, makes coherent commits of accepted groups and performs archive/completion administration; Workers are never dispatched only to stage or commit.

## v1 Constraints

- **Serial**: exactly one subagent is active at a time across the whole hierarchy; never parallelized, in any mode.
- **Context ceiling**: each role uses a configurable default `150000`-token context limit, enforced by the process. Before each new work package, it checks remaining context and stops scheduling when the package may not fit. Near 85% of the effective limit, or when the next unit may exceed the remaining budget, a role with a live parent returns a terminal curated report through chat and stops; only a top-level session or a boundary without a live parent writes a terminal `handover.md`. Without exact host token telemetry, use `wc -c` or equivalent before each raw read to count each byte loaded into the role as one token; return before a read or package reaches 85% of the effective limit (`127500` bytes by default). Cancellations, retries, and failed units trigger reassessment and a compressed replacement brief.
- **Lifecycle and handovers**: A Worker returns `review-ready`, which is a review input, not acceptance or completion: the Lead inspects the actual diff and evidence and decides `accepted` or `rejected`. A rejected result returns exactly one same-scope correction round, then a fresh Worker after approval. Every actual handover is terminal and ends its outgoing agent; a fresh subagent is required after acceptance, handover, changed scope, corrections, or further work. An ordinary `blocked` or `decision-needed` return is a pause report, not a handover: a Worker may resume only its same unfinished unit, and only after a specific `decision-needed` answer or a resolved concrete `blocked` condition, within context budget. A context-ceiling return is a terminal chat handover even when reported as `blocked`: the outgoing agent stops for succession and does not resume. Worker-to-Lead and Lead-to-Orchestrator reports and handovers return curated comprehensive chat reports, not persisted files or exhaustive transcripts.
- **Crash recovery**: `log.md` is an append-only checkpoint log and Git is the recovery truth after abrupt session or quota loss; `handover.md` is reserved for a top-level session transfer or a boundary without a live parent where chat cannot bridge.

## Prerequisites

Full operation requires nested subagents to depth two: the Orchestrator dispatches a Lead, and the Lead dispatches a Worker. A host that cannot nest subagents is reported as such rather than silently flattening the quality hierarchy.

## Install

Install the three skills from the repository.

This repository is the canonical source. Dotfiles and Nix configurations should
pin and consume it rather than copy or regenerate the skills.

```
npx skills add beefsack/processed-beef --all
```

```
gh skill install beefsack/processed-beef --all --agent <agent> --scope user
```

Local install from a checkout:

```
git clone https://github.com/beefsack/processed-beef.git
npx skills add ./processed-beef --all
```

OpenCode can load the skills directly from the Git repository as a plugin:

```json
{
  "plugin": [
    "processed-beef@git+https://github.com/beefsack/processed-beef.git"
  ]
}
```

Restart OpenCode after changing plugin configuration. The plugin exposes the
skills but does not activate the workflow or configure role agents and nested
delegation; follow the [OpenCode integration guide](docs/integrations/opencode.md)
for those settings.

For a manual install, copy the three directories inside `skills/` into the
destination documented by the relevant integration guide. Do not copy the
outer `skills/` directory as a single skill.

## Configure

Role customization comes from two places:

- `docs/agent-process.md` - an optional, ordinary Markdown file copied from `skills/processed-beef-orchestrate/assets/agent-process.md` that overrides agent names, model preferences, and context limits as portable policy.
- Host agent definitions - per-role model selection, configured in the host's own agent files.

Effective configuration resolves in order: explicit user instruction, `docs/agent-process.md`, host agent definitions, inherited defaults. Host agent definitions exist at both project and user scope; which scope wins is decided by the host adapter (for example, one host takes the definition closest to the working directory, another merges project over global settings), so precedence is host-resolved rather than a fixed user-level-only rule. Verify scope precedence against the installed host. The entry skill reports any host mismatch rather than claiming the preference was applied.

## Guides

- `docs/architecture.md` - portable policy versus host enforcement, role configuration, and v1 constraints.
- Five first-class integration guides, each with a minimal copyable role-agent configuration, model selection semantics, nested-agent settings, context-limit reality, zero-config fallback, and known v1 limitations:
  - `docs/integrations/claude-code.md`
  - `docs/integrations/antigravity.md`
  - `docs/integrations/codex.md`
  - `docs/integrations/opencode.md`
  - `docs/integrations/vscode.md`
- `docs/framework-comparison.md` - the reviewed research evidence that motivated the design.

## Limitations

- Pre-release: "processed-beef" is a working name. The design is not stable, and renaming the project renames the role agent names without compatibility aliases.
- Serial v1: no parallel Leads or Workers and no concurrency setting.
- Hosts do not consistently provide per-agent hard context ceilings; the `150000` limit is enforced at the process level.
- Per-role model routing requires host agent definitions; with zero config all roles resolve to the inherited model.
- Worker non-delegation is portable policy that hosts enforce only to the extent their agent configuration supports it; the integration guides state what each host can deny and where exact delegation-denial syntax is not verified.
