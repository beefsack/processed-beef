# Architecture

Processed Beef is a portable three-role delegation hierarchy. Runtime policy is
confined to three small role-local skills. Root [AGENTS.md](../AGENTS.md) is
maintainer process-record authority and is read by the Orchestrator when
present; it is not installed skill runtime policy. [VISION.md](../VISION.md)
governs purpose and principles, while [learnings.md](learnings.md) preserves
separate maintainer-only historical evidence.

## Repository Canon

This repository is the canonical source for the process, skills, and
documentation. Environment and dotfiles repositories consume a pinned revision;
they do not maintain copied or generated skill implementations.

## Topology

| Role | Stable agent name | Skill | Intended model tier |
|---|---|---|---|
| Orchestrator | `processed-beef-orchestrator` | `processed-beef` | frontier |
| Lead | `processed-beef-lead` | `processed-beef-orchestrate` | cheaper capable model |
| Worker | `processed-beef-worker` | `processed-beef-work-unit` | cheapest capable model |

The top-level Orchestrator dispatches one Lead. The Lead dispatches Workers, and
Workers never delegate. Each installed skill describes exactly one role, which
prevents role identity from being inferred from a shared document.

The skills define responsibilities, delegation direction, authority, and review
behavior. Host configuration selects named agents, models, nesting depth, and
tool permissions. A skill cannot portably prove which model or selector the host
applied, so it reports material limitations without inventing enforcement.

## Cost And Context

The hierarchy separates expensive judgment from implementation volume:

- the frontier Orchestrator shares product and engineering leadership with the
  user while retaining only project-level priorities and decisions;
- one Lead amortizes change-domain knowledge across cheap Workers and
  independently inspects their work;
- each Worker receives one coherent bounded unit;
- large or unknown output is delegated before an expensive role loads it;
- briefs and reports pass facts, decisions, and evidence, not raw transcripts.

Hard token ceilings and fixed tool-call proxies are neither portable nor
reliably observable. A role hands over when host telemetry or the next coherent
objective shows it will not fit. The Orchestrator has no rotation count and is
designed to remain active for a working day. Useful returned work stays
reviewable even if a host threshold was crossed; redispatching it repeats cost.

## Authority And Action

The user's request authorizes ordinary work. The Orchestrator brings the user
only material product, governance, architecture, security, data, cost,
cross-project, or irreversible-state decisions. Leads decide ordinary technical
tradeoffs; Workers decide local implementation details from project conventions.
Mechanical recovery and process records never require senior approval.

This keeps the default path active while preserving user sovereignty where the
consequences belong to the user.

## Ownership And Evidence

One Lead owns a coherent change through implementation and verification. It
delegates concrete work before loading the same corpus, then treats Worker
reports as claims. Acceptance requires inspection of the actual diff, relevant
files, tracked and untracked state, and evidence produced after the latest
change.

Independent review is conditional on security, authorization, migration,
destructive or live behavior, public contracts, difficult rollback, broad subtle
changes, suspicious output, or repeated semantic failure. Routine work does not
receive a duplicate review pass.

Destructive work must be named in the brief. Irreversible external or
non-versioned destruction requires user authority. Commits and pushes require an
explicit request and cannot contain known acceptance gaps or serious findings.

## Recovery And Loops

Pre-effect tool, environment, command, path, and record failures are mechanical
and repaired locally. Source or behavior changes remain semantic work. A failed
semantic approach is repeated only with new evidence, a changed hypothesis, or a
changed approach. Two failed approaches to the same acceptance blocker trigger
preservation and escalation; changing agent, unit, or brief names does not reset
history.

One narrowly causal repair may restore test, fixture, harness, or evidence
plumbing broken by the immediately preceding correction. It cannot change
product behavior, ownership, routing, oracle, or acceptance semantics.

Small work needs no change note. For substantial, long-running, risky,
interrupted, or multi-unit work, a Lead keeps one lightweight file under
`docs/changes/` covering the goal, material decisions, current plan, and
accepted evidence. There is no separate spec, plan, or log requirement; update
the note only for meaningful state changes. Git, repository status, current
evidence, and the latest concise report are recovery truth.

## Concurrency

One subagent at a time is the default because subscription quotas can be
exhausted unpredictably and concurrent loss is expensive. It is not an
artificial prohibition: the user may choose concurrency when quota behavior is
understood and work, recovery, and integration are isolated.

Full operation requires depth-two nesting. If unavailable, the Orchestrator
reports the material quality or cost consequence and uses the shallowest safe
topology. A host limitation alone does not block unrelated safe work.

## Documents

- [VISION.md](../VISION.md) - desired outcomes and design rules.
- [AGENTS.md](../AGENTS.md) - maintainer process-record authority.
- [decisions.md](decisions.md) - active durable decisions.
- [changes/](changes/) - active substantial-change state; archives are under
  `changes/archive/`.
- [learnings.md](learnings.md) - observed failures, contributing mechanisms,
  changes, and supersession history for maintainers.
- [framework-comparison.md](framework-comparison.md) - retained external
  research and design precedents.
- `docs/integrations/` - host-specific model, nesting, and permission setup.
