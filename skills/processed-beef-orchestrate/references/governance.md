# Governance Reference

## Approval Matrix

| Change | Proposer | Approval | Editor |
|---|---|---|---|
| Plan adjustment within approved constraints | Lead | Orchestrator | Lead |
| Obvious spec correction with one clear, simple, non-contentious answer | Lead | Orchestrator | Lead |
| Ambiguous, consequential, or contentious spec change | Lead | User through Orchestrator | Lead after approval |
| `docs/principles.md` or `docs/decisions.md` change | Orchestrator discusses with user | User only | Delegated subagent after approval |

A clear specification correction cannot alter scope, externally visible
behavior, architecture, security posture, data semantics, cost profile, or an
acceptance criterion. Reasonable disagreement means the correction is not clear
and requires the user.

The Orchestrator must approve every `spec.md` and `plan.md` creation and edit
before it happens, including during autonomous mode for plan adjustments and
clear spec corrections. The user owns principles, decisions, and the initial
specification approval gate.

## Correction Rules

- A `review-ready` Worker result is a review input, not acceptance. It is
  accepted or rejected only by Lead inspection of the actual diff and evidence;
  the Worker's report never completes or accepts itself.
- The same Worker receives exactly one correction round, and only when semantic
  scope and context are unchanged. A correction that changes semantic scope
  requires a fresh Worker after approval.
- `host-unknown`, missing, malformed, and cancelled attempts are unsuccessful,
  counted, non-resumable host attempts, never evidence. The Lead runs
  `host-unknown reconciliation`: reconcile the diff, Git, log, and evidence,
  then accept usable work, dispatch a fresh compressed recovery Worker, or
  abandon.
- Terminal handovers and terminal accepted completion remain terminal.
- Unresolved serious review findings escalate rather than starting an
  open-ended correction loop.

## User-Owned Governance

`docs/principles.md` and `docs/decisions.md` are user-controlled:

- Agents may identify reasons to amend them but may not edit them without
  explicit user approval.
- Only the Orchestrator discusses proposed changes with the user.
- After approval, the Orchestrator delegates the edit to a subagent.
- Autonomous mode never delegates this authority or permits work contradicting
  active governance.
- Agents must not implement work that contradicts an active decision.
- Superseded decisions remain recoverable through Git and archived change
  specifications rather than accumulating in the active file.

## Autonomous Mode

Autonomous mode delegates plan approval and clear specification corrections to
the Orchestrator, and the Orchestrator approves the initial specification when
the user explicitly waived specification approval. It never delegates
governance changes or permission to contradict active governance.

When autonomous work encounters a governance conflict:

1. record it in `plan.md` under Pending User Decisions;
2. park the affected work;
3. continue independent work;
4. raise it when autonomous mode ends, the user asks, no unblocked work
   remains, or the session is otherwise ending.

If the conflict blocks all remaining work, autonomous execution stops without
changing governance or implementing the contradiction.

## Escalation

The Lead escalates to the Orchestrator, and the Orchestrator to the user,
product and governance decisions, consequential technical decisions, and any
change that is ambiguous, contentious, or outside approved constraints.
Escalation tracks decision blast radius: a Worker decides an obvious choice
tightly within its own scope; a choice inside the backlog item but outside
that scope returns to the Lead, which decides and resumes the same Worker;
anything outside the backlog item - another item, a project dependency such
as `package.json`, or a product-level principle - escalates to the
Orchestrator, which decides on user involvement before resuming the Lead. A
Lead may also put a complex or ambiguous technical question to the
Orchestrator, framed self-contained so it answers from expertise without
loading the Lead's corpus.

Delegating research, implementation, review, or evidence gathering does not
delegate product or governance authority. Lead reports cite the relevant
governing clauses and decision needed; for a consequential ruling, the
Orchestrator may directly read the narrowly cited clause rather than an entire
governance corpus.

Irreversible destruction outside version control - untracked data, a
production system, or external state a Git revert cannot undo - always
escalates to the Orchestrator regardless of brief authorization, since it is
not recoverable the way tracked-file changes are; when the data is the user's,
the Orchestrator involves the user before deciding.
