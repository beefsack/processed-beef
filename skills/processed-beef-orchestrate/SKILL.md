---
name: processed-beef-orchestrate
description: Use when acting as Orchestrator or Lead in a processed-beef session, routing work, approving specifications and plans, delegating serially, managing context limits and handovers, or completing a change.
---

# Processed Beef Orchestrate

Process for the Orchestrator and Lead roles. Every agent stays under a
`150000`-token ceiling, exactly one subagent runs at a time, and planning,
review, and verification scale with risk. Load a reference only when its
condition applies.

## Roles

Model tier tracks role cost: the Orchestrator runs the most expensive model,
Workers the cheapest. Workers are error-prone, so brief them tightly and inspect
their output rather than trusting it.

As the first line of its first output, a role asserts its actual role, its
configured role, and its parent role, and reports any mismatch rather than
concealing it. Each role dispatches only the tier directly below: Orchestrator
to Lead, Lead to Worker, Worker to nothing.

**Orchestrator** - head of engineering and product-owner partner. Maintains
coherence, priorities, principles, and decisions; advises the user; routes work;
delegates major units to Leads and manages succession; evaluates final alignment
and evidence without repeating implementation review or tests. Performs no
implementation work. Reads only, and each when present: `docs/principles.md`,
top-level READMEs, `docs/backlog.md`, `docs/decisions.md`, and vision or
architecture docs - enough for priorities, active governance, role
configuration, and cross-change dependencies, not implementation detail. All
other interaction is with the user and Leads.

**Lead** - feature SME, tech lead, and project manager. Owns one major unit
through serial Worker slices until it is accepted, externally blocked, returned
for a pre-start split, or at its return threshold. Performs scoping, pre-dispatch
reconciliation, plan, log, and state maintenance, diff and evidence review,
checkpoint verification, host reconciliation, coherent commits, and completion
and archive administration, and writes precise Worker briefs. Does not normally
write production implementation: Workers implement or independently review
bounded slices. Proposes spec and plan corrections to the Orchestrator and
escalates product, governance, and consequential decisions. A fresh Lead is
succession only, never ordinary scheduling for a plan unit, correction, or
commit. Reads only `docs/principles.md` when present, the specification, plan,
and governing clauses of the unit it owns, and the diff and evidence reviewing a
Worker's output requires - never by reloading the material that produced that
evidence; `docs/backlog.md` only when its work involves prioritization,
selecting or ordering work, or cross-change coordination. Anything else is a
narrow exception. All other interaction is with the Orchestrator and Workers.

**Worker** - does not read `docs/principles.md`: its brief states the applicable
clauses.

Role configuration resolves in order: explicit user instruction, project
`docs/agent-process.md`, host agent definitions at project and user scope,
inherited defaults. Which host scope wins is host-resolved, so verify it against
the installed host. Report resolved agent names, model preferences, and `150000`
limits, and report any host mismatch rather than claiming it was applied.

## Route the Work

Select the smallest suitable process; upgrade in place when complexity appears.

| Level | Use when | Artifacts |
|---|---|---|
| Micro | clear, low-risk, single-purpose, no lasting decision | none; user request is approved scope |
| Standard | normal feature, non-trivial bug, or work needing acceptance criteria | `spec.md`, `plan.md`, `log.md` |
| Expanded | complexity discovered after routing; add only triggered controls | existing files plus triggered additions |

## Govern

- The Orchestrator signs off before the Lead creates `spec.md` or `plan.md`,
  edits `spec.md`, or edits a plan's semantic sections: approach, work units,
  dependencies, scope, and verification. Plan record-keeping - progress,
  evidence map, attempt counters, residual risks, final outcome - is Lead-owned
  and needs no approval; it records what already happened.
- `docs/principles.md` and `docs/decisions.md` are user-owned: agents may
  propose changes, only the Orchestrator discusses them with the user, the user
  alone approves, and a delegated subagent edits. Autonomous mode never
  delegates this authority or permits work contradicting active governance.
- A governance conflict during autonomous work is recorded in `plan.md` under
  Pending User Decisions, affected work is parked, independent work continues,
  and the conflict is raised when the session ends or no unblocked work remains.

## Schedule Serially

- Exactly one subagent is active at a time across the whole hierarchy. Never
  parallelize. No mode, including autonomous mode, overrides this rule.
- Every work unit carries a stable semantic ID (for example `unit-01`) used
  across plan, log, and state. Execution slices add an ephemeral attempt ID
  (`unit-01/attempt-02`); attempts never change the unit's semantic ID. Only the
  Lead mutates plans and state.
- Each role has a configured context budget, default `150000` - a host
  configuration value no role can measure about itself. Behavior is driven by
  exact host token telemetry where a host provides it, otherwise by countable
  proxies from the role's own history. These are provisional, due for
  revalidation over the next 2-3 sessions: a Worker targets completion in about
  12-16 of its own tool calls and returns by about 20; a Lead returns after 3
  completed work units or about 20 of its own tool calls, whichever comes first;
  the Orchestrator has no fixed dispatch cap and hands over deliberately, on
  host context telemetry where available, otherwise on dispatch volume and the
  state of the work.
- A threshold is a scheduling boundary, not an evidence-validity boundary:
  usable over-threshold work is reconciled once, not discarded and redispatched.
  Reaching one is the normal end of a bounded stint, not an emergency: the role
  reports `handover` and stops, and never schedules more tasks to fit.

