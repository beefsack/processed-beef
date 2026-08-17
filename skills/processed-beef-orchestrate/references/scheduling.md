# Scheduling Reference

## Serial Delegation

Exactly one subagent may be active at a time across the whole hierarchy. This
rule overrides any generic recommendation to parallelize independent work, and
no mode, including autonomous mode, overrides it. Parallel Leads or Workers are
deferred to a later release.

The process targets subscription quotas rather than large API spends, so this
is a quota control first: concurrent agents burn quota in parallel, hit the
ceiling without warning, and lose several agents' in-flight work at once.
Serial execution makes consumption observable and stops at a unit boundary that
`log.md` and Git can recover. The latency cost is accepted deliberately and is
not an inefficiency to optimise away.

Work units carry stable semantic IDs (for example `unit-01`) used consistently
across the plan, log, and state. Execution slices pair a stable unit with an
ephemeral attempt ID (`unit-01/attempt-02`); attempts never rename the semantic
unit, and a new attempt does not amend the plan unless semantic scope,
acceptance, dependencies, or governance change. Only the Lead mutates plans and
state, preserving a clean upgrade path to future worktree-backed concurrency.

## Context Limits

Each role has a configured context budget, default `150000`. That number is a
host configuration value: no role can observe its own token usage mid-session,
so it governs nothing on its own. What governs behavior is exact host token
telemetry where a host exposes it, and otherwise the countable proxies below,
taken from the role's own history and needing no shell access or telemetry.

These thresholds are provisional, derived from session measurements, and are
due for revalidation over the next 2-3 sessions:

- Worker: target completion in about 12-16 of its own tool calls, leaving
  handover reserve, and return by about 20.
- Lead: return after 3 completed work units, or about 20 of its own tool
  calls, whichever comes first.
- Orchestrator: no fixed dispatch cap. It hands over deliberately, on host
  context telemetry where available, otherwise on dispatch volume and the state
  of the work, choosing a boundary where a compact successor packet is cheap.

A threshold is a scheduling boundary, not an evidence-validity boundary. When
an attempt exceeds one but returns usable work, the Lead reconciles it once -
inspect the diff and evidence, then accept, correct, or abandon - rather than
discarding it and redispatching the same scope. Repeated rejection of
technically useful over-threshold work causes redispatch churn and pushes
implementation back onto the Lead, which is worse than the breach. Report
process compliance separately from technical acceptance: a reconciled diff can
be technically sound while the attempt remains process-noncompliant.

Reaching a threshold is the normal end of a bounded stint, not an emergency: it
hands a fresh, focused successor the next unit of work. The role stops
accepting work and reports `handover` - through chat when a live parent exists,
or as `handover.md` at a top-level session transfer or a boundary without a
live parent. No role continues past its threshold, and it never schedules more
tasks to use up remaining budget instead of returning.

A cancellation, retry, or failed unit triggers this same reassessment against
these thresholds. The replacement brief is compressed to the unresolved
objective, relevant constraints, current evidence pointers, and the specific
reason the prior unit stopped; it does not replay policy or raw transcripts.

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
delegating afterward is never a forfeit. Dispatch a Worker to load, process,
and curate it. Do not page through it, re-run it with narrower filters, or
sample it repeatedly: each attempt pays again for the same discovery and, in
aggregate, exceeds the single dispatch it was avoiding. Partially loaded
material follows the same rule for its remainder. A Worker that hits this
returns `blocked` or `decision-needed`; it never delegates.

## Pre-Dispatch Reconciliation

Before every dispatch, the Lead reconciles the brief against the objective,
allowed scope, acceptance criteria, constraints, dependencies, and stop
conditions. A brief that conflicts with any of them is not dispatched; it
returns to the Lead. Dispatch packets stay compact: they state the unresolved
objective, relevant constraints, current evidence pointers, and the
stop-on-surprise instruction, without replaying policy or raw transcripts.

## Worker Brief

Every dispatch includes:

- one bounded objective;
- only the bounded inputs needed for the objective;
- required inputs and relevant constraints, including the applicable
  `docs/principles.md` clauses stated in the brief rather than left to a
  per-dispatch read;
- allowed scope;
- expected evidence;
- output and checkpoint location;
- explicit authorization for any destructive action the unit may require,
  naming exactly what may be deleted, moved, truncated, or overwritten;
- review points, if any, each stating the group that completes it and the
  evidence expected at it;
