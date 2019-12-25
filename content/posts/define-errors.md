---
title: How to define errors in ReasonML
date: 2019-12-16
---

Errors in ReasonML belong to the `exn` type.

We can extend this type with our own exceptions:

```reasonml
type exn +=
  | MyError
  | MyOtherError(string);
```

However ReasonML provides some syntactic sugar to make this more readable:

```reasonml
exception MyError;
exception MyOtherError(string);
```

## References

ReasonML Exception Handling
https://medium.com/w3reality/reasonml-exception-handling-c2ea747f71df
