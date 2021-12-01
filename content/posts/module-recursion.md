---
title: How to implement module recursion in ReScript?
date: 2021-12-01 19:39:41
---

```
ReScript version: rescript@9.1.4
```

```res
module type X = {
  let x: unit => int
  let y: unit => int
}

module rec A: X = {
  let x = () => 1
  let y = () => B.y() + 1
}
and B: X = {
  let x = () => A.x() + 2
  let y = () => 2
}
```
