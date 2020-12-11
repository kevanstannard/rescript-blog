const copyfiles = require("copyfiles");
const { make } = require("../src/App.bs.js");

make()
  .then(() => {
    copyfiles(["./static/**/*", "./docs"], { verbose: true }, (error) => {
      if (error) {
        console.error(error);
      }
    });
  })
  .catch(console.error);
