# Principles

Processed Beef exists to deliver high-quality software through a cost- and
context-efficient delegation hierarchy that stays out of the work's way.

These are strict, project-wide design boundaries owned by the user. Plans,
designs, decisions, and work are driven and constrained by them. Agents may
propose principles, but may not create or change them without the user's
explicit approval.

## Outcomes

- A frontier-model Orchestrator can remain useful for a full working day while
  keeping its context small. It shares product-owner and head-of-engineering
  work with the user; the user has final authority over material decisions.
- Leads and Workers receive bounded sessions sized to complete coherent work
  without carrying unrelated history. The Orchestrator delegates to a cheaper
  Lead, which delegates execution to the cheapest capable Worker when the host
  supports model routing.
- Leads and Workers are short-lived disposable contexts. Retain one Lead through
  one coherent change for L004 economics, use a fresh Lead at real ownership
  boundaries, and use a fresh Worker for each bounded unit, with a terminal
  result. Never resume a completed agent. Resume an unfinished subagent only
  exceptionally, when an immediate answer clearly unblocks the same narrow
  objective and continuation is demonstrably cheaper and safe while its context
  remains useful; otherwise spawn fresh.
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
8. Retain only records that improve alignment or continuity: the Orchestrator
   maintains a concise prioritized backlog; the Lead maintains one compact
   specification and current plan for a meaningful change; accepted completion
   keeps concise outcome and evidence before archival. The user request is
   enough for trivial work. Do not require approval gates, logs, state or
   recovery files, routine progress records, retry ledgers, ticks, or elaborate
   completion transactions.
9. Every role final response is a lean terminal handover containing only
   successor-relevant attempts or failures, discoveries, decisions, gotchas or
   risks, evidence, and an exact next action. Use `none` when no action remains.
   Do not require routine changed-path/outcome recaps, transcripts, repeated
   briefs, schemas, lifecycle/status machines, fixed token/tool ceilings,
   counters, or ledgers. Nonzero semantic failed approaches and use of the one
   causal repair must cross the handover and the active change note, when one
   exists.

When rules conflict, optimize in this order: user intent and safety,
correctness and quality, action, context efficiency, and process uniformity.
