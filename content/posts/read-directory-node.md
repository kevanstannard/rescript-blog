---
title: How to read a directory in ReasonML?
date: 2019-12-26 07:38:45
---

In JavaScript we would write something like this:

```js
const fs = require("fs");
const path = "./some-path";

function callback(error, items) {
  // Handle error or items
}

fs.readdir(path, callback);
```

TODO
