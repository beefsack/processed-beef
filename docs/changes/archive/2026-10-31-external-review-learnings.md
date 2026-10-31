# External Review Learnings

## Specification

- Goal: address reported delegation, review, and record-maintenance concerns
  with minimal guidance changes and no new gates.
- Scope: failure recovery, recommendation ownership, concise current records,
  session-scoped instructions, and corresponding learning and behavioral records.
- Acceptance: refused work is not absorbed; recommendations use appropriately
  verified evidence; current records stay focused; structural validation passes.

## Evidence And Decisions

- Source: an external review proposal and user-reported experience. Specific
  source reports were not independently verified; the delegation incident is
  explicitly user-reported and its exact details are unavailable.

## Plan

1. Apply bounded guidance and record changes, preserving evidence provenance.
2. Validate the relevant repository checks, then archive this note.

## Outcome And Accepted Evidence

- Guidance and corresponding learning and behavioral records were updated;
  worker policy and principles were unchanged. Effectiveness remains pending
  observation.
- Project-specific evidence was generalized while preserving the lessons and
  verification provenance. `sh tests/validate.sh` and `git diff --check` passed
  after redaction.
- No commit or push was made.

## Evidence Provenance

Reported review findings and measurements were not independently inspected or
repeated. The delegation incident is user-reported; exact details are
unavailable and unverified. Learning entries L020-L023 and Scenarios 38-40
preserve those distinctions. Behavioral effectiveness remains pending
observation and is not inferred from structural validation.
