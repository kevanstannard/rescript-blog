---
title: Polymorphic type constraints
date: 2021-09-03 16:09:48
---

```
ReScript version: rescript@9.1.4
```

Consider the following polymorphic functions:

```res
let id1: 'a => 'a = x => x
let id2: 'a => 'a = x => x + 1
```

These compile successfully, but why does `id2` compile? Since it now only accepts an `int` shouldn't it trigger a compiler warning?

Types of the form `'a`, `'b`, etc. are known as type variables. What's important to note here is that they are actually **placeholders for an undetermined type**. This means that the type system will _fill these types in with more specific types_ if needed.

However, if we wanted to ensure the implementation actually accepts polymorphic types, then we need to use a slightly different syntax:

```res
let id1: 'a. 'a => 'a = x => x // OK
let id2: 'a. 'a => 'a = x => x + 1 // Error
```

We can read `'a.` as "for all types of 'a".

And here's an example with multiple types:

```res
let fst: 'a 'b. ('a, 'b) => 'a = (a, _) => a
```

## References

- https://www.craigfe.io/posts/polymorphic-type-constraints
