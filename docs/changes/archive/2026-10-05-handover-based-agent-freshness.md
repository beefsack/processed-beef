# Handover-Based Agent Freshness

- **Goal:** Reduce excessive agent reuse, cost, and context rot while preserving
  useful continuation and lean runtime guidance.
- **Scope:** User-approved reuse replacements in the three skills, principles,
  active decisions, and contradictory current docs;
  L019, one behavioral scenario, and one Unreleased entry. No unrelated edits.
- **Acceptance:** Resume unknowns, direction, corrections, and small follow-ups
  within existing work; prefer fresh agents briefed from handovers for new items
  or units. Assume substantial completed work leaves little capacity. Preserve
  handover discoveries and source locations. Guidance stays soft, with no new
  counts, gates, or tracking.
- **Plan:** Replace the specified runtime lines and conflicting summaries
  directly, record the observed incident, then inspect the complete diff and
  archive this note with accepted evidence. No delegated units or dependencies.
- **Verification:** Run `sh tests/validate.sh` and `git diff --check`; compare
  per-skill bytes against 3,732 / 6,360 / 3,434 (13,526 total). Behavioral GREEN
  remains pending observation. Leave the working tree for user review.
- **Outcome:** Applied the exact reuse replacements and narrowed Worker
  resumption to follow-ups. Aligned contradictory current summaries, preserved
  L018 history, and added L019 and Scenario 37. `VISION.md` has no contradiction.
  Runtime is 3,725 / 6,357 / 3,426 bytes (13,508 total), down 18 bytes (0.13%),
  with the same sections and bullets.
- **Evidence:** Structural validation and whitespace checks pass; diff inspection
  confirms soft freshness preferences, current-work continuation, handover-based
  briefs, and no new runtime machinery. Behavioral effectiveness is unmeasured.
  User-supplied host session records show substantially greater cumulative usage
  for the reused Lead across three assignments than for a fresh Lead's first
  assignment. Exact project and usage details are omitted. These figures were
  recorded by the host and not visible to the parent agent. Relative usage growth
  is reported; context rot remains unmeasured.
- **Next action:** User reviews the working tree before landing. The backlog is
  empty; no line needs advancement or removal. No commit or push was made.
