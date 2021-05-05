---
title: Writing a simple stateful Redux store in ReScript (without React)
date: 2020-12-12 16:50:00
---

```
ReScript version: bs-platform@8.4.2
```

## Creating our store

Firstly, we need to create a stateful store that can be mutated by actions.

Let’s create a `Store` module

```res
module Store = {
  type t<'action, 'state> = {
    mutable state: 'state,
    reducer: ('state, 'action) => 'state,
  }
}
```

This follows the naming convention `t` for a module. Also notice here that we’re using the `mutable` attribute for the state.

Next, add a function that creates the initial store.

```res
let create = (reducer, initialState): t<'action, 'state> => {
  state: initialState,
  reducer: reducer,
}
```

Plus a function for dispatching actions. This mutates the state inside the store.

```res
let dispatch = (store, action): unit => {
  store.state = store.reducer(store.state, action)
}
```

Lastly, let’s add a function for extracting the state from the store.

```res
let getState = (store: t<'action, 'state>): 'state => store.state
```

## Using the store

Let's write some code that uses our store module.

Declare our types; we’ll create a simple increment/decrement behaviour.

```res
type state = {counter: int}

type action =
  | Increment
  | Decrement
```

Next, create the reducer to process the actions.

```res
let reducer = (state, action) => {
  switch action {
  | Increment => {counter: state.counter + 1}
  | Decrement => {counter: state.counter - 1}
  }
}
```

Now, we can create our store.

```res
let initalState = {counter: 0}

let store = Store.create(reducer, initalState)
```

Let’s also create two convenience functions that operate on the store we just created:

```res
let dispatch = action => Store.dispatch(store, action)

let getState = () => Store.getState(store)
```

And now we can write some code that uses the store:

```res
Js.log(getState())

dispatch(Increment)
Js.log(getState())

dispatch(Increment)
Js.log(getState())

dispatch(Decrement)
Js.log(getState())

dispatch(Decrement)
Js.log(getState())
```

Which outputs:

```bash
{ counter: 0 }
{ counter: 1 }
{ counter: 2 }
{ counter: 1 }
{ counter: 0 }
```

## References

Redux in Reason  
https://github.com/reasonml-community/reductive
