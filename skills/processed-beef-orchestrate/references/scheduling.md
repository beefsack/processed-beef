# Scheduling Reference

## Serial Delegation

Serial execution is a quota control first: the process targets subscription
quotas rather than large API spends, and concurrent agents burn quota in
parallel, hit the ceiling without warning, and lose several agents' in-flight
work at once. One agent at a time makes consumption observable and stops at a
unit boundary that `log.md` and Git can recover. The latency cost is accepted
deliberately and is not an inefficiency to optimise away. The rule overrides any
generic recommendation to parallelize independent work. Parallel Leads or
Workers are deferred to a later release.

A new attempt on a unit does not amend the plan unless semantic scope,
acceptance, dependencies, or governance change. Only the Lead mutates plans and
state, preserving a clean upgrade path to future worktree-backed concurrency.

## Context Limits

The return thresholds are in the orchestrate skill. They are provisional,
derived from session measurements, and due for revalidation over the next 2-3
sessions.

When an attempt exceeds a threshold but returns usable work, the Lead reconciles
it once - inspect the diff and evidence, then accept, correct, or abandon -
rather than discarding it and redispatching the same scope. Repeated rejection
of technically useful over-threshold work causes redispatch churn and pushes
implementation back onto the Lead, which is worse than the breach. Report
process compliance separately from technical acceptance: a reconciled diff can
be technically sound while the attempt remains process-noncompliant.

A cancellation, retry, or failed unit triggers the same reassessment as a
threshold. The replacement brief is compressed to the unresolved objective,
relevant constraints, current evidence pointers, and the specific reason the
prior unit stopped; it does not replay policy or raw transcripts.

## Delegation Decision

Decide delegation before loading any of the unit's material. The test is
specifiability: a unit is delegated unless the Lead can already state, in the
brief itself, what changes and what the result must be. Read-only and
investigation units bind the same as change units - if the Lead cannot already
state the facts a scan will return, the scan is delegated - and so do
iterate-until-green loops such as build, test, lint, and format, whose output
volume is unknown before running. This covers code and file changes, command
runs, documentation writing and search, and web research alike.

The Lead executes a unit directly only when it can already state the work
completely, the work is judgement, reconciliation, approval, or dispatch rather
than change, and it can be applied and verified without loading further
material. Cost is context volume, not call count: one read of a large document
can exceed many small ones. Under mixed model tiers a Lead's byte costs more
than a Worker's, which is a further reason to delegate.

## Corpus Ownership and Forfeit

Every unit names one role that holds its material, and that role acquires it
once. When the Worker holds it, the Lead scopes from paths, greps,
specifications, and prior reports, then reviews the returned diff rather than
re-reading the files. When the Lead holds it, the brief names the facts, IDs,
and prior findings already established in-session so the Worker does not
rediscover them. A Lead that has already loaded a unit's material has forfeited
that unit's dispatch: it finishes the unit itself and records the forfeit,
because delegating after the loading is done duplicates cost without recovering
it.

The exception is material that could not be sized in advance. When the host
rejects, truncates, or paginates a read or command output because of its size -
or a size check before reading shows the same - the cost is still unpaid, so
delegating afterward is never a forfeit. Dispatch a Worker to load, process, and
curate it. Do not page through it, re-run it with narrower filters, or sample it
repeatedly: each attempt pays again for the same discovery and, in aggregate,
exceeds the single dispatch it was avoiding. Partially loaded material follows
the same rule for its remainder. A Worker that hits this returns `blocked` or
`decision-needed`; it never delegates.

## Worker Brief

Every dispatch includes:

- one bounded objective;
- only the bounded inputs needed for the objective;
- required inputs and relevant constraints, including the applicable
  `docs/principles.md` clauses stated in the brief rather than left to a
  per-dispatch read;
- allowed scope;
- expected evidence;
- for every implementation brief, plan-owned gate IDs, literal canonical
  commands, and expected baselines;
- output and checkpoint location;
- explicit authorization for any destructive action the unit may require, naming
  exactly what may be deleted, moved, truncated, or overwritten;
- review points, if any, each stating the group that completes it and the
  evidence expected at it;
- an instruction to stop on surprises or decisions not covered by the brief.

