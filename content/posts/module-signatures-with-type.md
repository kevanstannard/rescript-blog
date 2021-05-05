---
title: ReScript module signatures with abstract types
date: 2020-12-12 11:18:22
---

```
ReScript version: bs-platform@8.4.2
```

Suppose we declare a module signature:

```res
module type SHOW = {
  type t
  let show: t => string
}
```

Here we have an abstract type `t` and it's up to the implmentation module to provide the type.

Let's declare a `person` type:

```res
type person = {name: string}
```

And a `ShowPerson: SHOW` module:

```res
module ShowPerson: SHOW = {
  type t = person
  let show = (person: t) => person.name
}
```

Now we can make use of our `ShowPerson` module:

```res
let joe: person = {name: "Joe"};

ShowPerson.show(joe);
```

Unfortunately on that last line the reference to `joe` is causing an error:

```
This has type: person
Somewhere wanted: ShowPerson.t
```

To fix this we need to add a `with type` annotation to our `ShowPerson` module:

```res
module ShowPerson: SHOW with type t = person = {
  type t = person
  let show = person => person.name
}
```

## References

Unfamiliar syntax in documentation for Show  
https://github.com/reazen/relude/issues/193

Type Classes in ReasonML: A World of Functions for Free  
https://dev.to/mlms13/type-classes-in-reasonml-a-world-of-functions-for-free-2lag
