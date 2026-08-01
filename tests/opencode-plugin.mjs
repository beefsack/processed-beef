import assert from "node:assert/strict";
import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

import { ProcessedBeefPlugin } from "../.opencode/plugins/processed-beef.js";

const dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(dirname, "..");
const skillsDir = path.join(repoRoot, "skills");
const packageJson = JSON.parse(
  await fs.readFile(path.join(repoRoot, "package.json"), "utf8"),
);

assert.equal(packageJson.name, "processed-beef");
assert.equal(packageJson.type, "module");
assert.equal(packageJson.main, ".opencode/plugins/processed-beef.js");

const hooks = await ProcessedBeefPlugin();
const emptyConfig = {};
hooks.config(emptyConfig);
assert.deepEqual(emptyConfig.skills.paths, [skillsDir]);

const existingConfig = { skills: { paths: ["/existing/skills"] } };
hooks.config(existingConfig);
hooks.config(existingConfig);
assert.deepEqual(existingConfig.skills.paths, ["/existing/skills", skillsDir]);
