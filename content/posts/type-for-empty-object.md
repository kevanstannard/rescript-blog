---
title: Type for an empty object
date: 2022-02-26 11:32:40
---

```
ReScript version: rescript@9.1.4
```

The type for an empty object is `{.}`.

This can be created using `Js.Obj.empty()`

Example:

```res
let f: {.} => {..} = o => {
  Js.Obj.assign(o, {"x": 0})
}

let a = f(Js.Obj.empty()) // OK
let b = f({"y": 0}) // Error
```

However if we change `{.}` to `{..}`:

```res
let f: {..} => {..} = o => {
  Js.Obj.assign(o, {"x": 0})
}

let a = f(Js.Obj.empty()) // OK
let b = f({"y": 0}) // OK
```
