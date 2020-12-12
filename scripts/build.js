const yargs = require("yargs");
const copyfiles = require("copyfiles");

const argv = yargs.argv;

const outputDir = argv._[0];

if (!outputDir) {
  console.log("Usage: build <output-dir>");
  return;
}

const { make } = require("../src/App.bs.js");

make()
  .then(() => {
    copyfiles(["./static/**/*", outputDir], (error) => {
      if (error) {
        console.error(error);
      }
    });
  })
  .catch(console.error);
