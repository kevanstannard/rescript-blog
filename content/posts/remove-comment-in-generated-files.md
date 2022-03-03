---
title: How to remove the comment at the top of ReScript generated files
date: 2022-03-03 21:18:10
---

```
ReScript version: rescript@9.1.4
```

Add compiler flag to `bsconfig.json`

```
"bsc-flags": ["-bs-no-version-header"]
```

