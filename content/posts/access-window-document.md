---
title: How to access the window document object in ReasonML?
date: 2019-12-27 16:13:48
---

You can access it with the following binding code:

```reasonml
[@bs.val] external document: Js.t({..}) = "document";
```

_Note that this provides raw access to the document object with no type safety for it's properties._

## Example

```reasonml
[@bs.val] external document: Js.t({..}) = "document";
let root = document##getElementById("root");
root##innerText #= "Hello";
```

This generates the JsvsScript code:

```js
var root = document.getElementById("root");
root.innerText = "Hello";
```

## Notes about the binding

- `[@bs.val] external` enables binding to an existing external value.
- `document` is the ReasonML variable name to create.
- `Js.t({..})` is the type of the ReasonML variable. In this case this is the type of a "open" JavaScript object where the properties are not declared. Properties are accessed using `##`.
- `"document"` is the external value to bind to.
