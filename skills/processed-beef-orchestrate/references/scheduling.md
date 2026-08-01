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
2. write `handover.md`;
3. return.

No role continues past its configured limit. Approaching it means writing the
handover and stopping; it never means scheduling more tasks to make use of the
remaining budget.

## Worker Brief

Every dispatch includes:

- one bounded objective;
- required inputs and relevant constraints;
- allowed scope;
- expected evidence;
- output and checkpoint location;
- an instruction to stop on surprises or decisions not covered by the brief.

Workers execute, verify every completion claim, checkpoint the log when one
exists, and return one of `complete`, `blocked`, or `decision-needed`.

## Lead Inspection

The Lead never accepts a Worker report on trust. It inspects the actual diff,
files, and evidence. A suspicious Worker result is inspected before any
decision: do not revert, rewrite, or discard it until the real changes are read
and the evidence checked. The diff decides what happened; the report only
points at it.

## Recovery

- Treat `log.md` and Git as recovery truth after abrupt quota or session loss.
- End verified coherent units in atomic commits when repository policy permits.
- A replacement agent reconciles the plan, log, Git status and history, and
  verification evidence before making changes.
- Deliberate context transfer uses `handover.md` and stops the outgoing agent.
- A failed Worker returns control instead of improvising.
- Two unsuccessful attempts on one work unit force Orchestrator reassessment,
  narrowing, splitting, or a changed approach.
- A successor receives only its role skill, current brief, relevant project
  guidance, applicable spec and decision clauses, the necessary plan or state
  slice, and the latest handover. It does not ingest full session history.

## Standard Dispatch Sequence

1. Orchestrator dispatches one Lead to survey only enough code and evidence to
   propose a spec and plan without writing them.
2. Lead uses serial Workers for focused investigation only when direct reads
   are insufficient.
3. Lead returns proposed documents; Orchestrator reviews alignment, ambiguity,
   scope, and verification.
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
