---
title: Partially applying function arguments out of order
date: 2020-07-02 10:02:18
---

Suppose you have the following function:

```reasonml
let divide = (a, b) => a / b;
```

We can partially apply the _second argument_ but specifying an `_` for the first argument.

```reasonml
let half = divide(_, 2);

Js.log(half(10));
// 5
```
