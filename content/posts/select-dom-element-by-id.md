---
title: How to select a DOM element by id in ReasonML?
date: 2019-12-26 15:49:22
---

```reasonml
type element;

[@bs.scope "document"] [@bs.val] [@bs.return nullable]
external getElementById: string => option(element) = "getElementById";
```

## About @bs.val

Use `@bs.val` to bind a value to an external global.

Example from [the docs](https://bucklescript.github.io/docs/en/bind-to-global-values):

```reasonml
[@bs.val] external setTimeout : (unit => unit, int) => float = "setTimeout";
[@bs.val] external clearTimeout : float => unit = "clearTimeout";
```

## About @bs.scope

From [the docs](https://bucklescript.github.io/docs/en/bind-to-global-values#global-modules).

> If you want to bind to a value inside a global module, e.g. Math.random, attach a `bs.scope` to your `bs.val` external.

## About @bs.return nullable

From [the docs](https://bucklescript.github.io/docs/en/return-value-wrapping):

> The return nullable attribute will automatically convert null and undefined to `option`.

:heart:

## References

- [How to select a dom with a particular id?](https://reasonml.chat/t/how-to-select-a-dom-with-a-particular-id/503)
