---
title: How to bind to an external component in ReScript?
date: 2021-12-17 19:09:53
---

```
ReScript version: rescript@9.1.4
```

Example binding to the `Navbar` component in the `react-bootstrap` library.

```res
@module("react-bootstrap") @react.component
external make: (~id: string=?) => React.element = "Navbar"
```