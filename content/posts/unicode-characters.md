---
title: How to use Unicode characters in ReScript?
date: 2020-12-13 13:40:48
---

```
ReScript version: bs-platform@8.4.2
```

Regular double quoted strings don't support unicode characters.

Instead use _backtick_ quoted strings.

Example, double quotes:

```res
Js.log("😀")
// Prints something like "ð"
```

Example, backticks:

```res
Js.log(`😀`)
// Prints 😀
```
