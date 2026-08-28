# Governance Reference

## Approval Matrix

| Change | Proposer | Approval | Editor |
|---|---|---|---|
| Plan record-keeping: progress, evidence map, attempt counters, residual risks, final outcome | Lead | none; reported in the Lead's normal return | Lead |
| Mechanical plan reconciliation that preserves approved behavior, scope, safety, dependencies, and acceptance semantics | Lead | none; reported with the affected gate or record | Lead |
| Plan semantic adjustment within approved constraints: approach, work units, dependencies, scope, verification | Lead | Orchestrator | Lead |
| Obvious spec correction with one clear, simple, non-contentious answer | Lead | Orchestrator | Lead |
| Ambiguous, consequential, or contentious spec change | Lead | User through Orchestrator | Lead after approval |
| `docs/principles.md` or `docs/decisions.md` change | Orchestrator discusses with user | User only | Delegated subagent after approval |

A clear specification correction cannot alter scope, externally visible
behavior, architecture, security posture, data semantics, cost profile, or an
acceptance criterion. Reasonable disagreement means the correction is not clear
and requires the user.

The Orchestrator approves the creation of `spec.md` and `plan.md`, every
`spec.md` edit, and every edit to a plan's semantic sections before it happens,
including during autonomous mode. It does not approve mechanical plan
reconciliation or plan record-keeping: those preserve or record already approved
meaning, so approving them protects nothing
and routes bookkeeping through the most expensive tier. The Lead edits them
directly and reports them in its normal return. The user owns principles,
decisions, and the initial specification approval gate.

## Correction Authority

- A `review-ready` Worker result is a review input, not acceptance. It is
  accepted or rejected only by Lead inspection of the actual diff and evidence;
  the Worker's report never completes or accepts itself.
- The same Worker receives exactly one correction round, and only when semantic
  scope and context are unchanged. A correction that changes semantic scope
  requires a fresh Worker after approval.
- Terminal handovers and terminal accepted completion remain terminal.
- Unresolved serious review findings escalate rather than starting an
  open-ended correction loop.
- Status handling, including unsuccessful host attempts: `scheduling.md`.

## User-Owned Governance

No agent implements work that contradicts an active decision. Superseded
decisions remain recoverable through Git and archived change specifications
rather than accumulating in the active file.

## Autonomous Mode

Autonomous mode delegates plan approval and clear specification corrections to
the Orchestrator, and the Orchestrator approves the initial specification when
the user explicitly waived specification approval. It never delegates governance
changes or permission to contradict active governance.

A parked governance conflict is raised when autonomous mode ends, the user asks,
no unblocked work remains, or the session is otherwise ending. If it blocks all
remaining work, autonomous execution stops without changing governance or
implementing the contradiction.

## Escalation

The Lead escalates to the Orchestrator, and the Orchestrator to the user,
product and governance decisions, consequential technical decisions, and any
change that is ambiguous, contentious, or outside approved constraints.
Escalation tracks decision blast radius: a Worker decides an obvious choice
tightly within its own scope; a choice inside the backlog item but outside that
scope returns to the Lead, which decides and resumes the same Worker; anything
outside the backlog item - another item, a project dependency such as
`package.json`, or a product-level principle - escalates to the Orchestrator,
which decides on user involvement before resuming the Lead. A Lead may also put
a complex or ambiguous technical question to the Orchestrator, framed
self-contained so it answers from expertise without loading the Lead's corpus.

Lead reports cite the relevant governing clauses and the decision needed; for a
consequential ruling the Orchestrator may directly read the narrowly cited
clause rather than an entire governance corpus.

Irreversible destruction outside version control always escalates to the
Orchestrator regardless of brief authorization; see `scheduling.md`.
