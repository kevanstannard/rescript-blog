const superstatic = require("superstatic");
const connect = require("connect");

const port = 3000;
const app = connect().use(superstatic({ cwd: "./docs" }));

app.listen(port, function () {
  console.log("Dev server started on port " + port);
});
