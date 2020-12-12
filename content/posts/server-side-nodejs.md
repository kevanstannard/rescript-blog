---
title: Using ReScript server side with Node.js
date: 2020-12-12 16:48:19
---

```
ReScript version: bs-platform@8.4.2
```

When writing client side code in ReScript, you would typically have a `bsconfig.json` setting for es6 modules:

```json
"package-specs": [
  {
   "module": "es6",
   "in-source": true
  }
]
```

This generates `import` statements that don't work in the current version of Node.

To fix this, change the module setting to commonjs , which will generate `require()` statements instead:

```json
"package-specs": [
  {
   "module": "commonjs",
   "in-source": true
  }
]
```
