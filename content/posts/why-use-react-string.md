---
title: Why use ReasonReact.string() in ReasonReact?
date: 2020-12-12 16:58:52
---

```
ReScript version: bs-platform@8.4.2
```

When writing JSX in Reason, you will need to use the `ReasonReact.string()` function when rendering string values.

For example:

```re
<h1>{ReasonReact.string("Hello")}</h1>
```

So why do we need to do this?

The `string()` function in Reason React is implemented as:

```re
external string: string => element = "%identity";
```

Firstly, a quick reminder about `%identity`. This is special instruction has no behaviour, but allows the conversion of the type `string` to `element`.

So when we write `ReasonReact.string("Hello")` we are not doing anything with the value, but we are just changing it's type to `element`, which allows it to be a compatible child of an HTML tag.

## References

Special Identity External  
https://bucklescript.github.io/docs/en/intro-to-external#special-identity-external
