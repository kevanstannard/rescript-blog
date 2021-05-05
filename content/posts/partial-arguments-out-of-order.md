---
title: Partially applying function arguments out of order
date: 2020-12-12 14:33:14
---

```
ReScript version: bs-platform@8.4.2
```

Suppose you have the following function:

```res
let divide = (a, b) => a / b
```

We can partially apply the _second argument_ by specifying an `_` for the first argument.

```res
let half = divide(_, 2)

Js.log(half(10))
// 5
```
