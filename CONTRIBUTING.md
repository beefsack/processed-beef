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

## Vision And Learning Record

Every behavioral process change must:

1. State how it advances [VISION.md](VISION.md).
2. Add or amend a stable entry in [docs/learnings.md](docs/learnings.md) with the
   observed problem, contributing mechanism, change and rationale, and status.
3. Link any superseded rule to the newer learning instead of deleting history.
4. Prefer removing or narrowing policy over adding a universal mechanism.
5. Record a behavioral scenario only when a real pressure case was observed;
   do not create speculative wording contracts.

Runtime skills contain current instructions only. History, rationale, and
supersession live in the learning record and change archives.

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
