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
selected. `process_role` and `parent_process_role` are process metadata and the
only blocking role fields. A parent records `agent_selector`; model preference is
optional, host persona is distinct from both, and a child cannot claim that a
selector or model was applied. The process reports host mismatches explicitly.

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

At session start, the `processed-beef` entry skill reports the effective process
roles and parent-recorded selectors, optional model preferences, and host
persona. Before the first implementation dispatch, the parent preflights host
capability, depth, tools, and required child-skill availability. A child reports
only `process_role`, `parent_process_role`, and the capabilities it can observe;
it does not claim selector or model application.

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
- Nearing its return threshold, or when the next unit may exceed the remaining
  budget, a role reports `handover` and stops - through chat when a live parent
  exists, otherwise as `handover.md`. No role continues past its threshold.
- `150000` is a host configuration value, not a quantity any role can observe
  about itself, so behavior is driven by host token telemetry where available
  and otherwise by countable proxies from the role's own history. A threshold
  is a scheduling boundary, not an evidence-validity boundary. The current
  numbers are stated once, in `references/scheduling.md` under Context Limits,
  and are provisional pending revalidation.
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
  diff, files, and evidence; a rejected result returns exactly one pre-review
  implementation correction, and only with semantic scope and context unchanged.
  One independent review produces one finding set and exactly one finding-fix
  correction. A second correction in either class trips that class's breaker;
  confirmation checks only that set and is neither a review nor a correction.
  Changed scope requires a fresh Worker after approval.
- A malformed or missing parent metadata packet, process-role mismatch,
  unavailable required child skill, or host/preflight rejection is
  `dispatch-invalid` before source work. Selector, model, and persona
  observations are nonblocking when the process-role fields match. Pre-effect
  mechanical failures consume no semantic budget; a host failure becomes a
  counted `host-unknown` only after approved semantic source changes, a target
  live scenario, or an intended host mutation begins.
- The Lead, not the Worker, makes coherent commits of accepted groups (possibly
  spanning several accepted units) and performs archive/completion
  administration. Workers are never dispatched only to stage or commit and may
  commit only when substantive scope explicitly includes it.
- Independent review is dispatched only when a bounded trigger applies -
  security, authorization, migration, destructive behavior, public contracts,
  difficult rollback, broad or subtle changes, a suspicious or failed Worker
  result, or a consequential design choice introduced by the Lead - and routine
  work does not receive duplicated independent reviews.

## Circuit Breakers

`plan.md` records deterministic change-wide implementation dispatches, semantic
attempts, `dispatch-invalid` results, pre-review corrections, finding-fix
corrections, independent reviews, changed-kind resets, broad-gate runs, Worker
and Lead tool-call proxies, acceptance criteria moved, and the no-progress streak.
Semantic attempts begin when approved semantic source changes or a target live
scenario or intended mutation begins; `dispatch-invalid` and pre-effect
mechanical reconciliation are not attempts. The no-progress streak increments
after a semantic attempt earns no progress credit and resets on
`finding_closed`, `canonical_gate_advanced`, or
`acceptance_criterion_newly_met`. Three semantic attempts without a progress
credit park and escalate. A second pre-review correction trips the pre-review
breaker, and a second finding-fix correction
trips the finding-fix breaker. At most one changed-kind reset is allowed across
all descendants of a change; a second parks and escalates. A real reset must
change the acceptance mechanism, evidence boundary, fixture/oracle, or
ownership. A new name, label, or brief is not a reset.

## Public Evidence Summary

This summary points to the normative [orchestration skill](../skills/processed-beef-orchestrate/SKILL.md) and its [scheduling](../skills/processed-beef-orchestrate/references/scheduling.md), [verification](../skills/processed-beef-orchestrate/references/verification.md), and [artifact](../skills/processed-beef-orchestrate/references/artifacts.md) references.

- Work-kind progress distinguishes semantic attempts, corrections, finding fixes, verification or harness repairs, mechanical reconciliation, and changed-kind resets. A bounded correction-regression repair is one causality-bound repair after the immediately preceding correction, supported by fresh scoped evidence, restoring a formerly passing canonical gate without semantic widening. Only semantic attempts advance no-progress; pre-effect mechanical events do not. The one-pre-review-correction, one-finding-fix-correction, one-changed-kind-reset, and three-semantic-attempt limits remain.
- Fresh evidence binds the source snapshot, scoped diff, relevant tracked/untracked inputs, output correspondence, and post-change freshness. A warning baseline is optional and informational only; it cannot mask failed assertions, nonzero commands, missing output, or unmet live prerequisites.
- Dependency cycles and production integration without an independently accepted fixture or harness dependency are pre-source `dispatch-invalid` conditions. Preservation inventories classify approved, modified, deleted, and untracked candidates, while one manifest retains reason, owner, retention, cleanup disposition, and deadline with separate read and mutate authorization. Irreversible untracked deletion or overwrite escalates.
- Ledgers remain compact and change-wide where applicable. These summaries preserve serial execution, the `150000` context default, existing correction/reset/parking limits, and portable-host language; they do not claim compatibility or host enforcement.

Rejected work is preserved in exactly one authorized bounded container with a
manifest, retention reason, and cleanup owner. Every implementation brief cites
plan-owned gate IDs, literal canonical commands, and expected baselines; the
parent compares that packet with the plan evidence map before source work. A
mismatch is `dispatch-invalid`; if a Worker runs a wrong local command, the Lead
reruns and reconciles the canonical gate locally without a user decision. The
plan records risk-tier gate IDs and literal commands: focused evidence runs per
unit, while broad gates run once at a named risk or final checkpoint unless
justified. A bounded fixture or harness-contract unit is accepted before
production integration, with evidence for state ownership, recursive child
behavior where relevant, re-decode and snapshot restoration, failure injection
where relevant, and public-route constraints. A fixture failure never
authorizes a production workaround.

## Handover Boundaries

`handover` is the only terminal status: it ends the reporting agent, and a
fresh subagent is required after it, and after acceptance, changed scope,
corrections, or further work. Every other status is a pause report. The sole
resumption is the same unfinished Worker unit after the parent answers a
specific `decision-needed` report or resolves a concrete `blocked` condition,
and only while the Worker remains within its context budget. Keeping the
terminal case in its own status is deliberate: an earlier design overloaded
`blocked` with both meanings and had to restate the distinction in eight
places.

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

This process is optimised for subscription quotas, not large API spends, and
serialization is a quota-management control before it is a state-safety one.
Concurrent agents burn quota in parallel and hit the ceiling without warning,
and recovery from that is expensive: work in flight across several agents is
lost at once, mid-unit, with no clean handover. One agent at a time makes
consumption observable, makes the stopping point a unit boundary, and keeps a
quota exhaustion recoverable from `log.md` and Git.

Serialization therefore costs wall-clock latency by design, and that cost is
accepted. Do not propose relaxing it as an efficiency measure - including for
read-only work on disjoint paths - without the quota accounting that would make
parallel consumption predictable. Parallel Leads or Workers additionally
require worktree isolation, conflict ownership, per-unit recovery logs,
deterministic merge order, and changed review semantics. Those are a separate
design and release.

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
