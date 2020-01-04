---
title: Using special characters in identifier names in ReasonML
date: 2020-01-03 15:37:23
---

The following characters can be used as identifiers:

```re
let (!) = 0;
let (@) = 0;
let ($) = 0;
let (%) = 0;
let (^) = 0;
let (&) = 0;
let (-) = 0;
let (+) = 0;
let (<) = 0;
let (>) = 0;
let (/) = 0;
let ( * ) = 0;
```

Which generates:

```js
var not = 0;
var $at = 0;
var $ = 0;
var $percent = 0;
var $bang = 0;
var $amp = 0;
var $neg = 0;
var $plus = 0;
var $less = 0;
var $great = 0;
var $slash = 0;
var $star = 0;
```

However code like this will overwite existing operators. For example:

```re
let (!) = 0;
let x = !true;
// Error: This expression has type int
```

So instead we can use these identifiers combined together.

For example:

```re
let (>><<) = List.append;

let x = [1, 2, 3] >><< [4, 5, 6];
```

## Related

- OCaml Prefix and infix symbols
  <https://caml.inria.fr/pub/docs/manual-ocaml/lex.html#infix-symbol>
