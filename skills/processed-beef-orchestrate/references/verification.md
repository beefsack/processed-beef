# Verification Reference

## Evidence Standard

Every acceptance criterion maps to reproducible evidence in `plan.md`. Evidence
may be a focused test, check, inspection, screenshot, log, or other current
observation appropriate to the behavior.

- Bug work begins with a reproduced failure or other falsifiable evidence, and
  gets a regression-first test when a practical test boundary exists.
- New behavior receives targeted tests appropriate to repository conventions and
  risk; mechanical changes use proportionate checks rather than ceremonial tests.
- Leads inspect actual changes and evidence; Orchestrators inspect alignment and
  the evidence map, not the implementation again.

Each verification command in `plan.md` is typed static or live. Live means it
mutates the host, external state, or a running system; the classification comes
from what the command does, not from its name. Static commands run under
ordinary test authorization and are never skipped because their name resembles a
live one. Live commands name prerequisites, approval, cleanup, and the evidence
to capture before the first run.

## Worker Results

Worker output is never accepted without Lead inspection. The Lead inspects the
actual diff and files rather than the summary, checks that every completion
claim has current evidence, and treats the diff and evidence as ground truth
when a report looks wrong - a suspicious result is inspected before it is
reverted or discarded. `review-ready` is a review input requiring acceptance,
never completion evidence. Status handling and correction budgets:
`references/scheduling.md`.

## Production-Diff Review Boundary

Production changes the Lead cannot state completely in the brief are made by a
Worker, so that the Lead's inspection remains an independent review of a diff it
did not write. A Lead that writes production code itself records why independent
review was not possible.

## Review Triggers

Dispatch one independent review when any of these applies:

- security, authorization, migration, destructive behavior, public contracts, or
  difficult rollback;
- broad or subtle changes not adequately established by focused evidence;
- a Worker crossed scope, guessed, omitted evidence, or returned a suspicious
  result;
- two attempts failed on the same work unit;
- the Lead introduced a consequential design choice without prior independent
  evidence.

Routine work does not receive duplicated independent reviews.

## Review Protocol

The review Worker receives approved constraints, the diff, and evidence, but not
the implementation narrative. It returns only concrete, evidenced findings.

One independent review per unit. Its findings are that unit's finding set: the
Lead classifies each as fix, defer with reason, or reject with reason, all in a
single bounded correction pass. A confirmation pass verifies only that those
findings were addressed. New issues it raises become backlog items or a new unit
under Orchestrator approval, never additional in-unit rounds - unless they are
regressions introduced by the correction itself. Unresolved serious findings
escalate rather than starting an open-ended review loop, and a second
independent review of the same unit trips a circuit breaker.

New tests trace to an acceptance criterion. A rising test count is not
acceptance progress, and review that repeatedly requires another proof is a loop
signal, not diligence.
