import { join } from "node:path";
import nodePlop from "node-plop";
const runCLI = async () => {
  const { Plop, run } = await import("plop");
  Plop.prepare(
    {
      configPath: join(__dirname, "plopfile.js")
    },
    (env) => {
      const argv = process.argv.slice(2);
      Plop.execute(env, argv, (env2, argv2) => run(env2, argv2, true));
    }
  );
};
const generate = async (generatorName, options, { dir = process.cwd(), plopFile = "plopfile.js" } = {}) => {
  const plop = nodePlop(join(__dirname, plopFile), {
    destBasePath: join(dir, "src"),
    force: false
  });
  const generator = plop.getGenerator(generatorName);
  await generator.runActions(options, {
    onSuccess() {
    },
    onFailure() {
    },
    onComment() {
    }
  });
};
export {
  generate,
  runCLI
};
//# sourceMappingURL=index.mjs.map
