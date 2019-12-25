---
title: Converting between ReasonML records and JavaScript objects
date: 2019-12-11
---

> **Update Dec 2019**: In BuckleScript >= v7 records are already compiled to JS objects. jsConverter is therefore obsolete and will generate a no-op function for compatibility instead.

BuckleScript provides a [convenience decorator][1] to convert between ReasonML records and JavaScript objects.

The `[@bs.deriving jsConverter]` decorator declared above a record type causes two functions to become available:

- `<typename>ToJs`
- `<typename>FromJs`

Suppose you have a person type, when you add the decorator:

```reasonml
[@bs.deriving jsConverter]
type person = {
  id: int,
  name: string,
};
```

It causes the following two functions to become available:

```reasonml
let personToJs: person => {. "id": int, "name": string};

let personFromJs: {.. "id": int, "name": string} => person;
```

Example usage:

```reasonml
[@bs.deriving jsConverter]
type person = {
  id: int,
  name: string,
};

let sherlock = {id: 1, name: "Holmes"};
Js.log2("sherlock", sherlock);
// > sherlock [ 1, 'Holmes' ]

let sherlockJs = personToJs(sherlock);
Js.log2("sherlockJs", sherlockJs);
// > sherlockJs { id: 1, name: 'Holmes' }

let sherlockRe = personFromJs(sherlockJs);
Js.log2("sherlockRs", sherlockRe);
// > sherlockRs [ 1, 'Holmes' ]
```

[1]: https://bucklescript.github.io/docs/en/generate-converters-accessors
