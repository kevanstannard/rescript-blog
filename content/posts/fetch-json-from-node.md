---
title: How to fetch JSON data from Node?
date: 2021-07-04 05:32:23
---

```
ReScript version: rescript@9.1.3
```

Use ad-hoc fetching:

```res
%%raw(`
const fetch = require('node-fetch');
if (!globalThis.fetch) {
	globalThis.fetch = fetch;
}
`)

module Fetch = {
  module Response = {
    type t<'a>
    @send external json: t<'a> => Promise.t<'a> = "json"
  }
}

module Xkcd = {
  type comic = {
    img: string,
    title: string,
  }

  @val external fetch: string => Promise.t<Fetch.Response.t<comic>> = "fetch"

  let fetchCurrentComic = () =>
    fetch("http://xkcd.com/info.0.json")->Promise.then(Fetch.Response.json)
}

Xkcd.fetchCurrentComic()
->Promise.thenResolve(result => {
  Js.log(result)
})
->Promise.catch(error => {
  Js.log(error)
  Promise.resolve()
})
->ignore
```
