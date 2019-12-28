---
title: How to use unicode characters in ReasonML?
date: 2019-12-28 22:52:47
---

We can use BuckleScript's string interpolation `{js|` and `|js}` for unicode characters:

```reasonml
let smile: string = {js|😀|js};
print_endline(smile);
```

Note that we can also access variables by prefixing with a `$`:

```reasonml
let world = "world";
let helloWorld = {j|hello, $world|j};
```

Which also works with numbers:

```reasonml
let num = 123;
let hello123 = {j|hello, $num|j};
```
