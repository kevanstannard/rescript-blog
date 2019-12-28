---
title: ReasonML module signatures with abstract types
date: 2019-12-28 13:20:23
---

Suppose we declare a module signature:

```reasonml
module type SHOW = {
  type t;
  let show: t => string;
};
```

Here we have an abstract type `t` and it's up to the implmentation module to provide the type.

Let's declare a `person` type:

```reasonml
type person = {name: string};
```

And a `ShowPerson: SHOW` module:

```reasonml
module ShowPerson: SHOW = {
  type t = person;
  let show = person => person.name;
};
```

Now we can make use of our `ShowPerson` module:

```reasonml
let joe: person = {name: "Joe"};

ShowPerson.show(joe);
```

Unfortunately on that last line the referemce to `joe` is causing an error:

```
This has type:
    person
  But somewhere wanted:
    ShowPerson.t
```

To fix this we need to add a `with type` annotation to our `ShowPerson` module:

```reasonml
module ShowPerson: SHOW with type t = person = {
  type t = person;
  let show = person => person.name;
};
```

## References

- [Unfamiliar syntax in documentation for Show](https://github.com/reazen/relude/issues/193)
- [Type Classes in ReasonML: A World of Functions for Free](https://dev.to/mlms13/type-classes-in-reasonml-a-world-of-functions-for-free-2lag)
