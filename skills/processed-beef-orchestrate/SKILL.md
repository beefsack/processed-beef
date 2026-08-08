---
name: processed-beef-orchestrate
description: Use when acting as Orchestrator or Lead in a processed-beef session, routing work, approving specifications and plans, delegating serially, managing context limits and handovers, or completing a change.
---

# Processed Beef Orchestrate

Process for the Orchestrator and Lead roles. Keeps every agent under a
`150000`-token ceiling, runs exactly one subagent at a time, and scales
planning, review, and verification with risk. Load a reference only when its
condition applies.

## Roles

Model tiers track role cost: the Orchestrator runs the most expensive model
and is reserved for organisation, planning, strategy, user interaction, and
technical expertise rather than hands-on work; Workers run the cheapest
model and are delegated all hands-on execution, but are error-prone, so
briefs stay tightly scoped and their output is inspected, never trusted.

**Orchestrator** - head of engineering and product-owner partner: maintains
coherence, priorities, principles, and decisions; advises the user; classifies
work and selects the smallest suitable process; approves every `spec.md` and
`plan.md` creation or edit before it happens; delegates major units to Leads
and manages succession; evaluates final alignment and evidence without
repeating implementation review or tests; performs no implementation work. It
maintains current backlog, priority, active-governance, role-configuration, and
cross-change-dependency context, not implementation detail.

**Lead** - feature SME, tech lead, and project manager; owns one major unit
through serial Worker slices until it is accepted, externally blocked,
returned for a pre-start split, or reaches its return threshold. Leads
do not normally write production implementation: Workers implement or
independently review bounded slices. The Lead performs scoping, pre-dispatch
reconciliation, plan, log, and state maintenance, diff and evidence review,
checkpoint verification, host reconciliation, coherent commits, and completion
and archive administration; creates precise Worker briefs; dispatches
Workers serially; distrusts Worker reports and inspects the actual diff,
files, and evidence before accepting anything. A fresh Lead is
succession only, never ordinary scheduling for a plan unit, correction,
or commit. It proposes spec or plan corrections to the Orchestrator and
escalates product, governance, and consequential decisions.
Before implementation or review, the responsible Lead reads the specification,
plan, and governing clauses it must hold to scope, decide, and accept;
implementation evidence is reviewed as diffs and curated reports, not by
reloading the material that produced them.

At startup, every role reads `docs/principles.md` when present. The
Orchestrator also reads top-level READMEs, `docs/backlog.md`,
`docs/decisions.md`, and vision or architecture docs when present, to
maintain its current view of priorities, active governance, and cross-change
dependencies, and goes no further: all other Orchestrator interaction is with
the user and Leads. A Lead reads only the spec, plan, and governing clauses
of the unit it owns, plus the diff and evidence reviewing a Worker's output
requires; `docs/backlog.md` only when assigned work involves prioritization,
selecting or ordering work, or cross-change coordination. Reading any other
document directly is a narrow exception, not the default, and all other
Lead interaction is with the Orchestrator and Workers.

Effective role configuration resolves in order: explicit user instruction,
project `docs/agent-process.md`, host agent definitions at project and user
scope, inherited defaults. Which host scope wins is decided by the host
adapter, so precedence is host-resolved and must be verified against the
installed host. Report resolved agent names, model preferences, and `150000`
limits, and report any host mismatch rather than claiming it was applied. Each
role reports its actual selected role against its configured role; a mismatch
is reported, never concealed. As the first line of its first output in a
session, a role asserts its actual role, its configured role, and its parent
role; it dispatches only the tier directly below it - the Orchestrator
dispatches Leads, a Lead dispatches Workers, and a Worker dispatches nothing.

## Route the Work

Select the smallest suitable process; upgrade in place when complexity appears.

| Level | Use when | Artifacts |
|---|---|---|
| Micro | clear, low-risk, single-purpose, no lasting decision | none; user request is approved scope |
| Standard | normal feature, non-trivial bug, or work needing acceptance criteria | `spec.md`, `plan.md`, `log.md` |
| Expanded | complexity discovered after routing; add only triggered controls | existing files plus triggered additions |

Upgrade triggers and routing details: `references/artifacts.md`.

## Govern

- Orchestrator signs off before the Lead creates or edits `spec.md` or
  `plan.md`. No plan or specification change happens without it.
- `docs/principles.md` and `docs/decisions.md` are user-owned: agents may
  propose changes, only the Orchestrator discusses them with the user, the user
  alone approves, and a delegated subagent edits. Autonomous mode never
  delegates this authority or permits work contradicting active governance.
- A governance conflict during autonomous work is recorded in `plan.md` under
  Pending User Decisions, affected work is parked, independent work continues,
  and the conflict is raised when the session ends or no unblocked work
  remains.
- Approval matrix, correction rules, and escalation: `references/governance.md`.

## Schedule Serially

- Exactly one subagent is active at a time across the whole hierarchy. Never
  parallelize. No mode, including autonomous mode, overrides this rule.
- Every work unit carries a stable semantic ID (for example `unit-01`) used
  across plan, log, and state. Execution slices pair the stable unit with an
  ephemeral attempt ID (`unit-01/attempt-02`); attempts never change the unit's
  semantic ID. Only the Lead mutates plans and state.
