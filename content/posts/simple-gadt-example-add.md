---
title: Simple GADT Example
date: 2022-02-22 07:35:41
---

```res
type rec expr<_> =
  | Int(int): expr<int>
  | Float(float): expr<float>

let add:
  type a. (expr<a>, expr<a>) => expr<a> =
  (a, b) => {
    switch (a, b) {
    | (Int(a), Int(b)) => Int(a + b)
    | (Float(a), Float(b)) => Float(a +. b)
    }
  }
```

Some notes about ReScript GADT support:

> GADTs are hard to explain, hard to understand, and we are not sure yet if it makes sense to trade clarity of the code with more expressive type constraint possibilities. GADTs are actually so meta that the Reason docs linked to an article called [Detecting use-cases for GADTs in OCaml](https://blog.mads-hartmann.com/ocaml/2015/01/05/gadt-ocaml.html), which is always a good sign that a feature might be too complex for the broader audience.

Ref: https://forum.rescript-lang.org/t/long-term-goals-vis-a-vis-typescript/332/18

