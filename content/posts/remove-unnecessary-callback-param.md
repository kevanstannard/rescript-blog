---
title: Removing the unnecssary "param" argument in callbacks with no arguments.
date: 2021-05-30 08:03:05
---

```
ReScript version: rescript@9.1.2
```

When writing callbacks with no arguments, ReScript introduces an unnecessary `param` argument. For example, this code:

```res
@val external send: (string, unit => unit) => unit = "send"
send("Hello", () => Js.log("Done"))
```

Generates JS:

```js
send("Hello", function (param) {
  console.log("Done");
});
```

Notice the `param` argument.

This can interefere in some situations.

The solution is to use the `@uncurry` decorator on the callback:

```res
@val external send: (string, @uncurry (unit => unit)) => unit = "send"
send("Hello", () => Js.log("Done"))
```

Which produces:

```js
send("Hello", function () {
  console.log("Done");
});
```
