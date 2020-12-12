---
title: How to access global modules and values in ReScript?
date: 2020-12-13 05:55:24
---

```
ReScript version: bs-platform@8.4.2
```

Use the `@bs.scope()` annotation.

## Simple global module value

```re
@bs.val @bs.scope("Math") external random : unit => float = "random";
let someNumber = random();
```

Which generates:

```js
var someNumber = Math.random();
```

## Nested global module value

```re
@bs.val @bs.scope(("window", "location", "ancestorOrigins"))
external length: int = "length"

Js.log(length)
```

Generates:

```js
console.log(window.location.ancestorOrigins.length);
```
