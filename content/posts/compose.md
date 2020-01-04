---
title: Writing a compose function in ReasonML.
date: 2020-01-04 19:02:25
---

A simple compose function has the form:

```js
compose(f, g, x) = f(g(x));
```

Where `f` and `g` are functions.

This may also be read as `f` after `g`. I.e. we execute `g` first, and then execute `f` after `g`.

The type of compose could be written as:

```re
type compose('a, 'b, 'c) = ('b => 'c) => ('a => 'b) => 'a => 'c;
```

Which in Reason would typically be written as:

```re
type compose('a, 'b, 'c) = ('b => 'c, 'a => 'b, 'a) => 'c;
```

We can then write our compose function as:

```re
let compose: compose('a, 'b, 'c) = (f, g, x) => f(g(x));
```

Example:

```re
let f = x => x + 1;
let g = x => x * 2;
let fn = compose(f, g);

let result = fn(1);
Js.log(result);
// 4
```

In Haskell, this function has the name `.` which allows you to write function composition such as `f . g`.

We can't use `.` as an identifier in ReasonML, but we can invent our own such as `<.>`.

So rewriting our compose, we get:

```re
type compose('a, 'b, 'c) = ('b => 'c, 'a => 'b, 'a) => 'c;
let (<.>): compose('a, 'b, 'c) = (f, g, x) => f(g(x));

let f = x => x + 1;
let g = x => x * 2;
let fn = times2 <.> add1;

let result = fn(1);
Js.log(result);
// 4
```
