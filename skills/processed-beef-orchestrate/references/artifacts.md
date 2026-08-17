# Artifacts Reference

## Routing Levels

| Level | Use when | Artifacts |
|---|---|---|
| Micro | clear, low-risk, single-purpose change with no material unknowns or lasting decision | none; user request acts as approved scope |
| Standard | normal feature, non-trivial bug, or work needing explicit acceptance criteria | `spec.md`, `plan.md`, and `log.md` once subagent work starts |
| Expanded | complexity discovered; upgrade Standard in place, add only triggered controls | existing files plus durable research, `state.md`, successive Leads, specialist review, migration/rollback evidence, or extra user decisions |

Upgrade Standard to Expanded when any of these appears:

- scope crosses major subsystems, services, repositories, or ownership boundaries
- a lasting architecture, product, security, data, cost, or operational decision is required
- requirements remain ambiguous after one focused clarification
- a Lead cannot reasonably finish below the `150000` context ceiling
- a task cannot be independently implemented and verified by one Worker
- work introduces migration, public compatibility, authorization, destructive behavior, or difficult rollback
- verification repeatedly fails or evidence cannot establish an acceptance criterion
- implementation reveals the approved specification is materially incomplete or wrong

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

## spec.md

Template: `assets/spec.md`.

The normally user-approved source of truth. Contains intent and desired
outcome, scope and non-goals, applicable principles and decisions, constraints,
acceptance criteria, unresolved questions, and consequential decisions with
rationale. Implementation does not begin until the user approves it unless
autonomous mode was explicitly requested.

## plan.md

Template: `assets/plan.md`.

Lead-owned and Orchestrator-approved. Contains technical approach, bounded work
units with stable IDs and dependencies, file or subsystem scope, verification
commands or observations typed static or live, progress, per-unit attempt,
correction, and independent-review counts, pending user decisions,
acceptance-criterion evidence, residual risks, and final outcome. The counts
belong to the semantic unit and are carried across Worker replacement and Lead
succession rather than reset.

The plan has two surfaces. Its semantic sections - technical approach, work
units, dependencies, scope, and verification - are proposed by the Lead within
the approved spec, principles, and decisions, and the Orchestrator approves
each edit before it is made. Its record-keeping sections - progress, the
acceptance-criterion evidence map, attempt counters, residual risks, and the
final outcome - are Lead-owned, need no approval, and are reported in the
Lead's normal return.

## log.md

Template: `assets/log.md`.

Append-only checkpoint log for crash recovery. Append after a meaningful
checkpoint: an accepted semantic unit, verified partial result, blocker,
pending user decision, unsuccessful host attempt, context handover, semantic or
governance change, independent review finding, commit, or approved plan change.
Each entry records timestamp, role and work unit, result, changed files or
commit, verification, and any discovery, blocker, or required decision. No
tool-by-tool narration, copied output, speculation, or information obvious from
the diff.

## Artifact Update Cadence

Batch full plan, log, and state updates for ordinary same-scope corrections.
Record immediately, never batched: an accepted semantic unit, a blocker, a
pending user decision, a `host-unknown` or otherwise unsuccessful host attempt,
a context handover, a semantic or governance change, an independent review
finding, and any commit.

## Conditional Artifacts

- `state.md` - template `assets/state.md`; created before the next dispatch
  once a second Lead succession occurs on the change or any Expanded trigger
  fires; records current major unit, completed units, blockers, next dispatch,
  and the per-unit attempt, correction, and review counts a successor inherits.
- `handover.md` - template `assets/handover.md`; written only at a top-level
  session transfer or a boundary without a live parent where chat cannot
  bridge; the handover is terminal and ends the outgoing agent. It records the
  objective, completed work, exact files and commits, decisions, verification,
  blockers, and next action. Worker-to-Lead and Lead-to-Orchestrator handovers
  return curated reports through chat and do not write this file.
- `research/` - stores conclusions and citations that must survive planning.
  Raw exploration transcripts are not retained.

## Completion Transaction

One Lead-owned transaction, never run while governance conflicts, pending user
decisions, or acceptance gaps remain. A commit or push requires every unit it
contains to be `accepted` with no open blocker, acceptance gap, or unresolved
serious review finding; fix-forward covers defects discovered after an honest
acceptance, never known defects carried past a commit. Workers return `review-ready`; a unit is
never fragmented into a separate commit-only Worker, mechanical staging within
a unit is ordinary delegable work, the Lead performs the commit itself, and
Workers never administer completion:

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

Project-level templates: `assets/principles.md` to `docs/principles.md`,
`assets/decisions.md` to `docs/decisions.md`, `assets/backlog.md` to
`docs/backlog.md`, and `assets/agent-process.md` to `docs/agent-process.md`.
