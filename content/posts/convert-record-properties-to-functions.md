---
title: Convert Record properties into accessor functions
date: 2021-08-12 08:26:11
---

```
ReScript version: rescript@9.1.4
```

ReScript provides a decorator `@deriving(accessors)` that generators record property accessor functions.

Example:

```res
@deriving(accessors)
type monster = {
  name: string,
  isFriendly: bool,
}

let monster = {
  name: "Harry",
  isFriendly: true,
}

Js.log(name(monster))
Js.log(isFriendly(monster))

Js.log(monster->name)
Js.log(monster->isFriendly)
```
