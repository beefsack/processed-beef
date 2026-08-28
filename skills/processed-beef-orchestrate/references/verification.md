# Verification Reference

## Evidence Standard

Every acceptance criterion maps to reproducible evidence in `plan.md`. Each
evidence row names a stable gate ID, its literal canonical command or
observation, and the expected baseline. Evidence may be a focused test, check,
inspection, screenshot, log, or other current observation appropriate to the
behavior.

Expected baselines state semantic pass conditions. Prefer exit status, zero
failures, exact required failure identity, no-new-failure differentials, hashes,
or minimum coverage. Pin an exact assertion or test count only when the count is
itself part of the approved contract. Added passing tests and record-only drift
do not invalidate an otherwise unchanged baseline.

Each gate-evidence row also binds the source snapshot (Git revision, scoped
diff, and relevant untracked inputs), gate ID, literal command or observation,
expected baseline, output artifact or observation reference, result, and a
post-latest-change freshness result. The output reference must correspond to
that exact snapshot and gate. Evidence is stale when any relevant source change
postdates it, the scoped inputs differ, or the output cannot be tied to the
snapshot; stale evidence cannot accept work.

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
Starting a live runner does not itself start a semantic attempt. A preflight,
tool, environment, dependency, working-directory, or evidence failure before the
first intended host mutation or target scenario is mechanically reconciled.

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
- two semantic attempts failed on the same work unit;
- the Lead introduced a consequential design choice without prior independent
  evidence.

Routine work does not receive duplicated independent reviews.

## Review Protocol

The review Worker receives approved constraints, the diff, and evidence, but not
the implementation narrative. It returns only concrete, evidenced findings.

One pre-review implementation correction is separate from one independent review
finding-fix correction. One independent review produces one finding set: the
Lead classifies each as fix, defer with reason, or reject with reason, all in a
single bounded finding-fix pass. A second pre-review correction trips the
pre-review breaker, and a second finding-fix correction for that set trips the
finding-fix breaker. A confirmation pass verifies only that those findings were
addressed; it is neither an independent review nor a correction.
New issues it raises become backlog items or a new unit under Orchestrator
approval, never additional in-unit rounds - unless they are regressions
introduced by the correction itself. Unresolved serious findings escalate rather
than starting an open-ended review loop, and a second independent review of the
same unit trips a circuit breaker.

Focused tests and typechecks run per unit. Full suite, dogfood, package, and
deterministic build gates run once at a named risk or final integration
checkpoint unless the plan records a changed risk that justifies another run.
If a Worker runs the wrong local command, the Lead reruns the plan's canonical
gate and reconciles the result locally; it is not a user decision. A bounded
fixture or harness-contract unit is independently accepted before production
integration, with plan evidence for state ownership, recursive child behavior
where relevant, re-decode and snapshot restoration, failure injection where
relevant, and public-route constraints. Fixture failures do not permit
production workarounds and remain subject to unit and change-wide budgets.

New tests trace to an acceptance criterion. A rising test count is not
acceptance progress, and review that repeatedly requires another proof is a loop
signal, not diligence.

### Repair Evidence

A correction-regression repair is valid only after an immediately preceding
pre-review or finding-fix correction and only with predecessor-valid evidence
of a formerly passing canonical gate, a reproducible current regression,
localized correction provenance, an unchanged frozen target or finding set,
fresh before/after scoped source snapshots, output correspondence, and an
original-target recheck. The repair is limited to test, fixture, harness, gate,
or evidence paths, including typing-only changes within those paths. Missing or
stale predecessor evidence, an unreproducible or
pre-existing failure, non-local provenance, changed target, second claim, failed
restoration, new finding, serious unresolved finding, out-of-scope edit, or
semantic change parks and escalates. A successful repair records
`canonical_gate_restored`; it is not a progress credit and does not reset
no-progress. Ownership, public-route, snapshot, rollback, oracle,
fixture-contract, acceptance-mechanism, and production-invariant changes remain
ordinary semantic work.
