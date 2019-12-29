---
title: How to use null and undefined in ReasonML?
date: 2019-12-30 06:39:25
---

`None` of an `option` type compiles to `undefined`:

```re
let a = Some(5);
let b = None;
```

Compiles to:

```
var a = 5;
var b = undefined;
```

If you need an explicit `null` or `undefined` you can use:

```re
let jsNull = Js.Nullable.null;
let jsUndefined = Js.Nullable.undefined;
```

Which compiles to:

```
var jsNull = null;
var jsUndefined = undefined;
```

Values that may be `null` or `undefined` have a type `Js.Nullable.t`.

- Nullable values my be created using `Js.Nullable.return(value)`
- Nullable values may be converted **to** an `option` using `Js.Nullable.toOption(value)`
- Nullable values may be converted **from** an `option` using `Js.Nullable.fromOption(value)`

```re
let result1: Js.Nullable.t(string) = Js.Nullable.return("hello");
let result2: Js.Nullable.t(int) = Js.Nullable.fromOption(Some(10));
let result3: option(int) = Js.Nullable.toOption(Js.Nullable.return(10));
```

## References

- Null, Undefined & Option  
  https://bucklescript.github.io/docs/en/null-undefined-option#docsNav
- Nullable  
  https://bucklescript.github.io/docs/en/interop-cheatsheet#nullable
