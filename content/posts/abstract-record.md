---
title: Abstract records in ReasonML
date: 2019-12-30 08:35:54
---

## Simple abstract record

```re
[@bs.deriving abstract]
type personA = {
  name: string,
  age: int,
  job: string,
};

let joe = personA(~name="Joe", ~age=22, ~job="Teacher");

print_endline(joe->nameGet);
print_endline(joe->ageGet->string_of_int);
print_endline(joe->jobGet);
```

## Abstract record optional field

```re
[@bs.deriving abstract]
type personB = {
  [@bs.optional]
  name: string,
  age: int,
  job: string,
};

// Notice the `()`
let anon = personB(~age=23, ~job="Developer", ());

let anonName =
  switch (anon->nameGet) {
  | None => "Anonymous"
  | Some(name) => name
  };
print_endline(anonName);
```

## Abstract record mutable field

```re
[@bs.deriving abstract]
type personC = {
  name: string,
  age: int,
  mutable job: string,
};

let jill = personC(~name="Jill", ~age=28, ~job="Politician");
jill->jobSet("Psychologist");

print_endline(jill->jobGet);
```
