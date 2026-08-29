# Specification: Delegation Economics

> Historical record. Paths and controls describe the repository at the time.

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

## Follow-up: Lead Direct-Read Falsification (2026-08-07)

Scenario 7 ("Duplicated Corpus Loading") predicted GREEN: Pending future observation. Observed RED on 2026-08-07 for a related but distinct failure: a Lead read a large corpus directly (158,473+ bytes, 0 Worker dispatches) instead of delegating, exceeding the 127,500-byte ceiling. See `rationale-and-watchlist.md` for full detail and monitoring criteria.

Acceptance criteria for the seven gap-closing edits:
- AC1: `SKILL.md` Context Discipline names the Lead alongside the Orchestrator as excluded from holding raw content, carving out the diff and evidence a unit's acceptance requires.
- AC2: `SKILL.md` raw-extraction prohibition names the Lead alongside the Orchestrator with the same acceptance-review carve-out, preserving the existing literal contract phrase `does not perform raw extraction`.
- AC3: `scheduling.md` Late Size Discovery treats a Lead's own size/line-count check as bound by the same rule as a host-triggered rejection.
- AC4: `scheduling.md` specifiability test explicitly binds read-only and investigation units.
- AC5: `scheduling.md` Corpus Ownership requires a Lead-held brief to name specific facts, IDs, and prior findings already established in-session.
- AC6: `work-unit/SKILL.md` Report Shape requires a read-only/investigation unit's report to itemize every requested fact rather than summarize.
- AC7: `scheduling.md` records that a Lead's byte typically costs more than a Worker's under mixed model tiers, as a delegation reason distinct from context volume.

## Follow-up: Role-Model Clarification (2026-08-07)

Scenario 9 ("Direct Test-Run Execution Instead of Delegation") was observed RED on 2026-08-07: both the Lead and the Orchestrator ran `sh tests/validate.sh` directly instead of delegating, despite the test-run delegation trigger already in `references/scheduling.md`. A user-authored role-model audit of the delegation-economics guidance found ten clarification gaps, addressed below; the two deliberate scope decisions (no duration language, Orchestrator kept technical-consultation-only) are recorded in `rationale-and-watchlist.md`, not reopened here.

Acceptance criteria for the ten role-model clarification items:
- AC1: `SKILL.md` Lead role definition names a pre-start split for a unit judged too large and cleanly separable before starting; `scheduling.md` Recovery proposes the same split to the Orchestrator instead of starting or grinding through it.
- AC2: `SKILL.md` Context Discipline names host reconciliation as the Lead's only other direct-extraction right, alongside the acceptance diff and evidence carve-out.
- AC3: `scheduling.md` Delegation Decision names the delegable categories explicitly: code and file changes, test and command runs, documentation writing, documentation search and summarisation, and web research.
- AC4: `SKILL.md` startup-reads paragraph limits a Lead to reading only the spec, plan, and governing clauses of the unit it owns plus the diff and evidence a Worker's output requires; any other direct read is a narrow exception, not the default.
- AC5: `SKILL.md` startup-reads paragraph bounds the Orchestrator's direct reads to top-level READMEs, `docs/backlog.md`, `docs/decisions.md`, and vision or architecture docs, and no further.
- AC6: `work-unit/SKILL.md` Worker role preamble states a Worker interacts only with its dispatching Lead, never the Orchestrator or user directly.
- AC7: `governance.md` Escalation records the decision blast-radius ladder: a Worker decides an obvious choice within its own scope, a choice inside the backlog item returns to the Lead, and anything outside it escalates to the Orchestrator.
- AC8: `governance.md` Escalation folds project dependencies (e.g. `package.json`) into the same blast-radius sentence as always escalating to the Orchestrator.
- AC9: `SKILL.md` Roles section states the cost-tier rationale once: the Orchestrator runs the most expensive model and is reserved for organisation, planning, strategy, user interaction, and technical expertise; Workers run the cheapest model, are error-prone, stay tightly scoped, and are inspected, never trusted.
- AC10: `governance.md` Escalation records a Lead's option to put a complex or ambiguous technical question to the Orchestrator, framed self-contained so it answers from expertise without loading the Lead's corpus.
