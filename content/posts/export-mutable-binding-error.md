---
title: Error when exporting a mutable binding
date: 2021-05-06 08:51:34
---

```
ReScript version: rescript@9.1.2
```

When attemping to export mutable bindings we may see an error.

For example, this code:

```res
let good = None
let bad = ref(None) // Error
```

Produces the error:

```
This expression's type contains type variables that can't be generalized:
ref<option<'_weak1>>

This happens when the type system senses there's a mutation/side-effect,
in combination with a polymorphic value.
Using or annotating that value usually solves it.
```

`bad` is both mutable **and** does not have a well defined type yet. This can be fixed by declaring a type:

```res
let good = None
let bad: ref<option<string>> = ref(None)
```

`bad` is no longer a polymorphic type.

Next, consider the case of **open** polymorphic types:

```res
let good: [> #Red] = #Red
let bad: ref<[> #Red]> = ref(#Red) // Error
```

This produces the error:

```
This expression's type contains type variables that can't be generalized:
ref<_[> #Red]>

This happens when the type system senses there's a mutation/side-effect,
in combination with a polymorphic value.
Using or annotating that value usually solves it.
```

This may be solved by changing the type to a **closed** poly var.

```res
let good: [> #Red] = #Red
let bad: ref<[#Red]> = ref(#Red)
```

## Reference

- https://forum.rescript-lang.org/t/learning-poly-variants/1574/2
