---
title: How to open and destructure a module?
date: 2021-07-21 21:27:45
---

```
ReScript version: rescript@9.1.3
```

You can use the `let { something } = module(MyModule)` syntax.

For example:

```res
module MathX = {
  let p2 = x => x * x
  let p3 = x => p2(x) * x
  let p4 = x => p3(x) * x
}

let {p2, p3, p4} = module(MathX)
```
