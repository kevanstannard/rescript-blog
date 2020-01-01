---
title: How to use local storage in ReasonML
date: 2020-01-02 08:13:12
---

Bucklescript provides a [Dom.Storage](https://bucklescript.github.io/bucklescript/api/Dom.Storage.html) module for accessing local storage (and session storage).

Example:

```re
Dom.Storage.setItem("message", "hello", Dom.Storage.localStorage);

let messageOpt = Dom.Storage.getItem("message", Dom.Storage.localStorage);

switch (messageOpt) {
| None => print_endline("No message")
| Some(value) => print_endline(value)
};
```
