# Artifacts Reference

## Routing Levels

Levels and their artifacts are in the orchestrate skill. `log.md` starts once
subagent work starts. An Expanded upgrade may add durable research, `state.md`,
successive Leads, specialist review, migration or rollback evidence, and extra
user decisions - only the ones its triggers call for.

Upgrade Standard to Expanded when any of these appears:

- scope crosses major subsystems, services, repositories, or ownership
  boundaries;
- a lasting architecture, product, security, data, cost, or operational decision
  is required;
- requirements remain ambiguous after one focused clarification;
- a Lead cannot reasonably finish below the `150000` context ceiling;
- a task cannot be independently implemented and verified by one Worker;
- work introduces migration, public compatibility, authorization, destructive
  behavior, or difficult rollback;
- verification repeatedly fails or evidence cannot establish an acceptance
  criterion;
- implementation reveals the approved specification is materially incomplete or
  wrong.

Complexity adds execution controls, not ceremonial phases.

## Change Directory

```
docs/changes/archive/YYYY-MM-DD-<change>/   # spec.md, plan.md, lasting research only
docs/changes/<active-change>/
    spec.md      # required
    plan.md      # required
    log.md       # required for active Standard and Expanded work
    state.md     # only for multi-Lead work
    handover.md  # only for a top-level transfer without a live parent
    research/    # only for durable decision evidence
```

`docs/backlog.md` is created only when more than one change is pending or
active. Each item is one physical line linking to its change directory and
identifying cross-change dependencies; it never duplicates plan tasks.

Project-level templates: `assets/principles.md` to `docs/principles.md`,
`assets/decisions.md` to `docs/decisions.md`, `assets/backlog.md` to
`docs/backlog.md`, and `assets/agent-process.md` to `docs/agent-process.md`.

## spec.md

Template: `assets/spec.md`. The normally user-approved source of truth: intent
and desired outcome, scope and non-goals, applicable principles and decisions,
constraints, acceptance criteria, unresolved questions, and consequential
decisions with rationale. Implementation does not begin until the user approves
it unless autonomous mode was explicitly requested.

## plan.md

Template: `assets/plan.md`. Lead-owned and Orchestrator-approved. The plan has
two surfaces:

- Semantic - technical approach, bounded work units with stable IDs and
  dependencies, file or subsystem scope, and verification commands or
  observations typed static or live. Proposed by the Lead within the approved
  spec, principles, and decisions; the Orchestrator approves each edit before it
  is made.
- Record-keeping - progress, the acceptance-criterion evidence map, per-unit
  semantic-attempt, pre-review-correction, finding-fix-correction, and
  independent-review counts, and deterministic change-wide implementation
  dispatches, semantic attempts, `dispatch-invalid` results, both correction classes, independent
  reviews, changed-kind resets, broad-gate runs, Worker and Lead tool-call
  proxies, acceptance criteria moved, and the no-progress streak. Lead-owned,
  needs no approval, reported in the Lead's normal return. Record-only drift is
  reconciled but never blocks source work when the approved semantic plan is
  unambiguous. The counts belong to
  the semantic unit and change and are carried across Worker replacement and
  Lead succession rather than reset. Three semantic attempts without a progress
  credit park and escalate; mechanical events never increment this streak. One
  changed-kind reset is the maximum.

Evidence fields are records, not lifecycle policy. Unit 05 owns serial
execution, completion, correction, reset, repair, dispatch, and escalation
rules; these templates reference that policy without replaying it. For each
relevant claim, retain:

- a work-kind ledger with scope and separate read and mutate authorization;
- the source snapshot, output correspondence, and freshness after the latest
  source change;
- a scoped candidate inventory with each candidate classified as tracked or
  untracked;
- a warning baseline marked informational only.

Warning baselines cannot mask failed assertions, nonzero commands, missing
output, or unmet live-safety prerequisites. Stale or mismatched source/output
evidence is ineligible for acceptance until refreshed.

## log.md

Template: `assets/log.md`. Append-only checkpoint log for crash recovery. Each
entry records timestamp, role and work unit, result, changed files or commit,
verification, and any discovery, blocker, or required decision. Include the
  dispatch status and deterministic change-wide telemetry when relevant. No
  tool-by-tool narration, copied output, speculation, or information obvious from
  the diff.

## Artifact Update Cadence

Batch full plan, log, and state updates for ordinary same-scope corrections.
Record immediately, never batched: an accepted semantic unit, a verified partial
result, a blocker, a pending user decision, an unsuccessful host attempt, a
context handover, a semantic or governance change, an independent review
finding, an approved plan change, and any commit.

## Conditional Artifacts

- `state.md` - template `assets/state.md`; created before the next dispatch once
  a second Lead succession occurs on the change or any Expanded trigger fires;
  records current major unit, completed units, blockers, next dispatch, and the
  per-unit attempt, correction, and review counts a successor inherits.
- `handover.md` - template `assets/handover.md`; written only at a top-level
  session transfer or a boundary without a live parent where chat cannot bridge.
  It records the objective, completed work, exact files and commits, decisions,
  verification, blockers, and next action. Worker-to-Lead and Lead-to-
  Orchestrator handovers return curated reports through chat instead.
- `research/` - conclusions and citations that must survive planning. Raw
  exploration transcripts are not retained.

## Startup And Preservation

At startup, record `agent_commits`, `agent_pushes`, `staging_owner`,
`user_commit_required`, `candidate_preservation`, and `cleanup_owner` in the
plan. Record the scoped tracked/untracked candidate inventory and separate read
and mutate authorization. Default policy is no agent commit or push. In
user-owned commit mode, stage approved paths only and return one one-line commit
message; do not dispatch a commit-only Worker.

Rejected work uses exactly one authorized bounded preservation container. Its
manifest records paths, reason, owner, retention, deadline, cleanup owner, and
cleanup disposition. A second container or accumulating stash is a
stop-and-escalate condition. Irreversible deletion of an untracked candidate is
also an escalation, never an implicit cleanup disposition.

## Completion Transaction

Never run while governance conflicts, pending user decisions, or acceptance gaps
remain. A unit is never fragmented into a separate commit-only Worker, the Lead
performs the commit itself, and Workers never administer completion.

1. Lead produces the acceptance-evidence map and residual-risk summary.
2. Orchestrator approves alignment or returns concrete gaps.
3. User approves the result unless autonomous mode delegated result approval.
4. Lead promotes approved lasting documentation and governance edits.
5. Lead removes transient log, state, handover, and low-value research.
6. Lead moves the change to `docs/changes/archive/YYYY-MM-DD-<change>/`.
7. Lead removes the linked one-line backlog entry.
8. Lead verifies links and repository status and reports evidence.

The archive retains `spec.md`, `plan.md`, and only research with lasting
standalone value.
