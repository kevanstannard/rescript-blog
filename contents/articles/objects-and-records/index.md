---
title: Comparing ReasonML object and record data structures
author: kevan-stannard
date: 2019-12-20 08:00
template: article.pug
---

## Record

```reasonml
type personRec = {
  name: string,
  age: int,
};

let pRec: personRec = {name: "Hello", age: 21};

Js.log(pRec);
Js.log(pRec.name);
Js.log(pRec.age);

// [ 'Hello', 21 ]
// Hello
// 21
```

## Abstract Record

An abstract record is useful when you want to work with a native JavaScript object.

```reasonml
[@bs.deriving abstract]
type personAbs = {
  name: string,
  age: int,
};

let pAbs: personAbs = personAbs(~name="Hello", ~age=21);

Js.log(pAbs);
Js.log(pAbs->nameGet);
Js.log(pAbs->ageGet);

// { name: 'Hello', age: 21 }
// Hello
// 21
```

## Reason Object

```reasonml
type personObj = {
  .
  name: string,
  age: int,
};

let pObj: personObj = {
  as _; /* Suppress "unused variable this" warning */
  pub name = "Hello";
  pub age = 21
};

Js.log(pObj);
Js.log(pObj#name);
Js.log(pObj#age);

// [[2,7,[Function],-922783157,[Function],4846783],3,tag:248]
// Hello
// 21
```

## JavaScript Object

```reasonml
type personJsObj = {
  .
  "name": string,
  "age": int,
};

let pJsObj: personJsObj = {"name": "Hello", "age": 21};

Js.log(pJsObj);
Js.log(pJsObj##name);
Js.log(pJsObj##age);

// { name: 'Hello', age: 21 }
// Hello
// 21
```

## Dictionary

```reasonml
let pDict: Js.Dict.t(string) = Js.Dict.empty();

Js.Dict.set(pDict, "name", "Hello");
Js.Dict.set(pDict, "age", "21");

Js.log(pDict);
Js.log(Js.Dict.get(pDict, "name"));
Js.log(Js.Dict.get(pDict, "age"));

// { name: 'Hello', age: '21' }
// Hello
// 21
```
