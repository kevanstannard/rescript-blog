---
title: Simple example of a polymorphic object in ReasonML
date: 2020-12-12 14:35:00
---

```
ReScript version: bs-platform@8.4.2
```

The `..` notation declares an open object type:

```re
let logName = (o: {.."name": string}) => Js.log(o["name"])
let a = {"name": "Hello", "age": 20}
let b = {"name": "Cybertruck", "make": "Tesla"}
logName(a)
logName(b)
```
