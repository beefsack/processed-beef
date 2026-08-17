# Specification: Process Overhead Reduction

Ownership and approval:
- Owner: user
- Status: Approved 2026-08-17 by user

## Intent and Desired Outcome

An efficiency review of the skill set identified seven overheads whose cost
exceeds what they save. Good overheads pay for themselves; these do not. Remove
or reduce each without weakening a control that the behavioral record shows has
ever caught a real failure.

The findings, with the cost measured in the repository as it stood:

1. `references/governance.md` required Orchestrator approval of every `plan.md`
   edit, routing progress ticks, evidence rows, and counters through the most
   expensive tier. The 2026-08-14 retrospective recorded this as administrative
   accumulation in the Orchestrator.
2. Policy prose was duplicated across twelve documents. The return-threshold
   paragraph alone was stated identically in nine files and had to be edited in
   all nine for one numeric change; `150000` appeared 31 times across 16 files;
   the lifecycle status table existed in five places.
3. `tests/validate.sh` had accumulated 58 literal phrase assertions across five
   per-change contract functions. They can detect only text, not behavior, and
   they price up every later simplification.
4. The `150000` ceiling was stated as process prose, then immediately qualified
   as unmeasurable, in document after document. Behavior is driven entirely by
   the countable proxies.
5. Every Worker read `docs/principles.md` on every dispatch - 20 to 30 reads
   per session of a document whose relevant clauses the brief must already
   state as constraints.
6. `blocked` carried two opposite meanings, pause and terminal handover,
   requiring the distinction to be restated eight times across the skills.
7. The attempt counters added on 2026-08-17 required a table of zeroes even
   when every unit completed first try.

## Scope and Non-Goals

In scope:

- Restrict Orchestrator plan approval to the semantic sections of `plan.md`.
- Single-source the duplicated policy prose; other documents describe and link.
- Prune retired per-change contract checks from `tests/validate.sh` and keep
  the structural checks plus the current release cycle's contract.
- Demote `150000` from recurring process prose to a stated configuration value.
- Replace the per-dispatch `docs/principles.md` read with brief-named clauses.
- Add a distinct `handover` status and delete the `blocked` overload caveats.
- Record attempt counters only once a count exceeds 1.
- Compress the delegation-decision rules without changing their behavior.

Non-goals:

- Relaxing serial execution. Parallel read-only research on disjoint paths has
  a real cost saving, but serialization is a user-owned design decision pending
  worktree-backed concurrency, and is left unchanged.
- Removing any control the behavioral record shows caught a real failure: role
  assertion, pre-dispatch reconciliation, Lead diff inspection, report shape,
  the delegation-decision rules themselves, `log.md`, and destructive-action
  authorization all stay.

## Constraints

- No behavioral rule changes meaning; this change removes restatement, not
  substance, except where a finding names the rule itself.
- `SKILL.md` files stay ASCII, under 500 lines, and under 20000 bytes.
- `sh tests/validate.sh` passes.

## Acceptance Criteria

- [ ] `plan.md` has named approval-bearing sections; the Lead edits progress,
      evidence, counters, and outcome without a round trip.
- [ ] The return-threshold statement exists in full in one place per role
      skill; README, architecture, and the integration guides describe and link
      rather than restate.
- [ ] `tests/validate.sh` retains structural checks and one current contract
      function; retired per-change phrase functions are removed with a stated
      retirement rule.
- [ ] `150000` is stated as a configuration default, without the recurring
      unmeasurable caveat in every document.
- [ ] The Worker reads `docs/principles.md` only when its unit touches
      governance; otherwise the brief names the applicable clauses.
- [ ] A `handover` status exists; no document explains that `blocked` can mean
      a terminal handover.
- [ ] Attempt counters are recorded only for units whose count exceeds 1.
- [ ] The delegation-decision rules are materially shorter with unchanged
      behavior.
- [ ] `sh tests/validate.sh` passes.

## Consequential Decisions

- Contract checks now retire by rule rather than accumulate. A change's phrase
  checks are kept for the current release cycle, then dropped once the behavior
  is recorded in `tests/behavioral.md`. The alternative - permanent wording
  locks - makes the skill set unable to be simplified.
- Duplication is removed in the documents nobody loads during work (README,
  architecture, integration guides) and preserved only where a role actually
  reads it (its own skill and references).
