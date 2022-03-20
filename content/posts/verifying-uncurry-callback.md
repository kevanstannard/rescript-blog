---
title: How to verify uncurring a callback is working?
date: 2022-03-20 12:22:10
---

Consider the following:

```res
@val external test: ((int, int) => int) => unit = "test"

let f = x => x
let g = _ => f

test(g)
```

Which generates JS:

```js
function f(x) {
  return x;
}

function g(param) {
  return f;
}

test(g);
```

Note that the call to the `test()` function **is not uncurried**.

Now with `@uncurry` on the callback function:

```res
@val external test: (@uncurry (int, int) => int) => unit = "test"

let f = x => x
let g = _ => f

test(g)
```

Which generates JS:

```js
function f(x) {
  return x;
}

function g(param) {
  return f;
}

test(function (param, param$1) {
  return f(param$1);
});
```

Notice here that the call to the test function **is uncurried**.
