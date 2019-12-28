---
title: How to access global functions in ReasonML?
date: 2019-12-28 22:59:49
---

Use the `[@bs.val]` annotation:

```reasonml
[@bs.val] external setTimeout : (unit => unit, int) => float = "setTimeout";
```
