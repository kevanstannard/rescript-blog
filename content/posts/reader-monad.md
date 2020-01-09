---
title: Creating a Reader Monad in ReasonML
date: 2019-12-21
---

## Reader type

A Reader is a function that takes an "environment" variable, that can be any data, and performs some operation on it.

```re
type t('e, 'a) =
  | Reader('e => 'a);
```

Example:

```re
let r = Reader(e => e + 1);
```

## run()

The `run()` function takes a reader and an environment passes the environment to the reader function.

```re
type run('e, 'a) = (t('e, 'a), 'e) => 'a;
let run: run('e, 'a) = (Reader(r), env) => r(env);
```

Example:

```re
let r1 = Reader(e => e + 1);
run(r1, 1);
// 2
```

## return()

The `return()` function creates a reader that always returns the same value, ignoring the environment.

```re
type return('e, 'a) = 'a => t('e, 'a);
let return: return('e, 'a) = a => Reader(_env => a);
```

Example:

```re
let r2 = return(99);
run(r2, 1);
// 99
```

## ask()

The `ask()` function creates a reader that returns the environment variable.

```re
type ask('e) = unit => t('e, 'e);
let ask = () => Reader(env => env);
```

Example:

```re
let r3 = ask();
run(r3, 123);
// 123
```

## local()

The `local()` function creates a reader that allows you to transform the environment value before passing it to a subsequent reader.

```re
type local('e, 'a) = ('e => 'e, t('e, 'a)) => t('e, 'a);
let local: local('e, 'a) = (f, m) => Reader(env => run(m, f(env)));
```

Example:

```re
let r4 = Reader(e => e + 1);
let r5 = local(e => - e, r4);
run(r5, 1);
// 0
```

## map()

The `map()` function creates a reader that applies a function to the result provided by the reader.

```re
type map('e, 'a, 'b) = ('a => 'b, t('e, 'a)) => t('e, 'b);
let map: map('e, 'a, 'b) = (f, m) => Reader(env => f(run(m, env)));
```

Example:

```re
let r6 = Reader(e => e + 1);
let r7 = map(x => x * 10, r6);
run(r7, 1);
// 20
```

## bind()

The `bind()` function is similar to map, except that the applied function must return a reader rather than a value. This allows two readers to be bound together.

```re
type bind('e, 'a, 'b) = ('a => t('e, 'b), t('e, 'a)) => t('e, 'b);
let bind: bind('e, 'a, 'b) =
  (f, m) => Reader(env => run(f(run(m, env)), env));
```

Example:

```re
let r8 = Reader(e => e + 1);
let r9 = bind(x => Reader(_ => x * 2), r8);
run(r9, 1);
// 4
```

For this example, we could also use the `return()` function:

```re
let r10 = Reader(e => e + 1);
let r11 = bind(x => return(x * 2), r10);
run(r11, 1);
// 4
```

## bind operator

We can also define a bind operator that allows us to pass the **same** environment value to multiple readers.

```re
type bindFlip('a, 'e, 'b) = (t('e, 'a), 'a => t('e, 'b)) => t('e, 'b);
let (>>=): bindFlip('a, 'e, 'b) = (m, f) => bind(f, m);
```

Example:

```re
let ra = Reader(x => x + 1);
let rb = Reader(x => x + 2);
let rc = Reader(x => x + 3);
let r = ra >>= (a => rb >>= (b => rc >>= (c => return(a + b + c))));
Js.log(run(r, 1));
// 9
```

Another example, with strings:

```re
let greet = (name, greeting) => greeting ++ ": " ++ name;
let lines = List.map(print_endline);
let ra = Reader(greet("One"));
let rb = Reader(greet("Two"));
let rc = Reader(greet("Three"));
let r = ra >>= (a => rb >>= (b => rc >>= (c => return(lines([a, b, c])))));
run(r, "Hello");
// Hello: One
// Hello: Two
// Hello: Three
```

## References

- Reader monad in reasonml  
  https://sketch.sh/s/NUtDN1ArEiJ1FIEfG6ZRoj/

- A simple reader monad example  
  https://blog.ssanj.net/posts/2014-09-23-A-Simple-Reader-Monad-Example.html

- Rationale Reader  
  https://github.com/jonlaing/rationale/blob/9e206959b7d4de5ed96ef90ce71a268ccf624124/src/Reader.re

- A Layman's Guide to Functors in ReasonML  
  https://andywhite.xyz/posts/2019-11-01-a-laymans-guide-to-functors-in-reasonml/
