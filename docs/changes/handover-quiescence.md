# Proposal: quiesce session-bound work before handover

Status: proposal (user 2026-11-16). Items 1-2 applied as skill guidance (L025); item 3 (host tool support) not yet actioned.

## Problem

Recent sessions handed over while they still owned live, session-bound work:

- A Lead handed over with a background `watch` armed. The watcher could only wake the locked session, yet still held the entity's single watcher slot; the parent had to kill it by pid before the successor could re-arm.
- A child session locked after writing its handover but still showed as `running` to its parent, which needed user notice and a manual kill.
- By contrast, handovers while durable external work was in flight (a work-bucket task executed by another entity) went fine: the successor rebuilt state from the task and event files.

## Proposal

1. **Drain or stop session-bound work before handover**
   - Stop background shells and watchers the session started.
   - For running subagents whose results return to this session: wait for them to reach idle at a safe point, or stop them and carry their reported state into the handover; children stay bound to the session that started them, so a successor briefs fresh ones rather than adopting them.
2. **Do not block on durable external work**
   - Work owned by other entities and recoverable from durable state (for example bucket tasks) may continue.
   - The handover lists it with ids and cursors (latest event seen, claim round) so the successor can re-arm.
3. **Tool support**
   - The handover tool refuses, or warns, while the session has running children or background processes.
   - The handover text must list any detached in-flight work.

## Rejected

- A strict "no outstanding tasks" rule: a long-running external task would leave an exhausted session unable to hand over, which is worse than handing the task across with its cursors.
