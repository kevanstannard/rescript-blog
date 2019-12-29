---
title: How to create a JavaScript object in ReasonML
date: 2019-12-30 06:53:14
---

## Hashmap object

These are JavaScript objects where the keys are always strings, but the values are of a different kind.

```re
let myMap: Js.Dict.t(int) = Js.Dict.empty();
Js.Dict.set(myMap, "Allison", 10);
```

## Object with named fields (Bucklescript ≥ v7)

From [the docs](https://bucklescript.github.io/docs/en/object):

> In BuckleScript, records are directly compiled into JS objects with the same shape (same attribute names).

```re
type payload = {
  name: string,
  age: int
};
let obj: payload = {name: "John", age: 30};
```

## Object with named fields (Bucklescript < 7)

```re
[@bs.deriving abstract]
type payload = {
  name: string,
  age: int
};
let obj: payload = payload(~name="John", ~age=30);
```
