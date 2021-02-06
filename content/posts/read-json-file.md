---
title: Reading JSON files in ReScript
date: 2021-02-06 11:38:57
---

```
ReScript version: bs-platform@9.0.0
```

ReScript has built in support for reading JSON files.

For example, to read the `package.json` file:

```res
// Define the type and properties you want to access
// Alternatively you can use Js.Json.t
type package = {dependencies: Js.Dict.t<string>}

@module external package: package = "../package.json"

Js.Dict.keys(package.dependencies)->Js.Array2.forEach(Js.log)
```
