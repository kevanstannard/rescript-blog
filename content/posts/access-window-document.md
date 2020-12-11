---
title: How to access the window document object in ReScript?
date: 2020-12-11 19:58:32
---

ReScript version: `bs-platform@8.3.3`

As of this writing, there is an [experimental DOM binding](https://github.com/reasonml-community/bs-webapi-incubator) being developed.

However if your needs are simple you may like to create your own simple bindings.

## Bindings

```re
module Element = {
  type t
  @bs.send external innerText: (t, string) => unit = "innerText"
}

module Document = {
  type t
  @bs.send external getElementById: (t, string) => option<Element.t> = "getElementById"
}

module Window = {
  type t
  @bs.val external document: Document.t = "document"
}
```

## Example usage

```re
Window.document
->Document.getElementById("my-element")
->Belt.Option.map((el: Element.t) => el->Element.innerText("Hello"))
```

Here, we're using `Belt.Option.map()` to get access to the element value, but this could also be a `switch` statement.

This generates the JavaScript code:

```js
Belt_Option.map(document.getElementById("my-element"), function (el) {
  el.innerText("Hello");
});
```
