---
title: Understanding optional named arguments
date: 2022-03-01 20:01:00
---

```
ReScript version: rescript@9.1.4
```

Consider the following code, and note the difference in optional type annotations:

```res
let f: (~foo: string=?, unit) => string = (~foo: option<string>=?, ()) =>
  switch foo {
  | None => ""
  | Some(x) => x
  }

let _ = f()
let _ = f(~foo="")
```

> The entire function f is annotated as `(~foo: string=?) => string`. This what code outside of the function sees. foo is a string because **outside** code will call it like `f(~foo="bar")`.

> The inline type annotation for foo is `option<string>` though, because that’s what code **inside** the function sees.

# Reference

https://forum.rescript-lang.org/t/binding-to-an-option-value/3087/4?u=kevanstannard
