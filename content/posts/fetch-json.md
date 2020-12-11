---
title: How to fetch JSON data with ReScript?
date: 2020-12-12 05:55:14
---

```
ReScript version: bs-platform@8.4.2
```

## Install dependencies

You will need to install two dependencies:

- [bs-fetch][1] provides a wrapper around your browser's [Fetch API][3].
- [bs-json][2] provides JSON decoding functions.

## Preparing your data source

You may already have an API available, but if you are just experimenting you may like to use an API from public-apis.
We’ll be using one of the public APIs that provides random pictures of cats.

```
https://aws.random.cat/meow
```

This has a JSON response that looks like:

```
{
  file: "https://purr.objects-us-east-1.dream.io/i/w8V75.jpg"
}
```

## Fetching the data

We can do a simple JSON fetch using the following:

```re
let _ =
  Fetch.fetch("https://aws.random.cat/meow")
  ->Js.Promise.then_(Fetch.Response.json, _)
  ->Js.Promise.then_(json => Js.log(json)->Js.Promise.resolve, _)
```

Next, let’s convert this to a function that returns the cat data.

## Declaring your API response type

In this case the response type is very simple:

```re
type catData = {file: string};
```

## Converting your API response

Let's declare a Decode module with a catData function that converts the generic `Js.Json.t` type into a proper `catData` type.

```re
module Decode = {
  open Json.Decode
  let catData = (data: Js.Json.t) => {
    file: field("file", string, data),
  }
}
```

Next we’ll create a fetchCat function to perform the fetch and convert the response.

```re
let fetchCat = () =>
  Fetch.fetch("https://aws.random.cat/meow")
  ->Js.Promise.then_(Fetch.Response.json, _)
  ->Js.Promise.then_(obj => obj->Decode.catData->Js.Promise.resolve, _)

let _ = fetchCat()->Js.Promise.then_(data => data.file->Js.log->Js.Promise.resolve, _)
```

## Making the fetch function more generic

Next let’s convert the fetch function into something more re-usable.

For this we can abstract out the url and the decoder.

```re
let fetchJson = (url, decoder) =>
  Fetch.fetch(url)
  ->Js.Promise.then_(Fetch.Response.json, _)
  ->Js.Promise.then_(obj => obj->decoder->Js.Promise.resolve, _)

let fetchCat = () => fetchJson("https://aws.random.cat/meow", Decode.catData)

let _ = fetchCat()->Js.Promise.then_(data => data.file->Js.log->Js.Promise.resolve, _)
```

[1]: https://github.com/reasonml-community/bs-fetch
[2]: https://github.com/glennsl/bs-json
[3]: https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API
