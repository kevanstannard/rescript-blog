---
title: Writing a simple stateful Redux store in ReasonML (without React)
date: 2019-12-12
---

## Creating our store

Firstly, we need to create a stateful store that can be mutated by actions.

Let’s create a `Store.re` module and add a type for the store.

```reasonml
type t('action, 'state) = {
  mutable state: 'state,
  reducer: ('state, 'action) => 'state,
};
```

This follows the naming convention `t` for a module. Also notice here that we’re using the `mutable` attribute for the state.

Next, add a function that creates the initial store.

```reasonml
let create = (reducer, initialState): t('action, 'state) => {
  state: initialState,
  reducer,
};
```

Plus a function for dispatching actions. This mutates the state inside the store.

```reasonml
let dispatch = (store, action): unit => {
  store.state = store.reducer(store.state, action);
};
```

Lastly, let’s add a function for extracting the state from the store.

```reasonml
let getState = (store: t('action, 'state)): 'state => store.state;
```

## Using the store

Create an `Index.re` as our main application module.

Declare our types; we’ll create a simple increment/decrement behaviour.

```reasonml
type state = {counter: int};

type action =
  | Increment
  | Decrement;
```

Next, create the reducer to process the actions.

```reasonml
let reducer = (state, action) => {
  switch (action) {
  | Increment => {counter: state.counter + 1}
  | Decrement => {counter: state.counter - 1}
  };
};
```

Now, we can create our store.

```reasonml
let initalState = {counter: 0};

let store = Store.create(reducer, initalState);
```

Let’s also create two convenience functions that operate on the store we just created:

```reasonml
let dispatch = action => Store.dispatch(store, action);

let getState = () => Store.getState(store);
```

And now we can write some code that uses the store:

```reasonml
Js.log(CounterStore.getState());

CounterStore.dispatch(CounterStore.Increment);
Js.log(CounterStore.getState());

CounterStore.dispatch(CounterStore.Increment);
Js.log(CounterStore.getState());

CounterStore.dispatch(CounterStore.Decrement);
Js.log(CounterStore.getState());

CounterStore.dispatch(CounterStore.Decrement);
Js.log(CounterStore.getState());
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
