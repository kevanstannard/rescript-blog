---
title: How to determine if a global value exists in ReasonML?
date: 2019-12-29 06:46:11
---

Use the `[%external your_identified_name]` annotation.

This returns an `option` value.

```reasonml
let devOpt = [%external __DEV__];
switch (devOpt) {
| Some(_) => Js.log("development mode")
| None => Js.log("production mode")
};
```

This generates:

```
var devOpt = typeof __DEV__ === "undefined" ? undefined : __DEV__;

if (devOpt !== undefined) {
  console.log("development mode");
} else {
  console.log("production mode");
}
```
