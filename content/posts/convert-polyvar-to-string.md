---
title: How to convert a polymorphic variable to a string?
date: 2021-05-06 11:55:07
---

We can use the coercion operator `:>`.

```res
type color = [#red | #green | #blue]

// Coerce the polyvar to a string
let toString = (color: color): string => (color :> string)

let red: string = toString(#red)
```