Before the first implementation dispatch, the parent records a capability
preflight: `process_role`, `parent_process_role`, parent-recorded
`agent_selector`, optional model preference, distinct host persona, available
tools, host depth, and required child-skill availability. Only the two process
role fields block role validity; a child cannot claim selector or model
application. A malformed or missing metadata packet, process-role mismatch,
selector/persona confusion, unavailable child skill, or host/preflight rejection
  returns `dispatch-invalid` before source work. It is not an implementation
  attempt, correction, or review. For implementation briefs, the parent also
  compares every gate ID, literal canonical command, and expected baseline with
  the plan evidence map; a mismatch is `dispatch-invalid` before source work.
  If a Worker accidentally runs a wrong local command, the Lead reruns and
  reconciles the canonical gate locally and does not request a user decision.
  The parent repairs one dispatch once, then escalates the process or host
  failure.

A brief may specify tool constraints only when they are intrinsic to the project
or objective. It never forwards or restates the parent role's model-specific or
host-specific tool-use restrictions or capability assumptions: each child
follows its own active instructions and available tools, and an inherited
parent-only restriction can make a child non-functional.

Workers execute, verify every completion claim, checkpoint the log when one
exists, and return one status. They never delegate: no subagent or task
invocation. They do not independently read `docs/principles.md`,
`docs/backlog.md`, unrelated plans, or the wider project context - the brief
carries the clauses and inputs the unit needs - except when the assigned work
involves prioritization, ordering work, cross-change coordination, or a
governance question the brief did not resolve.

## Destructive Actions

A role performs a destructive action - deleting, moving, truncating, or
overwriting a file or resource - only where its brief explicitly authorizes it.
This applies at every level: Orchestrator-to-Lead and Lead-to-Worker briefs
alike. An unauthorized destructive action is a stop-and-report, identical to any
other out-of-scope surprise: it is never taken because it seems necessary or
convenient.

Destruction of tracked files is recoverable from Git, so brief authorization is
sufficient on its own. Irreversible destruction outside version control -
deleting or overwriting untracked data, acting on a production system, or
discarding external state Git cannot restore - escalates rather than proceeding
on brief authorization alone: the Lead escalates to the Orchestrator, and the
Orchestrator decides, involving the user when the data is the user's.

## Review Points

Review points are named in the brief before dispatch, and only where an error
would be expensive to unwind - a schema or interface change other edits build
on, a mechanical sweep whose pattern must be right before it is repeated, or a
group whose verification cost rises sharply if defects accumulate. A unit with
no named review point returns once, at completion.

At a checkpoint the Lead inspects the incremental diff since the previous
checkpoint, not the unit's whole material and not the files themselves. It
returns `continue` or the unit's remaining pre-review implementation correction.
Checkpoints create no separate correction budget: a second pre-review correction
trips that class's breaker.

## Lifecycle Statuses and Transitions

Every report and handover starts with `Status` as its first field, then
objective, changed files, evidence per claim, risks, and blockers or decisions
needed. All reports and handovers return through chat, curated and
comprehensive, without exhaustive transcripts or persisted report files; only a
top-level session transfer or a boundary without a live parent writes
`handover.md`.

| Status | Produced by | Meaning | Next |
|---|---|---|---|
| `review-ready` | Worker | Unit done with evidence; a review input, not acceptance or completion | `accepted` or `rejected`, decided only by Lead inspection |
| `checkpoint` | Worker | A named review point is reached: a coherent group of edits is complete and verified, and scoped work remains | `continue` or the unit's remaining pre-review implementation correction, decided only by Lead inspection |
| `continue` | Lead | Lead inspected the incremental diff at a checkpoint and accepts it | Worker resumes the same unit toward the next review point or completion |
| `dispatch-invalid` | parent before source work | Parent metadata, process role, child skill, capability, or host/preflight is invalid | Parent repairs one dispatch once, then escalates the process or host failure; no implementation, correction, or review budget is consumed |
| `blocked` | any role | Pause report; a concrete external condition stops progress | the same role resumes the same unfinished unit once the condition resolves, while within its context budget |
| `decision-needed` | any role | Pause report; a specific answer is required | the same role resumes the same unfinished unit once the Lead or user answers, while within its context budget |
| `host-unknown` | Worker | A host failure occurs after a valid dispatch has begun source work; an unsuccessful, counted, non-resumable attempt, never evidence | `host-unknown reconciliation` |
| `host-unknown reconciliation` | Lead | Lead reconciles diff, Git, log, and evidence after a failed host attempt | `accepted`, a fresh compressed recovery Worker, or abandon |
| `accepted` | Lead | Lead inspected the diff and evidence and accepted the unit | next unit, or terminal accepted completion |
| `rejected` | Lead | Lead inspected and returned the unit | one same-scope pre-review implementation correction or one finding-fix correction for a named independent-review finding set, only with semantic scope and context unchanged, or a fresh Worker after approval |
| `handover` | any role | The role's stint is over: threshold reached, or a transfer | a fresh subagent |

