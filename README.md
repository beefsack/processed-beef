# Processed Beef

Processed Beef is a portable, skill-only three-role agent process: Orchestrator, Lead, and Worker. "Processed Beef" is a fun working name for a pre-release project; the design makes no stability claim.

Start a session by invoking only the `processed-beef` entry skill. It replaces manual SOP and orchestration loading: the entry skill activates the `processed-beef-orchestrate` skill, resolves effective role configuration, and reports the process roles and host preflight for all three roles. `process_role` and `parent_process_role` are the only blocking role fields. `agent_selector` is parent-recorded, model preference is optional, and host persona is distinct; a child never claims that a selector or model was applied.

## Roles

| Role | Skill | Responsibility |
|---|---|---|
| Orchestrator | `processed-beef` | Maintains backlog priorities, principles, decisions, role configuration, and cross-change dependencies; approves semantic specifications and plans; delegates major units to Leads; performs no implementation work |
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
- The Orchestrator approves `spec.md` and semantic `plan.md` creation or edits; Leads own plan record-keeping and baseline-preserving mechanical reconciliation.
- The user approves specifications before implementation and results before completion, unless the user explicitly requests autonomous mode.
- Autonomous mode delegates plan and specification approval but never governance authority or permission to contradict active governance.
- Before the first implementation dispatch, the parent records capability and required-child-skill preflight. A malformed or missing parent metadata packet, process-role mismatch, unavailable required child skill, or host/preflight rejection returns `dispatch-invalid` before source work. Selector, model, and persona observations are nonblocking when process roles match. The parent repairs one malformed role or capability packet once; baseline-preserving mechanical mismatches are reconciled locally.
- One Lead owns one major unit through serial Worker slices: each Worker returns `review-ready`, the Lead inspects the actual diff and evidence before accepting or rejecting, and exactly one pre-review implementation correction is permitted. One independent review produces one finding set and exactly one finding-fix correction; a second correction in either class trips that class's breaker. Confirmation checks only that set and is neither a review nor a correction. Missing, cancelled, and `host-unknown` results after the semantic boundary remain unsuccessful attempts that the Lead reconciles, never evidence; earlier failures are mechanical events.
- Independent review is mandatory only when a bounded trigger applies - security, authorization, migration, destructive behavior, public contracts, difficult rollback, suspicious results, or two failed semantic attempts on one unit - and routine work receives no duplicate review.
- The Lead, not the Worker, makes coherent commits of accepted groups and performs archive/completion administration. Startup records VCS policy; default is no agent commit or push. In user-owned commit mode, approved paths only are staged and one one-line commit message is returned. Rejected work has exactly one authorized bounded preservation container with a manifest and cleanup owner; stashes do not accumulate.

## Public Evidence Summary

Public summaries point to the normative [orchestration skill](skills/processed-beef-orchestrate/SKILL.md) and its [scheduling](skills/processed-beef-orchestrate/references/scheduling.md), [verification](skills/processed-beef-orchestrate/references/verification.md), and [artifact](skills/processed-beef-orchestrate/references/artifacts.md) references rather than reproducing their policy.

- Progress distinguishes semantic work, corrections, finding fixes, verification or harness repairs, mechanical reconciliation, and resets. A semantic attempt begins only when approved semantic source changes or a target live scenario or intended mutation begins; pre-effect tool, environment, dependency, command, output, evidence, and record failures consume no semantic budget. A bounded correction-regression repair remains one causality-bound repair after the immediately preceding correction and cannot widen semantics.
- Evidence is fresh only when tied to the current source snapshot, scoped diff and tracked/untracked inputs, with corresponding output. An optional warning baseline is informational and cannot mask failed assertions, nonzero commands, missing output, or unmet live prerequisites.
- Dependency cycles and production integration without an independently accepted fixture or harness dependency are pre-source `dispatch-invalid` conditions. Preservation inventories classify approved, modified, deleted, and untracked candidates; one manifest records reason, owner, retention, cleanup disposition, and deadline, with separate read and mutate authorization. Irreversible untracked deletion or overwrite escalates.
- Ledgers stay compact and change-wide where applicable, preserving serial execution, context defaults, existing correction/reset/parking limits, and portable-host language without claiming compatibility or host enforcement.

## v1 Constraints

- **Serial**: exactly one subagent is active at a time across the whole hierarchy; never parallelized, in any mode. The process is built for subscription quotas rather than large API spends, so this is a quota control first: concurrent agents burn quota in parallel, hit the ceiling without warning, and lose several agents' in-flight work at once. The latency cost is accepted deliberately.
- **Context ceiling**: each role has a configured context budget, default `150000` - a host configuration value, not a quantity any role can observe about itself. Behavior is driven by host token telemetry where available, otherwise by countable return thresholds taken from the role's own history. A threshold is a scheduling boundary, not an evidence-validity boundary: usable over-threshold work is reconciled once, not discarded and redispatched. The thresholds and their handover rules are stated in full in `skills/processed-beef-orchestrate/references/scheduling.md` under Context Limits.
- **Lifecycle and handovers**: A Worker returns `review-ready`, which is a review input, not acceptance or completion: the Lead inspects the actual diff and evidence and decides `accepted` or `rejected`. A rejected result before review gets exactly one pre-review implementation correction; an independent review finding set gets exactly one finding-fix correction. A second correction in either class trips its own breaker. `handover` is the only terminal status - it ends the outgoing agent, and a fresh subagent is also required after acceptance, changed scope, corrections, or further work. `review-ready`, `checkpoint`, `blocked`, and `decision-needed` are pause reports: the Worker resumes its same unfinished unit once the Lead answers or the condition clears. Reports and handovers return curated comprehensive chat reports, not persisted files or exhaustive transcripts.
- **Circuit breakers**: `plan.md` records deterministic change-wide semantic dispatches, `dispatch-invalid` results, corrections, reviews, resets, broad gates, tool-call proxies, progress credits, and no-progress. A semantic attempt begins when approved semantic source changes or the first target live scenario or intended mutation begins. Pre-effect mechanical failures do not consume semantic budgets. Three semantic attempts without a progress credit park and escalate. At most one changed-kind reset is permitted across all descendants of a change; a reset must change the acceptance mechanism, evidence boundary, fixture/oracle, or ownership, not only names or labels.
- **Fixture boundary**: a bounded fixture or harness-contract unit must be accepted before production integration. Its plan evidence covers state ownership, recursive child behavior where relevant, re-decode and snapshot restoration, failure injection where relevant, and public-route constraints. Fixture defects do not permit a production workaround and remain subject to unit and change-wide budgets. Verification is risk-tiered: focused commands run per unit and broad gates run once at a named risk or final checkpoint unless the plan justifies another run.
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
