# Vision And Lean Runtime

## Outcome

Make the project's vision explicit, preserve process learnings independently of
runtime instructions, and reduce Processed Beef to the smallest role hierarchy
that retains incident-derived quality and safety controls.

## Acceptance Conditions

- The repository has one canonical vision covering long parent sessions,
  bounded subagents, progressive model cost, user authority, action bias,
  minimal overhead, and quality.
- Every historical process change can be traced through a durable learning entry
  containing the observed problem, contributing mechanism, change and rationale,
  and supersession status.
- The runtime has one skill per role and no universal reference or template
  payload.
- Ordinary work has no mandatory process artifact or approval gate.
- Lead inspection, current evidence, risk-triggered review, destructive
  authority, context discipline, and semantic-loop stops survive simplification.
- Structural validation and plugin packaging pass.

## Observed Problem

At `bcc1553`, a normal Standard parent/Lead path could load 1,047 lines and
60,569 bytes before project context. Each Worker loaded another 160 lines and
10,554 bytes. The installed skill tree contained 1,582 lines and 88,003 bytes
across three skills, four references, and nine templates. Mandatory approvals,
three change artifacts, packet checks, seven report statuses, and detailed retry
ledgers could make process work larger than product work.

## Contributing Mechanism

Each real incident added a universal runtime safeguard, often repeated in
skills, references, templates, public docs, tests, and archives. Historical
rationale and current instruction had no strong separation, so deleting prompt
machinery risked deleting the learning that justified it.

## Change And Rationale

- Add `VISION.md` as the design authority.
- Add `docs/learnings.md` with stable IDs and explicit supersession.
- Make `processed-beef`, `processed-beef-orchestrate`, and
  `processed-beef-work-unit` exclusively Orchestrator, Lead, and Worker skills.
- Remove runtime references and templates.
- Replace mandatory artifacts with one conditional change note.
- Replace universal approval gates with escalation only for material user-owned
  decisions.
- Replace fixed context proxies and retry ledgers with bounded assignments,
  deliberate handover, and an outcome-based two-approach stop.
- Keep the smallest controls that directly address recorded unsafe deletion,
  role confusion, stale evidence, unreviewed cheap-model output, semantic loops,
  and false mechanical blockages.

The separation allows detailed history to remain durable without charging every
session for it.

## Evidence

- Installed runtime: 219 lines and 11,604 bytes, down from 1,582 lines and
  88,003 bytes (86.2 percent fewer lines and 86.8 percent fewer bytes).
- Parent/Lead runtime: 8,238 bytes, down from a 60,569-byte Standard path (86.4
  percent reduction).
- Worker runtime: 3,366 bytes, down from 10,554 bytes (68.1 percent reduction).
- `sh tests/validate.sh`
- `git diff --check`

## Status

Implemented 2026-08-29 as learning L013. Runtime-size and structural outcomes
are observed. Behavioral effectiveness remains under observation; any regression
must amend L013 and link a superseding learning rather than silently restoring
the old machinery.
