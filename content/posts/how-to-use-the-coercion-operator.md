---
title: How to use the coercion operator?
date: 2021-05-09 06:10:05
---

```
rescript@9.1.2
```

Examples:

```res
let test1 = (arg: [#red | #green | #blue]) => {
  (arg :> string)
}

let test2 = (arg: [#1 | #3 | #5]) => {
  (arg :> int)
}

let test3 = (arg: option<[#1 | #3 | #5]>) => {
  (arg :> option<int>)
}

let test4 = (arg: [#"Hello world"]) => {
  (arg :> string)
}

type person = {"id": int, "name": string}
type idOnly = {"id": int}

let test5 = (arg: person) => {
  (arg :> idOnly)
}

Js.log(test1(#red))
Js.log(test2(#1))
Js.log(test3(Some(#3)))
Js.log(test4(#"Hello world"))
Js.log(test5({"id": 1, "name": "Hello"}))
```
