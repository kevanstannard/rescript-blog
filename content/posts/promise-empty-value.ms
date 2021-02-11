---
title: Return empty value in a promise
date: 2021-02-11 22:25:59
---

```
ReScript version: bs-platform@9.0.0
```

When using `Promise.make()` you can return an empty value using `ignore`:

```res
let _ = Promise.make((resolve, _reject) => {
  resolve(. ignore)
})
```
