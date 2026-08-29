# Project Maintainer And Change Notes

**Status:** Implemented 2026-08-29

## Outcome And Acceptance

Make maintainer-only learning records and lightweight long-running change notes
explicit outside installed skills. Acceptance requires the canonical records,
consistent public documentation, role-local skill guidance, structural
validation for the required files and three skill paths, and a concise VISION
principle stating that long-running continuity and alignment depend on concise
principles, useful durable decisions, and active plans being recorded and
actually followed and held to, with records retained only when their continuity
and alignment value exceeds their documentation and process overhead.

## Scope And Material Decisions

- Add root `AGENTS.md` as maintainer process-record authority, not installed
  skill runtime policy.
- Keep `VISION.md`, `docs/decisions.md`, active `docs/changes/`, archived notes,
  and `docs/learnings.md` in distinct roles.
- Keep learning maintenance out of installed-skill end-user requirements.
- Use one note only for substantial, long-running, risky, interrupted, or
  multi-unit work; small work needs no note.
- There is no separate spec, plan, or log requirement.
- Do not alter existing archives.

## Current Plan And Units

- [x] Define the canonical maintainer/runtime record split.
- [x] Add the active decision, change, and learning records.
- [x] Align project documentation and installed role guidance.
- [x] Add structural repository checks without wording checks.
- [x] Review the final diff and archive this note after acceptance.
- [x] Address the review finding by adding the required continuity and
  alignment record principle to `VISION.md`; final checks pass.

## Evidence

Final evidence: `sh tests/validate.sh`: pass (exit 0); `git diff --check`: pass
(exit 0). The structural gate confirmed the four required records and exactly
three tracked skill paths; all three skills remained below their line and byte
ceilings.

## Risk And Next Action

Risk: future maintainers could reintroduce historical process into runtime
skills. Next action: amend L014 if a concrete regression appears.
