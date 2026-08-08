# Scheduling Reference

## Serial Delegation

Exactly one subagent may be active at a time across the whole hierarchy. This
rule overrides any generic recommendation to parallelize independent work, and
no mode, including autonomous mode, overrides it. Parallel Leads or Workers are
deferred to a later release.

Work units carry stable semantic IDs (for example `unit-01`) used consistently
across the plan, log, and state. Execution slices pair a stable unit with an
ephemeral attempt ID (`unit-01/attempt-02`); attempts never rename the semantic
unit, and a new attempt does not amend the plan unless semantic scope,
acceptance, dependencies, or governance change. Only the Lead mutates plans and
state, preserving a clean upgrade path to future worktree-backed concurrency.

## Context Limits

Every Orchestrator, Lead, and Worker has an effective configured context
budget, default `150000`. `150000` is a documented budget, not a quantity any
role can measure about itself: no role can observe its own token usage
mid-session, which is why self-policing it directly does not work. Prefer
exact host token telemetry wherever a host exposes it. Otherwise, return on a
countable proxy from the role's own history, which needs no shell access and
no telemetry: completed work units, dispatches made, and its own tool calls.

These thresholds are provisional, derived from one session's measurements, and
are due for revalidation over the next 2-3 sessions:

- Worker: return after about 30 of its own tool calls.
- Lead: return after 3 completed work units, or about 50 of its own tool
  calls, whichever comes first.
- Orchestrator: hand over after about 20 dispatches.

Reaching a threshold is the normal end of a bounded stint, not an emergency: it
hands a fresh, focused successor the next unit of work. The role must:

1. stop accepting work;
2. return through the boundary's channel: a curated chat report when a live
   parent exists, or `handover.md` at a top-level session transfer or a
   boundary without a live parent.

No role continues past its threshold. Reaching it means returning the report
and stopping; the chat return is a terminal handover even when reported as
`blocked`, and the outgoing role does not resume. It never means scheduling
more tasks to make use of remaining budget instead of returning.

A cancellation, retry, or failed unit triggers this same reassessment against
these thresholds. The replacement brief is compressed to the unresolved
objective, relevant constraints, current evidence pointers, and the specific
reason the prior unit stopped; it does not replay policy or raw transcripts.

## Delegation Decision

Decide delegation for a unit before loading any of its material. The test is
specifiability: a unit is delegated unless the Lead can already state, in the
brief itself, what changes and what the result must be. If stating the work
requires loading the material first, the Worker owns it. This binds read-only
and investigation units the same as change units: if the Lead cannot already
state the specific facts a scan will return, the scan itself is delegated.

Delegate whenever any of these holds at scoping time:

- the work to be done must be discovered rather than stated;
- producing the change requires loading material the Lead does not already
  hold, or material whose extent it cannot bound in advance;
- the unit contains an iterate-until-green loop such as build, test, lint, or
  format, whose output volume is not known before running it;
- its acceptance is checkable from the returned diff plus a command result.

This covers code and file changes, test and command runs, documentation
writing, documentation search and summarisation, and web research alike.

The Lead executes a unit directly only when all of these hold: it can already
state the work completely; the work is judgement, reconciliation, approval, or
dispatch rather than change; and it can be applied and verified without loading
further material. Cost is context volume, not the number of reads or commands:
one read of a large document or one command with unbounded output can exceed
many small ones. Judge the material, not the call count. When roles run
different model tiers, a Lead's byte typically costs more than a Worker's;
that asymmetry is a further reason to delegate, not just context volume.

## Corpus Ownership and Forfeit

Every unit names exactly one role that holds its material, and that role
acquires it once. When the Worker holds it, the Lead scopes from paths, greps,
specifications, and prior reports, then reviews the returned diff and evidence
rather than re-reading the files. When the Lead holds it, the brief must be
complete enough that the Worker never reopens the same material: it names the
specific facts, IDs, and prior findings already established in-session so the
Worker does not rediscover them.

A Lead that has already loaded a unit's material has forfeited that unit's
dispatch: it finishes the unit itself and records the forfeit. Mid-unit
delegation after the loading is done duplicates cost without recovering it.
See Late Size Discovery below for the self-discovery exception.

## Late Size Discovery

Some material cannot be sized in advance. When a read or a command's output is
rejected, truncated, or paginated by the host because of its size, that material
is unbounded in practice and its loading and processing are delegated. A role
that checks a file's size or line count before reading it and finds it large is
bound by the same rule as a host-triggered rejection: the check does not pay the
loading cost, and delegating afterward is never a forfeit. Do not page through
it, re-run the command with narrower filters, or sample it repeatedly: each
attempt pays again for the same discovery and, in aggregate, costs more than the
single dispatch it was avoiding. Dispatch a Worker whose objective is to load
the material, process it, and return the curated result.

