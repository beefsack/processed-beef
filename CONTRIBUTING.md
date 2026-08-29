# Contributing

## Validation

Run the release gate from anywhere in the repository:

```sh
sh tests/validate.sh
```

The same gate runs in CI on every push and pull request. It checks structure,
portability, payload ceilings, links, and plugin packaging. It never requires
literal policy phrases: wording checks cannot prove behavior and make later
simplification unsafe.

## Project Records

Root [AGENTS.md](AGENTS.md) is the maintainer process-record authority. It is
not installed skill runtime policy. The canonical records are
[docs/principles.md](docs/principles.md) for strict, user-owned project-wide design
boundaries, [docs/backlog.md](docs/backlog.md) for the Orchestrator's concise prioritized
list with one linked priority/dependency line per pending or active meaningful
change, and [docs/decisions.md](docs/decisions.md) for concise active decisions.
Supporting records are [docs/changes/](docs/changes/) for one Lead-owned active
note per meaningful change and [docs/learnings.md](docs/learnings.md) for separate
maintainer-only historical evidence. Workers never maintain project records.
Installed-skill users are not required to maintain the learning record.

Keep process proportionate: trivial requests use the request directly and need
no note. For a
meaningful change, its one note combines goal, scope/non-goals, acceptance,
approach, bounded units/dependencies, and verification. Update it only for
meaningful intent, material decisions, plan, blockers, accepted evidence, or
outcome changes. On completion, verify acceptance, promote authorized durable decisions,
add concise outcome/evidence, archive the note, and advance or remove the
backlog line. Do not create approval gates, logs, state or recovery files,
routine progress records, retry ledgers, ticks, or completion transactions.

## Behavioral Evidence

`tests/behavioral.md` is a historical pressure record, not an executable claim
that current wording guarantees behavior. Add a scenario only after a concrete
failure is observed. Record the failing behavior, the guidance under test, and
the observed result or an explicit pending status. Never invent fixtures to
justify a preferred process mechanism.

## Size And Portability

- Each `SKILL.md` stays under 120 lines and 12000 bytes; all installed skill
  content stays under 24000 bytes. These are ceilings, not size targets.
- Frontmatter contains exactly `name` and `description`; `name` matches the
  skill directory.
- Skills contain no host-specific paths, configuration keys, or runtime code.
  Those belong in `docs/integrations/`.
- All tracked Markdown is ASCII only.
- Relative links from a `SKILL.md` resolve inside its own skill directory.
- Do not add runtime references or templates unless a measured failure cannot be
  solved inside the role-local skill at lower total context cost.

## Naming

The project is pre-release and role agent names are configuration interfaces. Do
not add compatibility aliases before a release requires them.
