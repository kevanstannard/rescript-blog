---
title: Number literals alternative syntax
date: 2021-01-02 19:33:40
---

```
ReScript version: bs-platform@8.4.2
```

Number literals may use an `_` separator as a thousand's separator.

For example:

```re
let x = 3_000_000
```

Generates:

```js
var x = 3000000;
```
