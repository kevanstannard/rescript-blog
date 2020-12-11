---
title: How to access global functions in ReScript?
date: 2020-12-12 06:19:47
---

```
ReScript version: bs-platform@8.4.2
```

Use the `@bs.val` annotation:

```re
@bs.val external setTimeout : (unit => unit, int) => float = "setTimeout";

let _ = setTimeout(() => {
  Js.log("Hello")
}, 2000)
```
