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
    handover.md  # only for a planned context transfer
    research/    # only for durable decision evidence
```

`backlog.md` is created only when more than one change is pending or active.
Each item is one physical line linking to its change directory; it never
duplicates plan tasks.

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
commands or observations, progress, pending user decisions, acceptance-criterion
evidence, residual risks, and final outcome. The Lead may propose plan changes
within the approved spec, principles, and decisions; the Orchestrator must
approve every edit before it is made.

## log.md

Template: `assets/log.md`.

Append-only checkpoint log for crash recovery. Append after a meaningful
checkpoint: a completed work unit, verified partial result, consequential
discovery, blocker, commit, or approved plan change. Each entry records
timestamp, role and work unit, result, changed files or commit, verification,
and any discovery, blocker, or required decision. No tool-by-tool narration,
copied output, speculation, or information obvious from the diff.

## Conditional Artifacts

- `state.md` - template `assets/state.md`; added when the change needs successive
  Leads; records current
  major unit, completed units, blockers, and next dispatch.
- `handover.md` - template `assets/handover.md`; written before a deliberate
  context transfer; records the
  objective, completed work, exact files and commits, decisions, verification,
  blockers, and next action.
- `research/` - stores conclusions and citations that must survive planning.
  Raw exploration transcripts are not retained.

## Completion Transaction

One delegated Worker transaction, never run while governance conflicts, pending
user decisions, or acceptance gaps remain:

1. Lead produces the acceptance-evidence map and residual-risk summary.
2. Orchestrator approves alignment or returns concrete gaps.
3. User approves the result unless autonomous mode delegated result approval.
4. Worker promotes approved lasting documentation and governance edits.
5. Worker removes transient log, state, handover, and low-value research.
6. Worker moves the change to `docs/changes/archive/YYYY-MM-DD-<change>/`.
7. The same Worker removes the linked one-line backlog entry.
8. Worker verifies links and repository status and reports evidence.

The archive retains `spec.md`, `plan.md`, and only research with lasting
standalone value.

Project-level templates: `assets/principles.md`, `assets/decisions.md`,
`assets/backlog.md`, and `assets/agent-process.md`.