- an instruction to stop on surprises or decisions not covered by the brief.

A brief may specify tool constraints only when they are intrinsic to the project
or objective. It never forwards or restates the parent role's model-specific or
host-specific tool-use restrictions or capability assumptions: each child
follows its own active instructions and available tools, and an inherited
parent-only restriction can make a child non-functional.

Workers execute, verify every completion claim, checkpoint the log when one
exists, and return one of `review-ready`, `checkpoint`, `blocked`,
`decision-needed`, `host-unknown`, or `handover`. `review-ready` is a review
input, not acceptance or completion, and the Lead inspects the diff and
evidence before accepting. Workers never delegate: no subagent or task
invocation. Workers do not independently read `docs/principles.md`,
`docs/backlog.md`, unrelated plans, or the wider project context: the brief
carries the clauses and inputs the unit needs. A Worker reads `docs/backlog.md`
or `docs/principles.md` directly only when its assigned work involves
prioritization, ordering work, cross-change coordination, or a governance
question the brief did not resolve.

## Destructive Actions

A role performs a destructive action - deleting, moving, truncating, or
overwriting a file or resource - only where its brief explicitly authorizes it.
An unauthorized destructive action is a stop-and-report, identical to any other
out-of-scope surprise: it is never taken because it seems necessary or
convenient. This applies at every level: Orchestrator-to-Lead and Lead-to-Worker
briefs alike.

Destruction of tracked files is recoverable from Git, so brief authorization is
sufficient on its own. Irreversible destruction outside version control -
deleting or overwriting untracked data, acting on a production system, or
discarding external state Git cannot restore - escalates rather than
proceeding on brief authorization alone: the Lead escalates to the
Orchestrator, and the Orchestrator decides, involving the user when the data is
the user's.

## Review Points

Review points are named in the brief before dispatch, and only where an error
would be expensive to unwind - a schema or interface change other edits build
on, a mechanical sweep whose pattern must be right before it is repeated, or a
group whose verification cost rises sharply if defects accumulate. A unit with
no named review point returns once, at completion.

At a checkpoint the Lead inspects the incremental diff since the previous
checkpoint, not the unit's whole material and not the files themselves. It
returns `continue` or exactly one same-scope correction for that checkpoint. The
correction budget is per checkpoint, not per unit.

## Lifecycle Statuses and Transitions

Every report and handover starts with `Status` as its first field, then
objective, changed files, evidence per claim, risks, and blockers or decisions
needed. Lifecycle statuses transition as follows:

| Status | Produced by | Meaning | Next |
|---|---|---|---|
| `review-ready` | Worker | Unit done with evidence; a review input, not acceptance or completion | `accepted` or `rejected`, decided only by Lead inspection |
| `checkpoint` | Worker | A named review point is reached: a coherent group of edits is complete and verified, and scoped work remains | `continue` or one same-scope correction for that checkpoint, decided only by Lead inspection |
| `continue` | Lead | Lead inspected the incremental diff at a checkpoint and accepts it | Worker resumes the same unit toward the next review point or completion |
| `blocked` | any role | Pause report; a concrete external condition stops progress | resume the same unfinished unit after the condition resolves |
| `decision-needed` | any role | Pause report; a specific answer is required | resume the same unfinished unit after the Lead or user answers |
| `host-unknown` | Worker | Root or host cannot be verified; an unsuccessful, counted, non-resumable host attempt | `host-unknown reconciliation` |
| `host-unknown reconciliation` | Lead | Lead reconciles diff, Git, log, and evidence after a failed host attempt | `accepted`, a fresh compressed recovery Worker, or abandon |
| `accepted` | Lead | Lead inspected the diff and evidence and accepted the unit | next unit, or terminal accepted completion |
| `rejected` | Lead | Lead inspected and returned the unit | one same-scope correction round, or a fresh Worker after approval |
| `handover` | any role | The role's stint is over: threshold reached, or a transfer. Always terminal | a fresh subagent |

## Terminal Reports, Handovers, and Resumption

Statuses divide cleanly. `handover` is the only terminal one: it ends the
outgoing Worker or role, and a fresh subagent takes over. `review-ready`,
`checkpoint`, `blocked`, and `decision-needed` are pause reports that do not
end the reporting role. `host-unknown` ends the attempt, not by handover.

- A role reaching its return threshold reports `handover`, never `blocked`.
- `handover` returns through chat when a live parent exists; only a top-level
  session transfer or a boundary without a live parent writes `handover.md`.
