---
title: How to create an immutable array?
date: 2022-02-18 19:16:34
---

Simple version with shallow copy only:

```res
module ImmutableArray: {
  type t<'a>
  let make: unit => t<'a>
  let push: (t<'a>, 'a) => t<'a>
} = {
  type t<'a> = array<'a>
  let make = () => []
  let push = (arr, value) => Belt.Array.concat(arr, [value])
}

let arr0: ImmutableArray.t<int> = ImmutableArray.make()
let arr1 = ImmutableArray.push(arr0, 1)

Js.log(arr0 === arr0) // true
Js.log(arr0 === arr1) // false
```
