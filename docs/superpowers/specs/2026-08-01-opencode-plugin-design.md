# OpenCode Plugin Packaging Design

## Goal

Allow OpenCode users to install Processed Beef directly from GitHub with this
plugin spec:

```json
{
  "plugin": [
    "processed-beef@git+https://github.com/beefsack/processed-beef.git"
  ]
}
```

The plugin makes the repository's existing skills discoverable. It does not
activate the workflow automatically or replace the explicit role-agent and
nested-delegation configuration documented for OpenCode.

## Packaging

Add a root `package.json` identifying `processed-beef` as an ECMAScript module
package. Its `main` field points to `.opencode/plugins/processed-beef.js`,
matching the established Superpowers Git-plugin packaging pattern. The package
has no runtime dependencies and requires no build or installation scripts.

Using `main` rather than an `exports["./server"]` entry keeps the package small
and aligned with the known working reference implementation. The explicit
`processed-beef@` prefix in the OpenCode plugin spec provides stable package
identity and caching.

## Plugin Behavior

The plugin entrypoint exports an async OpenCode plugin function. It resolves
the repository's `skills/` directory from `import.meta.url`, so discovery is
independent of the user's current working directory and the package cache
location.

The returned `config` hook:

1. Initializes `config.skills` when absent.
2. Initializes `config.skills.paths` when absent.
3. Appends the absolute bundled skills path unless it is already present.

The hook preserves all existing skill paths and remains idempotent when called
more than once.

## Scope Boundaries

The plugin does not:

- inject bootstrap text into conversations;
- activate `processed-beef` for every session;
- define Orchestrator, Lead, or Worker agents;
- set `subagent_depth` or permissions;
- change any portable skill content.

Users continue to opt into workflow activation and role configuration as
described in `docs/integrations/opencode.md`.

## Validation

Add a dependency-free Node.js test that imports the package entrypoint and
executes its plugin function. The test verifies:

- an empty configuration gains the bundled skills path;
- an existing skills path is preserved;
- repeated hook execution does not duplicate the bundled path.

Run this test from `tests/validate.sh` so local validation and CI enforce the
plugin contract alongside existing skill portability checks.

## Documentation

Update the README installation section with the Git-backed OpenCode plugin
configuration. Update the OpenCode integration guide to explain that plugin
installation exposes the skills but leaves role agents and nested delegation
as explicit configuration. Both locations state that OpenCode must be
restarted after changing plugin configuration.
