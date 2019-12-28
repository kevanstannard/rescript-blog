---
title: How write embed JavaScript functions ReasonML?
date: 2019-12-29 06:07:53
---

Use the `[@bs.raw]` annotation.

## Embed the whole function

The simplest version directly embeds the whole function:

```reasonml
let add1 = [%raw "(a, b) => return a + b"];
```

This generates:

```
var add1 = ((a, b) => return a + b);
```

## Hint that it's a function

BuckleScript supports a syntax that allows you to indicate that the raw code is a function.

```reasonml
let add2 = [%raw (a, b) => "return a + b"];
```

From [the docs](https://bucklescript.github.io/docs/en/embed-raw-javascript):

> This allows the compiler to understand that it's a function, to see the number of arguments it has, to detect some side-effects and to generate better JS code.

This generates:

```
function add2 (a,b){return a + b};
```

## Specify the argument and return types

```reasonml
let add3 (int, int) => int = [%raw (a, b) => "return a + b"];
```

This generates the same code as the previous version, but provides precise type hints to ReasonML:

```
function add3 (a,b){return a + b};
```

## Embedding longer more complicated functions

You can use a multiline string:

```reasonml
let jsCalculate: (array(int), int) => int = [%bs.raw
  {|
  function (numbers, scaleFactor) {
    var result = 0;
    numbers.forEach(number => {
      result += number;
    });
    return result * scaleFactor;
  }
|}
];
```

Which generates:

```
var jsCalculate = (
  function (numbers, scaleFactor) {
    var result = 0;
    numbers.forEach(number => {
      result += number;
    });
    return result * scaleFactor;
  }
);
```
