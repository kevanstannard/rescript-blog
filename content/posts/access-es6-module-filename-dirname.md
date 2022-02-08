---
title: How to access __filename and __dirname in ES6 modules in ReScript?
date: 2022-02-09 08:32:19
---

```
ReScript version: rescript@9.1.4
```

```res
module Url = {
  @module("url") external fileURLToPath: string => string = "fileURLToPath"
}

module Path = {
  @module("path") external dirname: string => string = "dirname"
}

@val external importMetaUrl: string = "import.meta.url"
let __filename = Url.fileURLToPath(importMetaUrl)
let __dirname = Path.dirname(__filename)
```