This reactive trigger is permitted because the rejection leaves the cost unpaid:
the content is still outside the role's context. It is the opposite of
dispatching after the material is already loaded, which recovers nothing and is
a forfeit. The governing distinction is whether the triggering event leaves the
cost unpaid.

Partially loaded material follows the same rule for its remainder: what is
loaded stays, and the rest is delegated rather than paged in.

A Worker that hits this trigger does not dispatch itself: Workers never
delegate. It stops and reports the rejected or truncated material as a
`blocked` or `decision-needed` pause report, and the Lead dispatches the
Worker that loads and curates it.

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
- `docs/principles.md` when present, plus only the bounded inputs needed for
  the objective;
- required inputs and relevant constraints;
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
`decision-needed`, or `host-unknown`. `review-ready` is a review input, not
acceptance or completion, and the Lead inspects the diff and evidence before
accepting. Workers never delegate: no subagent or task invocation. Workers do
not independently read `docs/backlog.md`, unrelated plans, or the wider project
context. They read `docs/backlog.md` only when their assigned work involves
prioritization, selecting or ordering work, cross-change coordination, or
otherwise needs current priorities.

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
| `blocked` | any role | Pause report, not a handover | resume the same unfinished unit after the concrete condition resolves |
| `decision-needed` | any role | Pause report, not a handover; a specific answer is required | resume the same unfinished unit after the Lead or user answers |
| `host-unknown` | Worker | Root or host cannot be verified; an unsuccessful, counted, non-resumable host attempt | `host-unknown reconciliation` |
| `host-unknown reconciliation` | Lead | Lead reconciles diff, Git, log, and evidence after a failed host attempt | `accepted`, a fresh compressed recovery Worker, or abandon |
| `accepted` | Lead | Lead inspected the diff and evidence and accepted the unit | next unit, or terminal accepted completion |
| `rejected` | Lead | Lead inspected and returned the unit | one same-scope correction round, or a fresh Worker after approval |
| `terminal-handover` | any role | Chat or `handover.md` handover; ends the outgoing role | a fresh subagent |

Terminal handovers and terminal accepted completion remain preserved.

## Terminal Reports, Handovers, and Resumption

- `review-ready` is not terminal: it returns the unit to the Lead for
  inspection and acceptance. The same Worker may receive exactly one same-scope
  correction round, and only after Lead inspection with semantic scope and
  context unchanged; changed scope requires a fresh Worker after approval.
  Every actual handover is terminal and ends the outgoing Worker or role: a
  curated chat handover, or a `handover.md` transfer at a top-level session
  transfer or a boundary without a live parent. Fresh subagents are required
  after handover, changed scope, corrections, or further work.
- `host-unknown`, missing, malformed, and cancelled results are unsuccessful,
  counted, non-resumable host attempts, never evidence. The Lead runs
  `host-unknown reconciliation`; these results never count as evidence.
- An ordinary `blocked` or `decision-needed` return is a pause report, not a
  handover: it does not end the Worker. The same Worker may resume only its
  same unfinished unit, and only after the Lead answers a specific
  `decision-needed` report or resolves its concrete `blocked` condition, and
  only while the Worker remains within its context budget.
- A `checkpoint` return is a pause report, not a handover: it does not end the
  Worker. Resume the same unit only after the Lead returns `continue` or one
  same-scope correction for that checkpoint. The correction budget is per
  checkpoint, not per unit.
- A context-ceiling return is a terminal chat handover even if its status is
  `blocked`: the outgoing Worker or role stops for succession and does not
  resume, and a fresh subagent takes over. It is not an ordinary resumable
  `blocked` report.
- Worker-to-Lead and Lead-to-Orchestrator reports and actual handovers return
  through chat, curated and comprehensive, without exhaustive transcripts or
  persisted report files.

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
  `handover.md`; the transfer is terminal and ends the outgoing agent. Role
  handovers with a live parent return curated reports through chat; those
  reports are terminal and end the outgoing role.
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
6. Lead inspects diff and evidence and proposes progress updates and any
   correction; Orchestrator signs off before the Lead edits either file.
7. Lead returns a completion packet mapping acceptance criteria to evidence.
8. Orchestrator checks project alignment and evidence without repeating code
   review or tests.
9. User approves the result unless autonomous mode was requested.
10. The Lead performs the completion transaction.

Failed gates return concrete findings to the responsible role; they do not
restart the lifecycle.
