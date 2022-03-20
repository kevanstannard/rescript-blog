---
title: Check if a file is actually a file in Node
date: 2022-03-18 10:08:12
---

```res
module Fs = {
  module Stats = {
    type t
    @send external isDirectory: t => bool = "isDirectory"
    @send external isFile: t => bool = "isFile"
  }

  @module("fs") external statSync: string => Stats.t = "statSync"
}

let isFile = (path: string): bool => {
  let stats = Fs.statSync(path)
  Fs.Stats.isFile(stats)
}
```
