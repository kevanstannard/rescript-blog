const browserSync = require("browser-sync");
const yargs = require("yargs");

const argv = yargs.argv;

const dir = argv._[0];

if (!dir) {
  console.log("Usage: serve <dir>");
  return;
}

const options = {
  server: dir,
  watch: true,
  open: false,
  notify: false,
};

const server = browserSync.create("rescript-blog");

server.init(options);
