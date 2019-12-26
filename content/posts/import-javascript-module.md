---
title: How to import a JavaScript module in ReasonML?
date: 2019-12-26 13:52:14
tags: interop
---

## Importing a default module

Suppose you want to achieve this:

```js
const foo = require("foo");
const result = foo();
```

Then in Reason we can create write:

```reasonml
[@bs.module] external foo: unit => string = "foo";
let result = foo();
```

## Importing a function within a module

Suppose you want to achieve this:

```js
const foo = require("foo");
const result = foo.bar();
```

Then in Reason we can create write:

```reasonml
[@bs.module "foo"] external bar: unit => string = "bar";
let result = bar();
```

## More complicated imports

Sometimes imports are more complicated. In these cases you may be able to just use `%bs.raw`.

For example, suppose you want to achieve this:

```js
const foo = require("foo")();
const result = foo();
```

Then in Reason we can create write:

```reasonml
let foo: unit => string = [%bs.raw {| require("foo")() |}];
let result = foo();
```
