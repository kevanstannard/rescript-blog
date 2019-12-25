---
title: ReasonML switch statement with multiple values
date: 2019-12-16
---

ReasonML supports a `switch` statement with multiple values.

For example:

```reasonml
let a = true;
let b = false;
let x = switch (a, b) {
  | (false, false) => "Both False"
  | (false, true) => "False and True"
  | (true, false) => "True and False"
  | (true, true) => "Both True"
};
```