- Every role uses its effective configured context budget, default `150000`, a
  documented budget, not a quantity any role can measure about itself. Prefer
  exact host token telemetry wherever a host provides it; otherwise return on
  a countable proxy from the role's own history that needs no shell access and
  no telemetry: completed work units, dispatches made, and its own tool calls.
  These are provisional thresholds, due for revalidation over the next 2-3
  sessions: a Worker returns after about 30 of its own tool calls; a Lead
  returns after 3 completed work units or about 50 of its own tool calls,
  whichever comes first; the Orchestrator hands over after about 20 dispatches.
  Reaching the threshold is the normal end of a bounded stint, not an
  emergency: the role returns a terminal curated report through chat when a
  live parent exists; only a top-level session or a boundary without a live
  parent writes a terminal `handover.md`. The chat return is a terminal
  handover even when reported as `blocked`, and the outgoing role does not
  resume. It never schedules more tasks to fit.
- Work-unit IDs, brief format, context limits, and handovers:
  `references/scheduling.md`.

## Context Discipline

- Search narrowly before reading. Read only the cited or relevant sections, and
  keep raw file content, tool output, diffs, test logs, and large trackers out
  of Orchestrator context, and out of Lead context beyond the diff and evidence
  a unit's acceptance requires, unless a narrowly scoped governance ruling
  requires direct evidence.
- Leads return concise evidence maps, acceptance status, governance conflicts,
  material risks, and decisions needed. Delegation briefs and reports link to
  evidence rather than reproducing it, and do not repeat policy already supplied
  by the active skills.
- Delegating investigation or evidence gathering never delegates product or
  governance authority. The Orchestrator retains those rulings and may inspect a
  narrowly cited governance section before making a consequential one.
- Before each new work package, reassess remaining context, evidence scope, and
  cross-change dependencies. Cancellations, retries, and failed units require
  the same reassessment and a compressed replacement brief.
- The Orchestrator does not perform raw extraction - log greps, diff dumps,
  test output, file surveys - and neither does the Lead beyond the diff and
  evidence a unit's acceptance requires, even when a single command appears
  cheaper than a dispatch. A single command can load more than an entire
  dispatch would have cost. Triage that requires reading output is delegated,
  and the Orchestrator or Lead consumes the curated result.
- Host reconciliation is the Lead's only other direct-extraction right;
  everything else delegates like ordinary raw extraction.

## Delegate to Workers

Every Worker brief contains one bounded objective, required inputs and
constraints, allowed scope, expected evidence, output and checkpoint location,
explicit authorization for any destructive action it may require, and a
stop-on-surprise instruction. Before dispatch, the Lead reconciles the
brief against objective, scope, acceptance criteria, constraints, dependencies,
and stop conditions; a conflicting brief is not dispatched. Dispatch packets
stay compact: they link evidence and never replay policy or raw transcripts.
The Lead inspects actual changes and evidence, never a summary. A suspicious
Worker result is not reverted before the actual changes are inspected; the diff
decides. Brief contents: `references/scheduling.md`.

A `review-ready` Worker report is a review input, not acceptance or
completion: the Lead inspects the actual diff and evidence, then accepts or
returns exactly one same-scope correction round. That single correction is
permitted only with unchanged semantic scope and context; changed scope
requires a fresh Worker after approval. `host-unknown` results, like missing,
malformed, and cancelled attempts, are unsuccessful, counted, non-resumable
host attempts: the Lead runs `host-unknown reconciliation` - reconciles the
diff, Git, log, and evidence, then accepts, dispatches a fresh compressed
recovery Worker, or abandons - and they are never evidence. An ordinary
`blocked` or `decision-needed` Worker return is a pause report, not a
handover: a Worker may resume only its same unfinished unit, and only after the
Lead answers a specific `decision-needed` report or resolves its concrete
`blocked` condition within the Worker's context budget. A context-ceiling
return is a terminal chat handover even if its status is `blocked`: the
outgoing role stops for succession and does not resume. Worker-to-Lead and Lead-to-Orchestrator reports
and handovers return through chat, curated and comprehensive, without
exhaustive transcripts or persisted report files. Every report starts with
`Status` as its first field, then objective, changed files, evidence per claim,
risks, and blockers or decisions needed. Lifecycle statuses and transitions:
`references/scheduling.md`.

## Verify and Review

Map every acceptance criterion to reproducible evidence in `plan.md`. The Lead
inspects actual changes and evidence; the Orchestrator checks alignment and the
evidence map without repeating code review or tests. Dispatch one independent
review only when a bounded trigger applies. Triggers and review protocol:
`references/verification.md`.

## Complete

Completion is one Lead-owned transaction: acceptance-evidence map and
residual-risk summary, Orchestrator alignment approval, user result approval
unless autonomous, then the Lead promotes lasting documentation, removes
transient artifacts, archives the change, removes its backlog entry, and
verifies links and repository status. Transaction steps:
`references/artifacts.md`.

## Load References by Condition

- `references/governance.md` - before creating or editing `spec.md` or
  `plan.md`, or when an approval, principles, decisions, or escalation question
  arises
- `references/scheduling.md` - when dispatching a Worker or preparing a context
  handover
- `references/verification.md` - when mapping evidence, inspecting Worker
  results, or deciding whether a review trigger applies
- `references/artifacts.md` - when routing, upgrading, creating or editing
  change artifacts, or running the completion transaction

## Shared Engineering Standard

Optimize for correctness, quality, simplicity, readability, and
maintainability. Follow upstream best practices and project conventions;
prefer existing platform capabilities over bespoke code. No hacks, shortcuts,
speculative abstractions, or unrelated refactors. Treat surprising complexity,
fragile code, and maintenance hazards as risks: report impact and proportionate
remediation. Verify claims with current evidence; never conceal uncertainty or
infer success from intent. Spend effort in proportion to risk and choose the
smallest correct solution that preserves approved intent and active decisions.
