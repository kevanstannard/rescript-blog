---
title: How to determine if a global value exists in ReasonML?
date: 2020-12-12 06:35:06
---

```
ReScript version: bs-platform@8.4.2
```

Use the `%external(your_global)` annotation.

This returns an `option` value.

```re
let devOpt = %external(__DEV__)
switch devOpt {
| Some(_) => Js.log("development mode")
| None => Js.log("production mode")
}
```

This generates:

```js
var devOpt = typeof __DEV__ === "undefined" ? undefined : __DEV__;

if (devOpt !== undefined) {
  console.log("development mode");
} else {
  console.log("production mode");
}
```
