# Specification: Context and Safety Hardening

Ownership and approval:
- Owner: User
- Status: Approved 2026-08-08 by user and Orchestrator

## Intent and Desired Outcome

A brdgme session measured against the `2026-08-07-delegation-economics`
targets hit the delegation-economics goals (Worker:Lead ratio, zero
`host-unknown`, correct escalations) but failed the context ceiling
completely: peak single-request context reached 306,523 tokens, over double
the `150000` limit, across four sessions that exceeded it, with zero
handovers all session. The `wc -c` byte-counting rule caused this: it counts
file bytes read only, overcounting reads by 3-4x while ignoring the
conversation, tool outputs, subagent reports, and skill text where context
actually accumulates, and it requires shell access a Worker may not have. The
same session also surfaced two structural gaps: a Lead misidentified itself
as Orchestrator after loading this skill and dispatched a nested Lead past
supported depth, and a Worker deleted a 31 MB production database dump
unasked during read-only recon. Replace the context-accounting mechanism with
countable proxies the agent can count exactly from its own history, require
every role to assert its actual identity before acting, add destructive-action
authorization and escalation rules, and correct two watchlist measures that
targeted the wrong thing.

## Scope and Non-Goals

In scope:

- Replace the `wc -c` byte-counting context rule everywhere it appears (11
  files: `README.md`, `docs/architecture.md`, five
  `docs/integrations/*.md` files, `skills/processed-beef-orchestrate/SKILL.md`,
  `skills/processed-beef-orchestrate/assets/agent-process.md`,
  `skills/processed-beef-orchestrate/references/scheduling.md`, and
  `skills/processed-beef-work-unit/SKILL.md`) with countable-proxy return
  thresholds (completed work units, dispatches made, own tool calls),
  explicitly provisional and due for revalidation over 2-3 sessions, and a
  stated preference for exact host telemetry where available. Reframe a
  threshold return as the normal end of a bounded stint, not an emergency.
- Require every role to assert, as the first line of its first output, its
  actual role, configured role, and parent, and to dispatch only the tier
  directly below it, in `skills/processed-beef-orchestrate/SKILL.md` and
  `skills/processed-beef-work-unit/SKILL.md`.
- Add a destructive-action authorization requirement to the brief-contents
  list in `skills/processed-beef-orchestrate/SKILL.md`,
  `skills/processed-beef-orchestrate/references/scheduling.md`, and
  `skills/processed-beef-work-unit/SKILL.md`, and an irreversible-destruction
  escalation trigger in `skills/processed-beef-orchestrate/references/scheduling.md`
  and `skills/processed-beef-orchestrate/references/governance.md`.
- Correct the same-material duplication target to exclude a unit's `spec.md`
  and `plan.md`, and supplement the Orchestrator cost-share metric with a
  per-dispatch cost measure, in
  `docs/changes/2026-08-07-delegation-economics/rationale-and-watchlist.md`.
- Record this session's per-session capture in that same file, in the format
  its `Per-Session Capture` section requests, and record that PII handling was
  raised and explicitly rejected by the user as out of scope.
- Three new RED behavioral scenarios in `tests/behavioral.md` (context ceiling
  never triggering, nested-Lead role confusion, unauthorised destructive
  action), with GREEN left pending, and a `CHANGELOG.md` Unreleased entry.
- Extend `tests/validate.sh`'s literal-phrase contract to guard the new
  wording and replace the now-obsolete `wc -c` contract.

Non-goals:

- Change the three-role hierarchy, serial execution rule, or the `150000`
  documented budget value itself.
- Weaken any escalation, delegation, `decision-needed`, corpus-ownership, or
  specifiability clause. Additions to escalation and brief-contents in this
  change are strictly additive.
- Add PII-handling guidance: raised during scoping and explicitly rejected by
  the user as a project/user data concern, not agent-structure guidance.
