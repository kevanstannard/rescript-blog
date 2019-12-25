---
title: How to access values in a ReasonML Abstract Record?
date: 2019-12-16
---

An abstract record type is declared as follows:

```reasonml
[@bs.deriving abstract]
type person = {
  name: string,
  age: int,
};
```

This looks like a ReasonML record, but it's not a record.

This declaration causes the creation of three functions:

- `person()` the creation function.
- `nameGet()` to access the name of a person
- `ageGet()` to access the age of a person

For example:

```reasonml
let joe: person = person(~name="Joe", ~age=20);

let joeName: string = nameGet(joe);
```

As noted above this is not a record, consider the difference between a normal record and an abstract record:

```reasonml
[@bs.deriving abstract]
type abstractPerson = {
  name: string,
  age: int,
};

type person = {
  name: string,
  age: int,
};

let abstractJoe = abstractPerson(~name="Joe", ~age=20);
let joe = {name: "Joe", age: 20};

Js.log(abstractJoe);
// {name: "Joe", age: 20}

Js.log(joe);
// ["Joe", 20]
```

This makes the `abstract` annotation useful for inter-op with JavaScript.

Suppose you have a object named `joe` in JavaScript with the fields `name` and `age`, we can access this object in ReasonML using:

```reasonml
[@bs.val] external john : person = "john";
```
