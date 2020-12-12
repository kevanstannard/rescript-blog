---
title: What is the type of a node callback in ReScript?
date: 2020-12-12 11:28:36
---

```
ReScript version: bs-platform@8.4.2
```

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

Let's break this down into smaller parts to convert to ReScript.

## The error argument

The `error` argument may be null, or an error object. JavaScript errors in ReScript are typed as `Js.Exn.t`, so the error argument becomes:

```re
type nodeError = Js.nullable<Js.Exn.t>
```

## The items argument

The `items` argument may be null, or provide a value. We can use a generic type here for the value.

```re
type nodeValue<'a> = Js.nullable<'a>
```

## The return value

This function returns undefined in JavaScript, so the return value in ReScript will be `unit`;

## The node callback function

Now let's define a `nodeCallback` function type.

Note that node callbacks must be uncurried, so we use the `(. )` function argument notation.

```reasonml
type nodeError = Js.nullable(Js.Exn.t);
type nodeValue('a) = Js.nullable('a);
type nodeCallback<'a> = (. nodeError, nodeValue<'a>) => unit
```

If your callback only supplies an error, then you can use a similar type:

```re
type nodeCallbackError = (. nodeError) => unit
```

## Utility function #1

An example utility function for handling node callbacks that returns a `Result`.

```re
let nodeCallbackWithResult = (
  f: Belt.Result.t<'a, Js.Exn.t> => unit,
  . error: nodeError,
  result: nodeResult<'a>,
) => {
  let errorOpt: option<Js.Exn.t> = Js.Nullable.toOption(error)
  let resultOpt: option<'a> = Js.Nullable.toOption(result)
  switch (errorOpt, resultOpt) {
  | (Some(error), _) => f(Belt.Result.Error(error))
  | (_, Some(result)) => f(Belt.Result.Ok(result))
  | (None, None) => raise(Invalid_argument("nodeCallback arguments invalid"))
  }
}
```

Example usage:

```re
@bs.module("fs") external readFile: (string, string, nodeCallback<string>) => unit = "readFile"

let onResult = (result: result<string, Js.Exn.t>) => {
  let message = switch result {
  | Ok(result) => "Success: " ++ result
  | Error(error) => "Error: " ++ Belt.Option.getWithDefault(Js.Exn.message(error), "Unknown")
  }
  Js.log(message)
}

readFile("hello.txt", "UTF-8", nodeCallbackWithResult(onResult))
```

## Utility function #2

Another example utility function that uses `onSuccess` and `onError` callbacks

```re
let nodeCallbackWithSuccessError = (
  onSuccess: 'a => unit,
  onError: Js.Exn.t => unit,
  . error: nodeError,
  result: nodeResult<'a>,
) => {
  let errorOpt: option<Js.Exn.t> = Js.Nullable.toOption(error)
  let resultOpt: option<'a> = Js.Nullable.toOption(result)
  switch (errorOpt, resultOpt) {
  | (Some(error), _) => onError(error)
  | (_, Some(result)) => onSuccess(result)
  | (None, None) => raise(Invalid_argument("nodeCallback arguments invalid"))
  }
}
```

And example usage:

```re
@bs.module("fs") external readFile: (string, string, nodeCallback<string>) => unit = "readFile"

let onSuccess = (result: string) => {
  let message = "Success: " ++ result
  Js.log(message)
}

let onError = (error: Js.Exn.t) => {
  let message = "Error: " ++ Belt.Option.getWithDefault(Js.Exn.message(error), "Unknown")
  Js.log(message)
}

readFile("hello.txt", "UTF-8", nodeCallbackWithSuccessError(onSuccess, onError))
```

## Utility function #3

Last example converts the result to a promise.

```re
let nodeCallbackWithPromise = (
  f: Js.Promise.t<'a> => unit,
  . error: nodeError,
  result: nodeResult<'a>,
) => {
  let errorOpt: option<Js.Exn.t> = Js.Nullable.toOption(error)
  let resultOpt: option<'a> = Js.Nullable.toOption(result)
  switch (errorOpt, resultOpt) {
  | (Some(error), _) => {
      let message = Belt.Option.getWithDefault(Js.Exn.message(error), "Unknown")
      f(Js.Promise.reject(Failure(message)))
    }
  | (_, Some(result)) => f(Js.Promise.resolve(result))
  | (None, None) => f(Js.Promise.reject(Failure("nodeCallback arguments invalid")))
  }
}
```

And example usage:

```re
@bs.module("fs") external readFile: (string, string, nodeCallback<string>) => unit = "readFile"

let handlePromise = (promise: Js.Promise.t<string>) => {
  open Js.Promise
  promise
  ->then_((result: string) => resolve("Success: " ++ result), _)
  ->catch((_error: Js.Promise.error) => resolve("Error: Unknown"), _)
  ->then_(message => {
    Js.log(message)
    resolve()
  }, _)
  ->ignore
}

readFile("hello.txt", "UTF-8", nodeCallbackWithPromise(handlePromise))
```

## Reference

This content came from a post on the ReasonML forums. Copying here for reference:

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

What is the proper type for a node callback  
https://reasonml.chat/t/what-is-the-proper-type-for-node-callback/1326

How to handle a node callback in ReasonML  
https://dev.to/yawaramin/how-to-handle-a-nodeback-in-reasonml-in7
