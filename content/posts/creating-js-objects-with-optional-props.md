---
title: Creating JavaScript objects with optional properties
date: 2021-05-06 09:32:19
---

```
ReScript version: rescript@9.1.2
```

We can use the `%obj` decorator to help with creating JS objects that have optional properties.

## Example

```res
type t

@obj
external make: (~first: string=?, ~last: string=?, unit) => t = ""

let helloFn = make(~first="Hello")
let worldFn = make(~last="World")
let helloWorldFn = make(~first="Hello", ~last="World")

let hello = helloFn()
let world = worldFn()
let helloWorld = helloWorldFn()

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
