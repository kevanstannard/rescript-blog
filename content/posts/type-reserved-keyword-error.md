---
title: How to handle "type is a reserved keyword" error in ReasonML?
date: 2019-12-30 06:39:31
---

If you define a record type such as

```re
type action = {
  type: string,
  username: string,
};
```

```
Error: type is a reserved keyword, it cannot be used as an identifier. Try `type_` or `_type` instead
```

To fix this, as the error suggests, just add an `_` prefix or suffix.

However, this results in a JavaScript object with this same shape:

```re
let action = {type_: "One", value: "Smith"};
Js.log(action);

// Prints { type_: 'One', value: 'Smith' }
```

You can convert the name of the field using the BuckleScript annotation `[@bs.as "your_new_name"]`:

```re
type action = {
  [@bs.as "type"]
  type_: string,
  value: string,
};

let action = {type_: "One", value: "Smith"};
Js.log(action);

// Prints { type: 'One', value: 'Smith' }
```