`handover` is the only terminal one: it ends the outgoing role, and a fresh
subagent takes over. `review-ready`, `checkpoint`, `blocked`, and
`decision-needed` are pause reports that do not end the reporting role.
`dispatch-invalid` is pre-source and does not end an implementation attempt.
`host-unknown` ends the attempt, not by handover. A role reaching its return
threshold reports `handover`, never `blocked`. Missing, malformed, and cancelled
results after dispatch are equally unsuccessful, counted, non-resumable host
attempts, handled like `host-unknown`. A fresh subagent is required after a
handover, changed scope, a correction, or further work.

## Attempt Accounting

Counts drive the circuit breakers in the orchestrate skill. A relabeled brief
for the same objective does not start a new count. A successor Lead reads the
`plan.md` unit and change-wide ledger before its first dispatch. Track
implementation dispatches, `dispatch-invalid` results, pre-review corrections,
finding-fix corrections, independent reviews, changed-kind resets, broad-gate
runs, Worker and Lead tool-call proxies, acceptance criteria moved, and the
no-progress streak. The streak increments after an implementation dispatch
moves zero criteria and resets when one moves; three such dispatches without
movement parks and escalates the change. A second changed-kind reset also parks
and escalates.

## Recovery

- Treat `log.md` and Git as recovery truth after abrupt quota or session loss.
- A replacement agent reconciles the plan, log, Git status and history, and
  verification evidence before making changes. A successor receives only its
  role skill, current brief, relevant project guidance, applicable spec and
  decision clauses, the necessary plan or state slice, and the latest curated
  report or handover as applicable. It does not ingest full session history.
- A unit is never fragmented into a separate commit-only Worker. The Lead
  decides commit composition and performs the commit itself; the mechanical
  staging within a unit - hunk selection, patch construction, application,
  verification of what was staged - is ordinary delegable work, delegated under
  the same test as any other work.
- A failed Worker returns control instead of improvising.
- A Lead that judges a unit too large and cleanly separable before starting
  proposes a pre-start split to the Orchestrator instead of starting it. Two
  unsuccessful attempts on a started unit force the same Orchestrator
  reassessment: narrowing, splitting, or a changed approach.

## Standard Dispatch Sequence

1. Orchestrator dispatches one Lead to survey only enough code and evidence to
   propose a spec and plan without writing them. The Lead, not the Orchestrator,
   ensures relevant active-change material is read before implementation.
2. Lead delegates investigation whose findings require loading material, and
   loads directly only what it must hold in order to decide, approve, or
   reconcile.
3. Lead returns a concise proposal summary, approval-relevant sections, and
   acceptance and verification map; Orchestrator reviews alignment, ambiguity,
   scope, and verification without loading complete proposed documents by
   default.
4. User approves the specification unless autonomous mode waived the gate;
   Orchestrator approves both initial files and delegates their creation to the
   Lead.
5. Lead dispatches one Worker per bounded plan unit, serially.
6. Lead inspects diff and evidence, records progress and evidence directly, and
   proposes any semantic plan or spec change for Orchestrator sign-off.
7. Lead returns a completion packet mapping acceptance criteria to evidence.
8. Orchestrator checks project alignment and evidence without repeating code
   review or tests.
9. User approves the result unless autonomous mode was requested.
10. The Lead performs the completion transaction.

Failed gates return concrete findings to the responsible role; they do not
restart the lifecycle.