- `review-ready` returns the unit to the Lead for inspection and acceptance.
  The same Worker may receive exactly one same-scope correction round, and only
  after Lead inspection with semantic scope and context unchanged; changed
  scope requires a fresh Worker after approval.
- `blocked` and `decision-needed` resume the same unfinished unit, and only
  after the Lead answers the specific question or resolves the concrete
  condition, and only while the Worker remains within its context budget.
- A `checkpoint` resumes the same unit after the Lead returns `continue` or one
  same-scope correction. The correction budget is per checkpoint, not per unit.
- `host-unknown`, missing, malformed, and cancelled results are unsuccessful,
  counted, non-resumable host attempts, never evidence. The Lead runs
  `host-unknown reconciliation`.
- A fresh subagent is required after a handover, changed scope, a correction,
  or further work.
- All reports and handovers return through chat, curated and comprehensive,
  without exhaustive transcripts or persisted report files.

## Attempt Accounting

Attempts, correction rounds, and independent reviews are counted against the
stable semantic unit, never against the agent working it. The count survives
Worker replacement, Lead succession, correction rounds, context handovers, and
malformed, missing, or cancelled reports, and a relabeled brief for the same
objective does not start a new count. The Lead records a unit's counts in
`plan.md` once one of them exceeds 1, so a successor inherits them instead of
resetting them; a unit that completed first try needs no entry, and a successor
Lead reads the table before its first dispatch on a listed unit.

These counts drive the circuit breakers in the orchestrate skill: a third
attempt on a unit, a second correction round on a unit or checkpoint, or a
second independent review of the same unit trips a breaker rather than
proceeding. A tripped breaker stops implementation on that unit and escalates
one tier with a loop report; the next step is a reset that changes kind -
reduced or split scope, changed approach, frozen partial acceptance, or a
parked unit - not another attempt.

## Lead Inspection

The Lead never accepts a Worker report on trust. It inspects the actual diff,
files, and evidence. A suspicious Worker result is inspected before any
decision: do not revert, rewrite, or discard it until the real changes are read
and the evidence checked. The diff decides what happened; the report only
points at it.

Before implementation or review, the Lead reads the specification, plan, and
governing clauses it must hold to scope, decide, and accept. Implementation
evidence is reviewed as diffs and curated reports, not by reloading the
material that produced them. It reads `docs/backlog.md` only when its assigned
work involves prioritization, selecting or ordering work, cross-change
coordination, or otherwise needs current priorities. It returns the
Orchestrator a concise evidence map, acceptance status, governance conflicts,
material risks, and decisions needed. The Orchestrator does not receive raw
implementation material by default.

## Recovery

- Treat `log.md` and Git as recovery truth after abrupt quota or session loss.
- Missing, malformed, cancelled, and `host-unknown` results are unsuccessful,
  counted attempts and terminal, non-resumable host attempts. The Lead runs
  `host-unknown reconciliation`: reconcile the diff, Git status and history,
  log, and verification evidence, then accept usable work, dispatch a fresh
  compressed recovery Worker, or abandon the attempt.
- A unit is never fragmented into a separate commit-only Worker. The Lead
  decides commit composition and performs the commit itself; the mechanical
  staging within a unit - hunk selection, patch construction, application,
  verification of what was staged - is ordinary delegable work, delegated under
  the same test as any other work.
- A replacement agent reconciles the plan, log, Git status and history, and
  verification evidence before making changes.
- A deliberate top-level session transfer without a live parent uses
  `handover.md`; with a live parent, a `handover` returns through chat. Either
  way it is terminal and ends the outgoing agent.
- A failed Worker returns control instead of improvising.
- A Lead that judges a unit too large and cleanly separable before starting
  proposes a pre-start split to the Orchestrator instead of starting it. Two
  unsuccessful attempts on a started unit force the same Orchestrator
  reassessment: narrowing, splitting, or a changed approach.
- A successor receives only its role skill, current brief, relevant project
  guidance, applicable spec and decision clauses, the necessary plan or state
  slice, and the latest curated report or handover as applicable. It does not
  ingest full session history.

## Standard Dispatch Sequence

1. Orchestrator dispatches one Lead to survey only enough code and evidence to
   propose a spec and plan without writing them. The Lead, not the
   Orchestrator, ensures relevant active-change material is read before
   implementation.
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
