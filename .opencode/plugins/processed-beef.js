import path from "node:path";
import { fileURLToPath } from "node:url";

const dirname = path.dirname(fileURLToPath(import.meta.url));
const skillsDir = path.resolve(dirname, "../../skills");

export const ProcessedBeefPlugin = async () => ({
  config(config) {
    config.skills ??= {};
    config.skills.paths ??= [];

    if (!config.skills.paths.includes(skillsDir)) {
      config.skills.paths.push(skillsDir);
    }
  },
});
