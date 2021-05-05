---
title: ReScript Polymorphic Variants
date: 2020-12-12 14:37:31
---

```
ReScript version: bs-platform@8.4.2
```

Polymorphic variants are distinguished from ordinary variants by the leading hash.

Unlike ordinary variants, polymorphic variants can be used without an explicit type declaration.

Example:

```res
let status = #yes

let statusString = {
  switch status {
  | #yes => "Yes"
  | #no => "No"
  }
}
```

However they may be assigned to a type:

```res
type color = [#red | #green | #blue]

let colorToString = (color: color): string => {
  switch color {
  | #red => "Red"
  | #green => "Green"
  | #blue => "Blue"
  }
}
```
