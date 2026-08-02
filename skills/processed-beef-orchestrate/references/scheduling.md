# Scheduling Reference

## Serial Delegation

Exactly one subagent may be active at a time across the whole hierarchy. This
rule overrides any generic recommendation to parallelize independent work, and
no mode, including autonomous mode, overrides it. Parallel Leads or Workers are
deferred to a later release.

Work units carry stable IDs (for example `unit-01`) used consistently across
the plan, log, and state. Only the Lead mutates plans and state, preserving a
clean upgrade path to future worktree-backed concurrency.

## Context Limits

Every Orchestrator, Lead, and Worker uses its effective configured context limit,
default `150000`, process-enforced because hosts do not consistently provide
per-agent ceilings. Near 85% of that limit, or whenever the next unit may exceed
the remaining budget, the role must:

1. stop accepting work;
2. return through the boundary's channel: a curated chat report when a live
   parent exists, or `handover.md` at a top-level session transfer or a
   boundary without a live parent.

No role continues past its configured limit. Approaching it means returning the
report and stopping; the chat return is a terminal handover even when reported
as `blocked`, and the outgoing role does not resume. It never means scheduling
more tasks to make use of the remaining budget.

Before starting each new work package, the responsible role checks remaining
context against the package's expected evidence and report. It stops scheduling
new packages before the ceiling when that work may not fit, rather than using
the remaining budget opportunistically. Without exact host token telemetry, use
`wc -c` or equivalent before each raw read to maintain a cumulative count of
raw bytes loaded into the role from source, diffs, reviews, trackers, and test
logs. Count one byte as one token and return before a read or package reaches
85% of the effective limit (`127500` bytes by default).

A cancellation, retry, or failed unit triggers this same context reassessment.
The replacement brief is compressed to the unresolved objective, relevant
constraints, current evidence pointers, and the specific reason the prior unit
stopped; it does not replay policy or raw transcripts.

## Worker Brief

Every dispatch includes:

- one bounded objective;
- `docs/principles.md` when present, plus only the bounded inputs needed for
  the objective;
- required inputs and relevant constraints;
- allowed scope;
- expected evidence;
- output and checkpoint location;
- an instruction to stop on surprises or decisions not covered by the brief.

Workers execute, verify every completion claim, checkpoint the log when one
exists, and return one of `complete`, `blocked`, or `decision-needed`.
Workers do not independently read `docs/backlog.md`, unrelated plans, or the
wider project context. They read `docs/backlog.md` only when their assigned work
involves prioritization, selecting or ordering work, cross-change coordination,
or otherwise needs current priorities.

## Terminal Reports, Handovers, and Resumption

- `complete` is terminal and ends that Worker. Every actual handover is also
  terminal and ends the outgoing Worker or role: a curated chat handover, or a
  `handover.md` transfer at a top-level session transfer or a boundary without
  a live parent. Fresh subagents are required after completion, handover,
  changed scope, corrections, or further work.
- An ordinary `blocked` or `decision-needed` return is a pause report, not a
  handover: it does not end the Worker. The same Worker may resume only its
  same unfinished unit, and only after the Lead answers a specific
  `decision-needed` report or resolves its concrete `blocked` condition, and
  only while the Worker remains within its context budget.
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

Before implementation or review, the Lead deeply reads the active change's
relevant specification and plan, governing clauses, implementation evidence,
and Worker results enough to accept or reject work. It reads `docs/backlog.md`
only when its assigned work involves prioritization, selecting or ordering work,
cross-change coordination, or otherwise needs current priorities. It returns
the Orchestrator a concise evidence map, acceptance status, governance
conflicts, material risks, and decisions needed. The Orchestrator does not
receive raw implementation material by default.

## Recovery

- Treat `log.md` and Git as recovery truth after abrupt quota or session loss.
- End verified coherent units in atomic commits when repository policy permits.
- A replacement agent reconciles the plan, log, Git status and history, and
  verification evidence before making changes.
- A deliberate top-level session transfer without a live parent uses
  `handover.md`; the transfer is terminal and ends the outgoing agent. Role
  handovers with a live parent return curated reports through chat; those
  reports are terminal and end the outgoing role.
- A failed Worker returns control instead of improvising.
- Two unsuccessful attempts on one work unit force Orchestrator reassessment,
  narrowing, splitting, or a changed approach.
- A successor receives only its role skill, current brief, relevant project
  guidance, applicable spec and decision clauses, the necessary plan or state
  slice, and the latest curated report or handover as applicable. It does not
  ingest full session history.

## Standard Dispatch Sequence

1. Orchestrator dispatches one Lead to survey only enough code and evidence to
   propose a spec and plan without writing them. The Lead, not the
   Orchestrator, ensures relevant active-change material is read before
   implementation.
2. Lead uses serial Workers for focused investigation only when direct reads
   are insufficient.
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
10. A Worker performs the completion transaction.

Failed gates return concrete findings to the responsible role; they do not
restart the lifecycle.
