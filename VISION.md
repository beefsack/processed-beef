# Vision

Processed Beef exists to deliver high-quality software through a cost- and
context-efficient delegation hierarchy that stays out of the work's way.

## Outcomes

- A frontier-model Orchestrator can remain useful for a full working day while
  keeping its context small. It shares product-owner and head-of-engineering
  work with the user; the user has final authority over material decisions.
- Leads and Workers receive bounded sessions sized to complete coherent work
  without carrying unrelated history. The Orchestrator delegates to a cheaper
  Lead, which delegates execution to the cheapest capable Worker when the host
  supports model routing.
- Process overhead remains smaller than the work it supports. Documentation,
  review, handovers, and escalation are added only when their expected value
  exceeds their cost.
- Work proceeds by default. Agents pause only for material product ambiguity,
  significant risk, irreversible action, an external blocker, or repeated
  evidence that the current approach is wrong.
- Delivered work is correct, simple, maintainable, verified with current
  evidence, and aligned with the user's actual goal.

## Design Rules

1. Protect Orchestrator context by passing decisions, outcomes, risks, and
   evidence summaries upward, not implementation corpora or transcripts.
2. Delegate concrete work downward before an expensive role loads its corpus;
   avoid having two roles read the same material.
3. Prefer the smallest process that can safely produce and verify the result.
4. Treat the user's request as authority for ordinary execution. Ask rather
   than act only when the decision is materially theirs.
5. Recover mechanical failures locally. Stop semantic loops when another try
   lacks new evidence, a changed hypothesis, or a changed approach.
6. Add a process rule only for an observed failure, record the learning, and
   choose the least costly control that addresses it.
7. Remove or simplify a rule when its overhead exceeds its demonstrated value,
   while retaining the incident and rationale in `docs/learnings.md`.

When rules conflict, optimize in this order: user intent and safety,
correctness and quality, action, context efficiency, and process uniformity.
