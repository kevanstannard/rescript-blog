---
title: What is the type of a node callback in ReasonML?
date: 2019-12-26 07:38:20
---

Node callbacks are typically of the form:

```js
function callback(error, items) {
  if (error) {
    // handle error
  } else {
    // handle items
  }
}
```

Let's break this down into smaller parts to convert to Reason.

## The error argument

The `error` argument may be null, or an error object. JavaScript errors in Reason are typed as `Js.Exn.t`, so the error argument becomes:

```
type nodeError = Js.nullable(Js.Exn.t)
```

## The items argument

The `items` argument may be null, or provide a value. We can use a generic type here for the value.

```
type nodeValue = Js.nullable('a)
```

## The return value

This function returns undefined in JavaScript, so the return value in Reason will be `unit`;

## The node callback function

Now let's define a `nodeCallback` function type.

Note that node callbacks must be uncurried, so we use the `(. )` function argument notation.

```reasonml
type nodeError = Js.nullable(Js.Exn.t);
type nodeValue('a) = Js.nullable('a);
type nodeCallback('a) = (. nodeError, nodeValue('a)) => unit;
```

If your callback only supplies an error, then you can use a similar type:

```re
type nodeErrorCallback('a) = (. nodeError) => unit;
```

## Utility function

A useful utility function for handling node callbacks.

```reasonml
let nodeCallback = (f) =>
  (. error, result) => {
    let errorOpt = Js.Nullable.toOption(error);
    let resultOpt = Js.Nullable.toOption(result);
    switch (errorOpt, resultOpt) {
    | (Some(error), None) => f(Belt.Result.Error(error))
    | (None, Some(result)) => f(Belt.Result.Ok(result))
    // Throw if APIs break nodeback 'guarantee':
    | _ => invalid_arg("nodeCallback arguments invalid")
    };
  };
```

## Reference

This content came from a [post on the ReasonML forums][1]. Copying here for reference:

> [yawaramin][2]
>
> I’d model the callback type as:
>
> `type nodeCallback('a) = (. Js.nullable(Js.Exn.t), Js.nullable('a)) => unit;`
>
> Few things to note:
>
> - Callbacks need to be uncurried: https://bucklescript.github.io/docs/en/function#curry-uncurry , hence using the dot-syntax (details on that page)
> - BuckleScript models JavaScript exceptions as type Js.Exn.t. The API is here: https://bucklescript.github.io/bucklescript/api/Js.Exn.html
>   There’s some magic going on in the transformation from OCaml exceptions (which can be extremely lightweight, essentially just tags) and JavaScript exceptions (which have stack traces, messages, etc.)
>
> In general to handle JavaScript exceptions in a safe way use the Js.Exn module, it provides useful functions to work with them. You can use `Belt.Result.t('a, Js.Exn.t)`.

## References

- [What is the proper type for a node callback][1]
- [How to handle a node callback in ReasonML][3]

[1]: https://reasonml.chat/t/what-is-the-proper-type-for-node-callback/1326
[2]: https://reasonml.chat/u/yawaramin
[3]: https://dev.to/yawaramin/how-to-handle-a-nodeback-in-reasonml-in7
