---
title: ReasonML Polymorphic Variants
date: 2020-01-13 06:11:10
---

Polymorphic variants are distinguished from ordinary variants by the leading backtick.

Unlike ordinary variants, polymorphic variants can be used without an explicit type declaration.

Example 1:

```re
let three = `Int(3);
let four = `Float(4.);
let nan = `Not_a_number;
```

Notice that multiple polymorophic variant values may be present together in an array.

Example 2:

```re
let is_positive =
  fun
  | `Int(x) => x > 0
  | `Float(x) => x > 0.;

List.filter(is_positive, [three, four]);
```

Example 3:

```re
let is_positive_result =
  fun
  | `Int(x) => Ok(x > 0)
  | `Float(x) => Ok(x > 0.)
  | `Not_a_number => Error("not a number");

let result_to_bool =
  fun
  | Error(_) => false
  | Ok(b) => b;

List.filter(
  value => result_to_bool(is_positive_result(value)),
  [three, four, nan],
);
```

## References

- Real World OCaml - Variants  
  https://v1.realworldocaml.org/v1/en/html/variants.html
