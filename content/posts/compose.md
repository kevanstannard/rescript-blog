---
title: Writing a compose function in ReScript.
date: 2020-12-11 20:07:46
---

ReScript version: `bs-platform@8.4.2`

A simple compose function has the form:

```js
compose(f, g, x) = f(g(x));
```

Where `f` and `g` are functions.

This may also be read as `f` after `g`. I.e. we execute `g` first, and then execute `f` after `g`.

The type of compose could be written as:

```re
type compose<'a, 'b, 'c> = ('b => 'c) => ('a => 'b) => 'a => 'c;
```

Which in ReScript would typically be written as:

```re
type compose<'a, 'b, 'c> = ('b => 'c, 'a => 'b, 'a) => 'c
```

We can then write our compose function as:

```re
let compose: compose<'a, 'b, 'c> = (f, g, x) => f(g(x))
```

Example:

```re
let f = x => x + 1
let g = x => x * 2
let fn = compose(f, g)

let result = fn(1)
Js.log(result)
// 4
```
