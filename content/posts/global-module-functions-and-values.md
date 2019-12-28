---
title: How to access global modules and values in ReasonML?
date: 2019-12-29 06:57:19
---

These notes are an exploration of the examples from [the docs](https://bucklescript.github.io/docs/en/interop-cheatsheet#global-module).

Use the `[@bs.scope "YourModuleName"]` annotation.

## Simple global module value

```re
[@bs.val] [@bs.scope "Math"] external random : unit => float = "random";
let someNumber = random();
```

Which generates:

```
var someNumber = Math.random();
```

## Nested global module value

```re
[@bs.val] [@bs.scope ("window", "location", "ancestorOrigins")] external length : int = "length";
Js.log(length);
```

Generates:

```
console.log(window.location.ancestorOrigins.length);
```
