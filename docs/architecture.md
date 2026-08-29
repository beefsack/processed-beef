# Architecture

Processed Beef is a portable three-role delegation hierarchy. Runtime policy is
confined to three small role-local skills. Root [AGENTS.md](../AGENTS.md) is
maintainer process-record authority and is read by the Orchestrator when
present; it is not installed skill runtime policy. [docs/principles.md](principles.md)
contains strict, user-owned project-wide design boundaries, while
[docs/backlog.md](backlog.md) is the Orchestrator-owned concise prioritized list
with one linked priority/dependency line per pending or active meaningful change,
[docs/decisions.md](decisions.md) contains concise active decisions. These three
files are the canonical records. Supporting records are [changes/](changes/) for
active meaningful-change state and [learnings.md](learnings.md) for separate
maintainer-only historical evidence. A separate product `VISION.md`, when
present, is goal input only.

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

Leads and Workers are short-lived disposable contexts. One Lead is retained
through one coherent change for L004 economics; a real ownership boundary starts
a fresh Lead, and each bounded unit starts a fresh Worker with a terminal result.
Completed agents are never resumed. An unfinished subagent is resumed only
exceptionally when an immediate answer clearly unblocks the same narrow
objective and continuation is demonstrably cheaper and safe while its context
remains useful; otherwise a fresh agent is spawned.

## Cost And Context

The hierarchy separates expensive judgment from implementation volume:

- the frontier Orchestrator shares product and engineering leadership with the
  user while retaining only project-level priorities and decisions;
- one Lead amortizes change-domain knowledge across fresh, cheap Workers and
  independently inspects their work;
- each Worker receives one coherent bounded unit;
- large or unknown output is delegated before an expensive role loads it;
- briefs and reports pass facts, decisions, and evidence, not raw transcripts.

Hard token ceilings and fixed tool-call proxies are neither portable nor
reliably observable. No fixed token/tool ceilings or rotation counters are
required. A Lead hands over only at a real ownership boundary; host telemetry or
the next coherent objective may reveal that boundary, but context pressure
alone does not rotate Lead ownership. Useful returned work stays reviewable even
if a host threshold was crossed; redispatching it repeats cost.

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

Trivial requests use the request directly and need no note. For each meaningful
change, the Lead owns
exactly one active `docs/changes/<slug>.md` combining a compact specification
(goal, scope/non-goals, and acceptance) with the current plan (approach, bounded
units/dependencies, and verification). Update it only for meaningful intent,
material decision, plan, blocker, accepted evidence, or outcome changes. At
completion, verify acceptance, promote durable decisions, add concise
outcome/evidence, archive the note, and advance or remove the backlog line. No
approval gate, log, state or recovery file, routine progress record, retry
ledger, tick, or completion transaction is required. Git, repository status,
current evidence, and the latest lean terminal handover are recovery truth.
Nonzero semantic failed approaches and use of the one causal repair cross both
the handover and active change note, when one exists, so succession cannot reset
them. Workers never maintain project records.

## Concurrency

One subagent at a time is the default because subscription quotas can be
exhausted unpredictably and concurrent loss is expensive. It is not an
artificial prohibition: the user may choose concurrency when quota behavior is
understood and work, recovery, and integration are isolated.

Full operation requires depth-two nesting. If unavailable, the Orchestrator
reports the material quality or cost consequence and uses the shallowest safe
topology. A host limitation alone does not block unrelated safe work.

## Documents

- [docs/principles.md](principles.md) - strict project-wide design boundaries.
- [docs/backlog.md](backlog.md) - Orchestrator-owned prioritized meaningful work.
- [AGENTS.md](../AGENTS.md) - maintainer process-record authority.
- [docs/decisions.md](decisions.md) - concise active decisions.
- [changes/](changes/) - active meaningful-change state; archives are under
  `changes/archive/`.
- [learnings.md](learnings.md) - observed failures, contributing mechanisms,
  changes, and supersession history for maintainers.
- [framework-comparison.md](framework-comparison.md) - retained external
  research and design precedents.
- `docs/integrations/` - host-specific model, nesting, and permission setup.
