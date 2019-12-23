---
title: “Unused variable this” with ReasonML objects
author: kevan-stannard
date: 2019-12-20 09:00
template: article.pug
---

If you declare a simple ReasonML object such as:

```reasonml
type person = {. name: string};
let p1 = {
  pub name = "Hello"
};
```

You may see a compiler warning:

```
Unused variable this
```

To hide this warning, add `as _;` at the beginning of your object:

```reasonml
let p = {
  as _;
  pub name = "Hello"
};
```

These object types have an implicit this available, and if you don’t use it, then you will receive the warning.

Here’s an example that uses the `this` reference:

```reasonml
type person = {
  .
  name: string,
  greet: unit => string,
};

let p: person = {
  pub name = "Joe";
  pub greet = () => "Hello " ++ this#name;
};
```
