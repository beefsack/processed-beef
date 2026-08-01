# Processed Beef

Processed Beef is a portable, skill-only three-role agent process: Orchestrator, Lead, and Worker. "Processed Beef" is a fun working name for a pre-release project; the design makes no stability claim.

Start a session by invoking only the `processed-beef` entry skill. It replaces manual SOP and orchestration loading: the entry skill activates the `processed-beef-orchestrate` skill, resolves effective role configuration, and reports the agent names, model preferences, and context limits for all three roles, including any host mismatch.

## Roles

| Role | Skill | Responsibility |
|---|---|---|
| Orchestrator | `processed-beef` | Maintains coherence, priorities, principles, and decisions; approves every `spec.md` and `plan.md` creation or edit; delegates major units to Leads; performs no implementation work |
| Lead | `processed-beef-orchestrate` | Owns one major unit; creates Worker briefs; dispatches Workers serially; inspects the actual diff, files, and evidence, never a summary |
| Worker | `processed-beef-work-unit` | Executes one bounded unit from a Lead brief and returns verified evidence |

The Orchestrator normally runs as the top-level session. The Lead is a subagent one level down, and the Worker is a nested subagent two levels down.

## Adaptive Flow

The process routes work to the smallest suitable level and upgrades in place when complexity appears:

- **Micro** - clear, low-risk, single-purpose work with no lasting decision; the user request is the approved scope and no artifacts are created.
- **Standard** - normal features, non-trivial bugs, and work needing acceptance criteria; `spec.md`, `plan.md`, and `log.md`.
- **Expanded** - complexity discovered after routing; upgrades Standard in place, adding only triggered controls such as `state.md`, successive Leads, specialist review, or migration evidence.

## Governance

- The user owns `principles.md` and `decisions.md`; agents may propose changes, but only the user approves them.
- The Orchestrator approves every `spec.md` and `plan.md` creation or edit before it happens.
- The user approves specifications before implementation and results before completion, unless the user explicitly requests autonomous mode.
- Autonomous mode delegates plan and specification approval but never governance authority or permission to contradict active governance.

## v1 Constraints

- **Serial**: exactly one subagent is active at a time across the whole hierarchy; never parallelized, in any mode.
- **Context ceiling**: each role uses a configurable default `150000`-token context limit, enforced by the process. Near 85% of the effective limit, or when the next unit may exceed the remaining budget, a role writes `handover.md` and stops.
- **Crash recovery**: `log.md` is an append-only checkpoint log and Git is the recovery truth after abrupt session or quota loss; `handover.md` supports deliberate context transfer.

## Prerequisites

Full operation requires nested subagents to depth two: the Orchestrator dispatches a Lead, and the Lead dispatches a Worker. A host that cannot nest subagents is reported as such rather than silently flattening the quality hierarchy.

## Install

Install the three skills from the repository. The repository is not yet published, so replace the placeholder `<owner>` with the actual GitHub owner once it is.

This repository is the canonical source. Dotfiles and Nix configurations should
pin and consume it rather than copy or regenerate the skills.

```
npx skills add <owner>/processed-beef --all
```

```
gh skill install <owner>/processed-beef --all --agent <agent> --scope user
```

Local install from a checkout:

```
git clone https://github.com/<owner>/processed-beef.git
npx skills add ./processed-beef --all
```

For a manual install, copy the three directories inside `skills/` into the
destination documented by the relevant integration guide. Do not copy the
outer `skills/` directory as a single skill.

## Configure

Role customization comes from two places:

- `docs/agent-process.md` - an optional, ordinary Markdown file copied from `skills/processed-beef-orchestrate/assets/agent-process.md` that overrides agent names, model preferences, and context limits as portable policy.
- Host agent definitions - per-role model selection, configured in the host's own agent files.

Effective configuration resolves in order: explicit user instruction, `docs/agent-process.md`, user-level host agent definition, inherited defaults. The entry skill reports any host mismatch rather than claiming the preference was applied.

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
