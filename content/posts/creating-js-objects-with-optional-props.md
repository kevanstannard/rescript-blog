---
title: Creating JavaScript objects with optional properties
date: 2021-08-06 07:11:13
---

```
ReScript version: rescript@9.1.4
```

We can use the `%obj` or the `@deriving(abstract)` decorator to help with creating JS objects that have optional properties. They may be used slightly differently.

## @obj Example

```res
// Opaque type
type t

// Special external syntax
@obj external make: (~first: string=?, ~last: string=?, unit) => t = ""

let hello = make(~first="Hello", ())
let world = make(~last="World", ())
let helloWorld = make(~first="Hello", ~last="World", ())

Js.log(hello)
Js.log(world)
Js.log(helloWorld)
```

Which produces:

```
{ first: 'Hello' }
{ last: 'World' }
{ first: 'Hello', last: 'World' }
```

Or the type can be inferred using `_` as the return value:

```res
@obj external make: (~first: string=?, ~last: string=?, unit) => _ = ""

let hello: {..} = make(~first="Hello", ())
```

Which produces the inferred type:

```js
{
  "first": Js.undefined<string>,
  "last": Js.undefined<string>,
}
```

## @deriving(abstract) Example

```res
@deriving(abstract)
type person = {
  id: int,
  @optional first: string,
  @optional last: string,
}

let p1 = person(~id=1, ())
let p2 = person(~id=2, ~first="Hello", ())
let p3 = person(~id=3, ~first="World", ())
let p4 = person(~id=4, ~first="Hello", ~last="World", ())

Js.log(p1)
Js.log(p2)
Js.log(p3)
Js.log(p4)
```

Which produces:

```
{ id: 1 }
{ id: 2, first: 'Hello' }
{ id: 3, first: 'World' }
{ id: 4, first: 'Hello', last: 'World' }
```
