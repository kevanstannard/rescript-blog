---
title: How to encode a record as an array?
date: 2021-12-17 19:14:56
---

```
rescript@9.1.4
```

When all keys of a record are numeric and sequential:

```res
type t = {
  @as("0") x: int,
  @as("1") y: int,
  @as("2") z: int,
}

let x = {x: 1, y: 2, z: 3}
```

Then the record is encoded as an array:

```js
var x = [
  1,
  2,
  3
];
```

When not sequential:

```res
type t = {
  @as("3") x: int,
  @as("4") y: int,
  @as("5") z: int,
}

let x = {x: 1, y: 2, z: 3}
```

Then it's encoded as an object:

```js
var x = {
  "0": 1,
  "2": 2,
  "4": 3
};
```

When not starting from `0`:

```res
type t = {
  @as("1") x: int,
  @as("2") y: int,
  @as("3") z: int,
}

let x = {x: 1, y: 2, z: 3}
```

Then it's encoded as an object:

```js
var x = {
  "1": 1,
  "2": 2,
  "3": 3
};
```

When different types:

```res
type t = {
  @as("0") x: int,
  @as("1") y: float,
  @as("2") z: bool,
}

let x = {x: 1, y: 2.0, z: true}
```

Same rules as above:

```res
var x = [
  1,
  2.0,
  true
];
```

