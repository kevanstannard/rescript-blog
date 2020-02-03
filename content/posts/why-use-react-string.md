---
title: Why use React.string() in ReasonReact?
date: 2020-02-03 16:25:42
---

When writing JSX in Reason, you will need to use the `React.string()` function when rendering string values.

For example:

```reasonml
<h1>{React.string("Hello")}</h1>
```

So why do we need to do this?

The `string()` function in Reason React is implemented as:

```reasonml
external string: string => element = "%identity";
```

Firstly, a quick reminder about `%identity`. This is special Bucklescript instruction that does nothing but convert from the type `string` to `element`.

So when we write `React.string("Hello")` we are not doing anything with the value, but we are just changing it's type to `element`, which allows it to be a compatible child of an HTML tag.

## References

- Special Identity External  
  https://bucklescript.github.io/docs/en/intro-to-external#special-identity-external
