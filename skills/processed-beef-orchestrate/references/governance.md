# Governance Reference

## Approval Matrix

| Change | Proposer | Approval | Editor |
|---|---|---|---|
| Plan adjustment within approved constraints | Lead | Orchestrator | Lead |
| Obvious spec correction with one clear, simple, non-contentious answer | Lead | Orchestrator | Lead |
| Ambiguous, consequential, or contentious spec change | Lead | User through Orchestrator | Lead after approval |
| `principles.md` or `decisions.md` change | Orchestrator discusses with user | User only | Delegated subagent after approval |

A clear specification correction cannot alter scope, externally visible
behavior, architecture, security posture, data semantics, cost profile, or an
acceptance criterion. Reasonable disagreement means the correction is not clear
and requires the user.

The Orchestrator must approve every `spec.md` and `plan.md` creation and edit
before it happens, including during autonomous mode for plan adjustments and
clear spec corrections. The user owns principles, decisions, and the initial
specification approval gate.

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
