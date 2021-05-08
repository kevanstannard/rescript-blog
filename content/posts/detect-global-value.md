---
title: How to detect the existance of a global value?
date: 2021-05-09 09:22:10
---

```
ReScript version: rescript@9.1.2
```

We can use `%external` to detect global values.

For example:

```res
type audioContext

let audioContext: option<audioContext> = %external(\"AudioContext")
```

Which complies to:

```js
var Caml_option = require("rescript/lib/js/caml_option.js");

var audioContext =
  typeof AudioContext === "undefined" ? undefined : AudioContext;

var audioContext$1 =
  audioContext === undefined ? undefined : Caml_option.some(audioContext);
```

If the variable name starts with `_` then we don't need to escape it:

```res
switch %external(__DEV__) {
| Some(_) => Js.log("dev mode")
| None => Js.log("production mode")
}
```

Which compiles to:

```js
var match = typeof __DEV__ === "undefined" ? undefined : __DEV__;

if (match !== undefined) {
  console.log("dev mode");
} else {
  console.log("production mode");
}
```

## References

- [Special Global Values](https://rescript-lang.org/docs/manual/latest/bind-to-global-js-values#special-global-values)
