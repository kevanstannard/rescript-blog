---
title: How to define an argument for an external function that has a hard coded value?
date: 2021-07-17 06:13:29
---

```
ReScript version: rescript@9.1.4
```

```res
type t
@send external hi: (t, @as(json`true`) _, int) => unit = "hi"

let f = x => x->hi(2)
```

Which produces:

```js
function f(x) {
  x.hi(true, 2);
}
```
