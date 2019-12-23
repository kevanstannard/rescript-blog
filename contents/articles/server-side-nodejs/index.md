---
title: Using ReasonML server side with Node.js
author: kevan-stannard
date: 2019-12-11 08:00
template: article.pug
---

Node version `13.3.0`

Bucklescript version `5.2.1`

When writing client side code in ReasonML, you would typically have a `bsconfig.json` setting for es6 modules:

```
"package-specs": [
  {
   "module": "es6",
   "in-source": true
  }
]
```

This generates import statements that don't work in the current version of Node.

To fix this, change the module setting to commonjs , which will generate require statements instead:

```
"package-specs": [
  {
   "module": "commonjs",
   "in-source": true
  }
]
```