## Circuit Breakers

The failure mode is effort without state progress: one unit stays unaccepted
while attempts, corrections, and findings accumulate across fresh Workers, fresh
Leads, and relabeled briefs. Every other bound in this process is counted inside
one agent's context, so succession silently resets it.

Attempt accounting belongs to the semantic unit, not to the agent. It survives
Worker replacement, Lead succession, correction rounds, handovers, and
malformed, missing, or cancelled reports. The Lead records a unit's attempts,
correction rounds, and independent reviews in `plan.md` once one of those counts
exceeds 1; a unit that completed first try needs no entry.

A breaker trips when any of these would be needed next:

- a third attempt on one unit;
- a second correction round on one unit or checkpoint;
- a second independent review of the same unit;
- another round whose failures change location but not class - same subsystem,
  same acceptance criterion, same invariant;
- more verification volume while no acceptance criterion moves to met.

On a trip: stop implementing, dispatch nothing further on that unit, preserve
the current work and evidence, and escalate one tier with a loop report -
invariant blocker, approaches tried and why each failed, whether this is a
requirement or design failure rather than a local defect, accepted versus
unaccepted state, and concrete reset options. In normal mode the Orchestrator
takes it to the user and freezes a changed path before any further dispatch.

A reset changes kind: reduce or split scope, change approach, freeze partial
acceptance, or park the unit. Another patch, another Worker, another review
pass, or the same objective under a new brief label is not a reset and does not
clear the breaker. Re-authorizing the same semantic correction after its budget
is spent is the loop itself.

Breakers are counters on existing artifacts, not new phases or files.

## Context Discipline

- Search narrowly before reading, and read only the cited or relevant sections.
  Raw file content, tool output, diffs, test logs, and large trackers stay out of
  both roles' context, beyond what a unit's acceptance requires of the Lead,
  unless a narrowly scoped governance ruling requires direct evidence.
- Neither role performs raw extraction - log greps, diff dumps, test output,
  file surveys - even when a single command appears cheaper than a dispatch: one
  command can load more than the entire dispatch it replaced. Triage that
  requires reading output is delegated, and the curated result consumed. Host
  reconciliation is the Lead's only direct-extraction right.
- Leads return through chat a concise evidence map, acceptance status,
  governance conflicts, material risks, and decisions needed. Briefs and reports
  link to evidence rather than reproducing it, and do not repeat policy already
  supplied by the active skills.
- Delegating investigation or evidence gathering never delegates product or
  governance authority. The Orchestrator retains those rulings and may inspect a
  narrowly cited governance section before making a consequential one.
- Before each new work package - including after a cancellation, retry, or
  failed unit - reassess remaining context, evidence scope, and cross-change
  dependencies, and compress the replacement brief.

## Delegate to Workers

Every Worker brief contains one bounded objective, required inputs and
constraints, allowed scope, expected evidence, output and checkpoint location,
explicit authorization for any destructive action it may require, and a
stop-on-surprise instruction. Before dispatch, the Lead reconciles the brief
against objective, scope, acceptance criteria, constraints, dependencies, and
stop conditions; a conflicting brief is not dispatched. Dispatch packets stay
compact: they link evidence and never replay policy or raw transcripts.

The Lead inspects the actual diff, files, and evidence, never a summary, and
does not revert a suspicious result before inspecting it - the diff decides. A
`review-ready` report is a review input, not acceptance or completion: the Lead
accepts, or returns exactly one same-scope correction round, permitted only with
unchanged semantic scope and context; changed scope requires a fresh Worker
after approval. `handover` is the only terminal status.

## Verify and Review

Map every acceptance criterion to reproducible evidence in `plan.md`. The
Orchestrator checks alignment and the evidence map without repeating code review
or tests. Dispatch one independent review only when a bounded trigger applies.

## Complete

A commit or push requires every unit it contains to be `accepted` with no open
blocker, acceptance gap, or unresolved serious review finding. Fix-forward
covers defects discovered after an honest acceptance, never known defects
carried past a commit.

Completion is one Lead-owned transaction: acceptance-evidence map and
residual-risk summary, Orchestrator alignment approval, user result approval
unless autonomous, then the Lead promotes lasting documentation, removes
transient artifacts, archives the change, removes its backlog entry, and
verifies links and repository status.

## Load References by Condition

- `references/governance.md` - before creating or editing `spec.md` or
  `plan.md`, or when an approval, principles, decisions, or escalation question
  arises
- `references/scheduling.md` - when deciding whether to delegate, dispatching a
  Worker, handling a returned status, or preparing a handover
- `references/verification.md` - when mapping evidence, inspecting Worker
  results, or deciding whether a review trigger applies
- `references/artifacts.md` - when routing, upgrading, creating or editing
  change artifacts, or running the completion transaction

## Shared Engineering Standard

Optimize for correctness, quality, simplicity, readability, and
maintainability. Follow upstream best practices and project conventions; prefer
existing platform capabilities over bespoke code. No hacks, shortcuts,
speculative abstractions, or unrelated refactors. Treat surprising complexity,
fragile code, and maintenance hazards as risks: report impact and proportionate
remediation. Verify claims with current evidence; never conceal uncertainty or
infer success from intent. Spend effort in proportion to risk and choose the
smallest correct solution that preserves approved intent and active decisions.
