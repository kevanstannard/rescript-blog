---
title: How to pass a "type" prop to an external React component
date: 2021-07-17 06:06:12
---

```
ReScript version: rescript@9.1.4
```

When passing a `type` prop to an **external** React component, we can use the `~_type` syntax for the prop name and it will be changed to `type` in the component.

For example:

```res
module Switch = {
  @react.component @module("./Switch")
  external make: (~_type: @string [@as("switch") #switch_ | #checkbox]) => React.element = "default"
}
```
