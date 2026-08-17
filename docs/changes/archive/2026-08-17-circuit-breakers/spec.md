# Specification: Circuit Breakers and Revised Return Thresholds

Ownership and approval:
- Owner: user
- Status: Approved 2026-08-17 by user

## Intent and Desired Outcome

Two observed session retrospectives (`plasma-auto-tiler`, 2026-08-14 and the
2026-08-15 resumption, plus an anti-loop finding from a later session) showed
one dominant failure mode the skills do not currently catch: effort without
state progress. A single semantic unit stayed unaccepted while attempts,
correction rounds, and independent-review findings accumulated across fresh
Workers, fresh Leads, and relabeled authorizations. Fake assertion totals rose
from roughly 105 to 578 without advancing acceptance or the user's goal.

The structural cause is that every existing bound - two unsuccessful attempts
forcing reassessment, one same-scope correction round, one independent review -
is counted inside an agent's own context. Worker replacement, Lead succession,
and a relabeled brief each reset the count to zero, so the loop is legal under
every local rule.

The same retrospectives also produced measured evidence that the current
return thresholds are wrong in both directions: prompt-only 30/50-call limits
did not constrain Workers (attempts observed at 21-65 calls, one at about 110),
while a fixed Orchestrator dispatch cap prevented coherent delivery when it
substituted for context measurement and handover judgement.

The desired outcome is that a loop is detected and broken at whichever tier
first observes it, that the count survives agent succession, and that the
revised thresholds match what the user has since observed to work - without
adding new phases, artifacts, or ceremony. Process weight is itself a cost: the
retrospective's own prioritized list is not adopted wholesale.

## Scope and Non-Goals

In scope:

- A Circuit Breakers section in `processed-beef-orchestrate/SKILL.md` defining
  unit-scoped attempt accounting, trip conditions, the short-circuit response,
  and what does and does not count as a reset.
- A Worker-tier loop self-check in `processed-beef-work-unit/SKILL.md`,
  reported through the existing `decision-needed` status.
- Review termination rules in `references/verification.md`: one independent
  review per unit, a finding set frozen at review time, and a confirmation pass
  that cannot introduce new in-unit rounds.
- A rule in `references/scheduling.md` that a return threshold is a scheduling
  boundary, not an evidence-validity boundary, with single host reconciliation
  of over-threshold work instead of repeated redispatch.
- Revised return thresholds across all documents that state them.
- An acceptance-before-commit rule, without new lifecycle states.
- Static versus live typing of verification commands.
- A sharpened `state.md` trigger.
- Validation and behavioral-record updates.

Non-goals:

- Host or plugin enforcement of any limit. `.opencode/plugins/processed-beef.js`
  remains an install helper only; this release is skill-only.
- The retrospective's five-state commit lifecycle
  (`review-ready`/`accepted`/`commit-ready`/`committed`/`pushed`). A single
  acceptance rule gives the same guarantee at a fraction of the weight.
- Machine-readable dispatch ledgers, preflight record artifacts, live-debt
  dashboards, and brief linters. These require enforcement that does not exist
  in a prompt-only skill set.
- Project-specific controls from the retrospective (KWin lifecycle risk family,
  QJSEngine built-in scans, live evidence capture contract). These belong in
  the consuming project's `docs/agent-process.md`.
- Standing-policy handles and inherited brief metadata. The compact-brief rule
  already exists; a versioned policy-handle mechanism adds process rather than
  removing it.

## Applicable Principles and Decisions

- Select the smallest suitable process; complexity adds execution controls, not
  ceremonial phases (`references/artifacts.md`).
- Thresholds are provisional and revalidated against observation, not chosen
  by argument.

## Constraints

- `SKILL.md` files stay ASCII, under 500 lines, and under 20000 bytes.
- Threshold wording is stated identically wherever it appears: both role
  skills, `references/scheduling.md`, `README.md`, `docs/architecture.md`,
  `assets/agent-process.md`, and all five integration guides.
- No new report status is introduced; the loop signal rides on
  `decision-needed`.
- No new required artifact is introduced.
- `sh tests/validate.sh` passes.

## Acceptance Criteria

- [ ] Attempt accounting is defined as belonging to the semantic unit and as
      surviving Worker replacement, Lead succession, correction rounds,
      handovers, and malformed, missing, or cancelled reports.
- [ ] The Lead records attempts, correction rounds, independent reviews, and
      met acceptance criteria against each unit in `plan.md`.
- [ ] Trip conditions are stated and countable: a third attempt on one unit, a
      second correction round on one unit or checkpoint, a second independent
      review of the same unit, failures changing location but not class, and
      growing verification volume with no acceptance criterion moving to met.
- [ ] The short-circuit response is stated: stop implementing, dispatch nothing
      further on the unit, preserve work and evidence, escalate one tier with a
      loop report, and in normal mode take it to the user and freeze a changed
      path before any further dispatch.
- [ ] A reset is defined as a change of kind, and another patch, another
      Worker, another review pass, or the same objective under a new brief
      label is explicitly not a reset.
- [ ] A Worker stops after two rounds leaving the same failure class and
      returns `decision-needed` with a `Loop-suspected` field.
- [ ] One independent review per unit; a confirmation pass verifies only that
      the finding set was addressed; new issues become backlog items or a new
      unit under Orchestrator approval unless they are regressions of the
      correction.
- [ ] New tests trace to an acceptance criterion, and rising test count is
      stated not to be acceptance progress.
- [ ] A threshold breach is stated not to invalidate evidence; over-threshold
      work is reconciled once rather than discarded and redispatched, and
      process compliance is reported separately from technical acceptance.
- [ ] Thresholds read: a Worker targets about 12-16 of its own tool calls and
      returns by about 20; a Lead returns after 3 completed work units or about
      20 of its own tool calls, whichever comes first; the Orchestrator has no
      fixed dispatch cap and hands over deliberately on host context telemetry
      when available, otherwise on dispatch volume and work state.
- [ ] A commit or push requires every contained unit to be accepted with no
      open blocker, acceptance gap, or unresolved serious review finding, and
      fix-forward is limited to defects found after an honest acceptance.
- [ ] Verification commands are typed static or live by what they do rather
      than by their name.
- [ ] `state.md` is required before the next dispatch once a second Lead
      succession occurs or any Expanded trigger fires.
- [ ] `sh tests/validate.sh` passes, with a contract check covering this
      change.

## Unresolved Questions

- Whether 20 own tool calls is the right Lead bound alongside the 3-unit bound.
  Adopted on the user's observation; revalidate over the next 2-3 sessions.

## Consequential Decisions

- Skill-only implementation. Prompt-only limits are advisory in practice, and
  the retrospective is right that a true hard limit needs host enforcement; the
  user has scoped the plugin to installation only, so this change improves
  detection and response rather than claiming enforcement.
- The Orchestrator loses its fixed dispatch cap. The 2026-08-15 resumption
  delivered roughly 21 scoped commits past the old cap without an observed
  handover failure, and premature dispatch stops prevented coherent delivery.
  Deliberate handover judgement replaces the number.
- The retrospective is not retained. Its durable findings are recorded here and
  in the behavioral record; the report file is removed on completion.
