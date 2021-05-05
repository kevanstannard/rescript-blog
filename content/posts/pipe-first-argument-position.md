---
title: Pipe first argument position
date: 2021-01-07 11:48:48
---

The pipe first operator `->` inserts a value into the first argument of a function.

However, it's possible to change it's insert position using the underscore placeholder `_`.

For example:

```res
type item = {id: int, group: string, name: string}

let make = (id: int, name: string, group: string) => {id: id, name: name, group: group}

// Insert the value "One" into the middle argument
let p1 = "One"->make(1, _, "numbers")
```
