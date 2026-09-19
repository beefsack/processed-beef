# Context-Aware Delegation Runtime

- **Goal:** Align runtime skills with the approved context-aware delegation
  policy while reducing redundant instructions.
- **Scope:** Three role skills, current explanatory documentation, and L018.
  Preserve role boundaries, verification, independent review, and failure history.
- **Acceptance:** Reuse completed or unfinished agents when context fits and
  capacity permits; use fresh contexts when appropriate. Both parent tiers pass
  useful starting knowledge and changes on resumption. Subagent returns include
  results and reusable discoveries with source locations for successor briefs.
  Assignments stay coherent without forcing session rotation. Replace existing
  prose rather than add machinery, arbitrary limits, templates, or tracking.
- **Plan:** Replace lifecycle and briefing clauses, remove conflicting current
  summaries, then review representative delegation cases and payload changes.
- **Verification:** Run `sh tests/validate.sh` and `git diff --check`; compare
  runtime payload against the starting 1,969 words / 13,722 bytes. Behavioral
  effectiveness requires later observation, not wording assertions.
- **Outcome:** All three skills and current explanatory documentation are
  aligned. Existing clauses were replaced, duplicated lifecycle/reporting prose
  removed, and L018 updated. Runtime is 1,947 words / 13,526 bytes with the same
  sections and bullets; no new process artifacts or thresholds are required.
- **Evidence:** Structural validation and whitespace checks pass. Manual policy
  review covers completed-agent reuse for related work, fresh contexts for
  exhausted or unrelated work, independent review, and replacement briefs using
  returned discoveries and source locations. Scope, current-evidence checks,
  and semantic failure continuity remain explicit.
