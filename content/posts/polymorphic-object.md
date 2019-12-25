---
title: Simple example of a polymorphic object in ReasonML
date: 2019-12-21
---

The `..` notation declares an open object type:

```reasonml
let logName = (o: {.. "name": string}) => Js.log(o##name);
let a = {"name": "Hello", "age": 20};
let b = {"name": "Cybertruck", "make": "Tesla"};
logName(a);
logName(b);
```
