---
title: How to use local storage in ReScript
date: 2020-12-12 06:40:42
---

```
ReScript version: bs-platform@8.4.2
```

ReScript provides a [Dom.Storage2](https://rescript-lang.org/docs/manual/latest/api/dom/storage2) module for accessing local storage (and session storage).

Example:

```re
Dom.Storage2.setItem(Dom.Storage2.localStorage, "message", "hello")

let messageOpt = Dom.Storage2.getItem(Dom.Storage2.localStorage, "message")

switch messageOpt {
| None => Js.log("No message")
| Some(value) => Js.log(value)
}
```