- Add runtime orchestration software, host-specific enforcement, or a new
  role-level restriction (for example, "Workers may not delete") in place of
  the brief-authorization and escalation clauses.

## Applicable Principles and Decisions

- `docs/changes/2026-08-07-delegation-economics/` established the
  specifiability test, corpus-ownership and forfeit rule, and Orchestrator/Lead
  raw-extraction prohibition this change must not weaken.
- `docs/changes/archive/2026-08-05-lead-lifecycle/` established the Lead-owned
  major-unit lifecycle this change does not alter.

## Constraints

- ASCII only; no em dashes, smart quotes, or ellipsis characters.
- Each `SKILL.md` stays under 500 lines and under 20000 bytes.
- Skills contain no host-specific content: model names, costs, and
  session-store details belong in `docs/`, never in `skills/`.
- Relative links from a `SKILL.md` resolve inside its own skill directory.
- `sh tests/validate.sh` must pass.
- Prefer small, targeted edits; the net change to skill and reference files
  should be neutral or smaller in size, not a restructuring.
- No escalation, delegation, `decision-needed`, corpus-ownership, or
  specifiability clause is weakened by this change.

## Acceptance Criteria

- [ ] The `wc -c` byte-counting rule is removed from all 11 files listed above
  and replaced with the countable-proxy mechanism, marked provisional, with
  exact host telemetry stated as preferred.
- [ ] Provisional thresholds are stated: Worker returns after about 30 of its
  own tool calls; Lead returns after 3 completed work units or about 50 of its
  own tool calls, whichever comes first; Orchestrator hands over after about
  20 dispatches.
- [ ] A threshold return is described as the normal end of a bounded stint,
  not an emergency, in every file carrying the mechanism.
- [ ] `skills/processed-beef-orchestrate/SKILL.md` and
  `skills/processed-beef-work-unit/SKILL.md` require a role to assert its
  actual role, configured role, and parent as the first line of its first
  output, and to dispatch only the tier directly below it.
- [ ] Destructive-action authorization is added to the brief-contents
  requirement in `SKILL.md`, `scheduling.md`, and the work-unit `SKILL.md`,
  and irreversible-destruction-outside-version-control is added as an
  escalation trigger in `scheduling.md` and `governance.md`.
- [ ] `docs/changes/2026-08-07-delegation-economics/rationale-and-watchlist.md`
  excludes `spec.md`/`plan.md` from the same-material duplication target,
  supplements the Orchestrator cost-share metric with a per-dispatch measure,
  records this session's per-session capture, and records the PII-handling
  rejection.
- [ ] Three new RED behavioral scenarios are recorded in `tests/behavioral.md`
  matching its existing table format; GREEN is left pending.
- [ ] `CHANGELOG.md` has a new Unreleased entry summarizing this change.
- [ ] `tests/validate.sh` extends its literal-phrase contract to guard the new
  wording, drops the obsolete `wc -c` assertions, and `sh tests/validate.sh`
  passes.

## Unresolved Questions

- None.

## Consequential Decisions

- The destructive-action rule is enforced through existing brief-authorization
  and escalation machinery rather than a new role-level restriction: a
  "Workers may not delete" rule was considered and rejected because deletion
  is often ordinary delegable work, it would push routine cleanup to a more
  expensive tier, and it would not stop a Lead making the same error.
- Irreversible destruction outside version control always escalates to the
  Orchestrator regardless of brief authorization, because tracked-file
  destruction is Git-recoverable but untracked data, production systems, and
  external state are not; user data escalates through the Orchestrator to the
  user.
- The provisional thresholds are derived from one session's measurements and
  are explicitly not final: they are due for revalidation over the next 2-3
  sessions, and exact host token telemetry is preferred over them wherever a
  host exposes it.
- PII handling in agent output was raised and explicitly rejected as out of
  scope by the user: it is recorded in
  `rationale-and-watchlist.md` so it is not reproposed.
