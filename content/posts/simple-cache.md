---
title: How to create a simple cache in ReScript
date: 2020-12-18 06:33:58
---

In this post, let's consider caching a database connection.

For this post consider a mock connection function and omit callbacks or promises to make the code simpler.

```re
module Database = {
  type client = {id: string}
  let connect = (id: string): client => {id: id}
}
```

## Example 1: Caching using a ref

```re
let cache: Pervasives.ref<option<Database.client>> = ref(None)

let connect = () => {
  switch cache.contents {
  | Some(client) => client
  | None => {
      let client = Database.connect("abc")
      cache.contents = Some(client)
      client
    }
  }
}
```

## Example 2: Caching using a Dict

```re
let cache: Js.Dict.t<Database.client> = Js.Dict.empty()

let connect = () => {
  let key: string = "client"
  let optClient = Js.Dict.get(cache, key)
  switch optClient {
  | Some(client) => client
  | None => {
      let client = Database.connect("abc")
      Js.Dict.set(cache, key, client)
      client
    }
  }
}
```
