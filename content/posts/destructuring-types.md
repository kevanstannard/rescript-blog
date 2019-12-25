---
title: De-structuring ReasonML type data (using pattern matching)
date: 2019-12-12
---

Suppose we have the following type:

```reasonml
type person = Person(string, int);
```

We can use this type as follows:

```reasonml
let joe = Person("Joe", 23);
let jim = Person("Jim", 31);
```

When we have variables like this, we can use pattern matching to extract the values:

```reasonml
let Person(name1, age1) = joe;
let Person(name2, age2) = jim;

Js.log2(name1, age1);
Js.log2(name2, age2);

// "Joe" 23
// "Jim" 31
```
