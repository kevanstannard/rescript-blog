---
title: How to create a JavaScript object in ReasonML
author: kevan-stannard
date: 2019-12-21 09:00
template: article.pug
---

<span class="more"></span>

## Bucklescript < 7

```reasonml
[@bs.deriving abstract]
type payload = {
  name: string,
  age: int
};
let obj: payload = payload(~name="John", ~age=30);
```

## Bucklescript ≥ v7

From [the docs][1]:

> In BuckleScript, records are directly compiled into JS objects with the same shape (same attribute names).

```reasonml
type payload = {
  name: string,
  age: int
};
let obj: payload = {name: "John", age: 30};
```

[1]: https://bucklescript.github.io/docs/en/object
