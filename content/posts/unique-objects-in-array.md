---
title: How to find unique objects in an array by a key?
date: 2021-05-06 12:24:58
---

```
ReScript version: rescript@9.1.2
```

Convert to a `Dict` and get its values.

```res
type person = {
  id: int,
  name: string,
}

let uniqueById = persons =>
  persons
  ->Js.Array2.map(person => (Js.Int.toString(person.id), person))
  ->Js.Dict.fromArray
  ->Js.Dict.values

let persons = [{id: 1, name: "One"}, {id: 2, name: "Two"}, {id: 1, name: "Three"}]

let uniquePersons = uniqueById(persons)
```
