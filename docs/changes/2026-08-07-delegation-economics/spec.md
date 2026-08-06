# Specification: Delegation Economics

Ownership and approval:
- Owner: User
- Status: Approved 2026-08-07 by user and Orchestrator

## Intent and Desired Outcome

A live brdgme session under the Lead-owned lifecycle exposed concrete
under-delegation: Leads self-executing discoverable, delegable work instead of
dispatching Workers. Replace the ambiguous "direct reads are insufficient"
delegation guidance with a specifiability test, name a corpus-ownership and
forfeit rule, add a reactive delegation trigger for material whose size is only
discovered when a read or command is rejected, add a bounded mid-unit
checkpoint status, tighten three existing clauses that told Leads to read
directly by default, and add an Orchestrator raw-extraction prohibition.

## Scope and Non-Goals

In scope:

- A `Delegation Decision` specifiability test and a `Corpus Ownership and
  Forfeit` rule in `references/scheduling.md`.
- A `Late Size Discovery` reactive-delegation trigger in
  `references/scheduling.md`, applicable to every role.
- A `checkpoint`/`continue` lifecycle status with a per-checkpoint correction
  budget, in `skills/processed-beef-work-unit/SKILL.md` and
  `references/scheduling.md`.
- Replacement of the commit clause (Recovery), the investigation clause
  (Standard Dispatch Sequence item 2), and the Lead-reading clause (Lead
  Inspection) in `references/scheduling.md`; consistency correction in
  `references/artifacts.md`.
- A production-diff review boundary in `references/verification.md`.
- An Orchestrator raw-extraction prohibition in
  `skills/processed-beef-orchestrate/SKILL.md` Context Discipline.
- A measurable watchlist and desired-outcome targets recorded in this change's
  `rationale-and-watchlist.md`.
- Behavioral RED scenarios in `tests/behavioral.md` capturing the observed
  under-delegation pressure, with GREEN left pending future observation.
- An extension of `tests/validate.sh`'s literal-phrase contract to guard the
  new wording, matching the convention set by
  `2026-08-05-lead-lifecycle`.

Non-goals:

- Change the three-role hierarchy, serial execution rule, context ceiling, or
  user-owned governance rules.
- Weaken any rule that worked in the observed session: zero commit-only
  Workers, zero Worker task calls, zero `host-unknown`, `review-ready` not
  being acceptance, independent review for high-risk work, or terminal
  handovers.
- Add runtime orchestration software or host-specific enforcement.

## Applicable Principles and Decisions

- `docs/changes/archive/2026-08-05-lead-lifecycle/` established the Lead-owned
  major-unit lifecycle. This change refines its delegation guidance (Standard
  Dispatch Sequence item 2 and the investigation, commit, and Lead-reading
  clauses) without altering Lead ownership, `review-ready` semantics, commit
  ownership, or the correction-round rule for whole-unit corrections.

## Constraints

- ASCII only; no em dashes, smart quotes, or ellipsis characters.
- Each `SKILL.md` stays under 500 lines and under 20000 bytes.
- Skills contain no host-specific content: model names, costs, and session-store
  details belong in `docs/`, never in `skills/`.
- Relative links from a `SKILL.md` resolve inside its own skill directory.
- `sh tests/validate.sh` must pass.
- The measured baseline is presented as evidence from one session of
  commit-and-cleanup work, not a benchmark promise, and its scope is not
  comparable to the `2026-08-05` baseline.

## Acceptance Criteria

- [x] `Delegation Decision` specifiability test defined in
  `references/scheduling.md`.
- [x] `Corpus Ownership and Forfeit` rule defined in `references/scheduling.md`.
- [x] `Late Size Discovery` reactive trigger defined, distinguishing a
  triggering event that leaves the cost unpaid from mid-unit dispatch after the
  Lead already loaded the material (a forfeit).
- [x] `checkpoint`/`continue` status added to the Worker lifecycle in
  `skills/processed-beef-work-unit/SKILL.md` and `references/scheduling.md`,
  with a correction budget that is per checkpoint, not per unit.
- [x] The commit clause (Recovery), the investigation clause (Standard Dispatch
  Sequence item 2), and the Lead-reading clause (Lead Inspection) are replaced
  in `references/scheduling.md`; `references/artifacts.md:101` is consistent
  with the new commit wording.
- [x] A production-diff review boundary is added to
  `references/verification.md`.
- [x] An Orchestrator raw-extraction prohibition is added to
  `skills/processed-beef-orchestrate/SKILL.md` Context Discipline.
- [x] Watchlist rows and measurable desired outcomes are recorded in
  `rationale-and-watchlist.md`.
- [x] Four RED behavioral scenarios are recorded in `tests/behavioral.md`,
  matching its existing table format; GREEN is left pending, not fabricated.
- [x] `tests/validate.sh` extends its literal-phrase contract to guard the new
  wording and passes.
- [x] `sh tests/validate.sh` passes.

## Unresolved Questions

- None.

## Consequential Decisions

- Reactive mid-work delegation (Late Size Discovery) is permitted only when the
  triggering event leaves the cost unpaid; delegation after the Lead has
  already loaded a unit's material is a forfeit, not a legitimate reactive
  dispatch, and the Lead finishes the unit itself.
- A `checkpoint` is named only where an error would be expensive to unwind; a
  unit with no named review point returns once, at completion. The correction
  budget at a checkpoint is per checkpoint, not per unit, distinct from the
  existing one-per-unit `review-ready` correction round.
- Mechanical staging within a unit (hunk selection, patch construction,
  application, verification) is ordinary delegable work; a unit is still never
  fragmented into a separate commit-only Worker, and the Lead still performs
  the commit itself.
- A Lead that writes production code itself records why independent review was
  not possible, rather than silently skipping review.

## Rationale and Follow-Up Observation

Historical baseline evidence, decision rationale, and future-session desired
outcomes and watchlist are recorded in
[`rationale-and-watchlist.md`](rationale-and-watchlist.md). That record is
non-normative; installed skills and references define the delegation contract.
