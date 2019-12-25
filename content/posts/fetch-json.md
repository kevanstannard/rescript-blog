---
title: How to fetch JSON data with ReasonML?
date: 2019-11-24
---

## Install dependencies

You will need to install two dependencies:

- [bs-fetch][1] provides a wrapper around your browser’s [Fetch API][3].
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

```reasonml
Js.Promise.(
  Fetch.fetch("https://aws.random.cat/meow")
  |> then_(Fetch.Response.json)
  |> then_(json => Js.log(json) |> resolve)
);
```

Next, let’s convert this to a function that returns the cat data.

## Declaring your API response type

In this case the response type is very simple:

```reasonml
type catData = {file: string};
```

## Converting your API response

Let’s declare a Decode module with a catData function that converts the generic `Js.Json.t` type into a proper `catData` type.

```reasonml
module Decode = {
  let catData = (data: Js.Json.t) =>
    Json.Decode.{file: field("file", string, data)};
};
```

Next we’ll create a fetchCat function to perform the fetch and convert the response.

```reasonml
let fetchCat = () =>
  Js.Promise.(
    Fetch.fetch("https://aws.random.cat/meow")
    |> then_(Fetch.Response.json)
    |> then_(obj => obj |> Decode.catData |> resolve)
  );

Js.Promise.(
  fetchCat()
  |> then_(data => data.file |> Js.log |> resolve)
);
```

## Making the fetch function more generic

Next let’s convert the fetch function into something more re-usable.

For this we can abstract out the url and the decoder.

```reasonml
let fetchJson = (url, decoder) =>
  Js.Promise.(
    Fetch.fetch(url)
    |> then_(Fetch.Response.json)
    |> then_(obj => obj |> decoder |> resolve)
  );

let fetchCat = () =>
  fetchJson("https://aws.random.cat/meow", Decode.catData);

Js.Promise.(
  fetchCat()
  |> then_(data => data.file |> Js.log |> resolve)
);
```

## Converting from a promise to an option

You may like to work with `option` values `Some` or `None` rather than promises.

Let’s convert the above code to use a callback that provides an `option` value.

```reasonml
let fetchJsonWithCallback = (url, decoder, callback) =>
  Js.Promise.(
    fetchJson(url, decoder)
    |> then_(result => callback(Some(result)) |> resolve)
    |> catch(_err => callback(None) |> resolve)
    |> ignore
  );

let fetchCatWithCallback = callback =>
  fetchJsonWithCallback(
    "https://aws.random.cat/meow",
    Decode.catData,
    callback,
  );

fetchCatWithCallback(result =>
  switch (result) {
  | None => Js.log("Fetch failed")
  | Some(catData) => Js.log(catData.file)
  }
);
```

## References

Fetching Data in ReasonML Pt. 1  
https://medium.com/@sharifsbeat/fetching-data-in-reasonml-pt-1-c06f3cc6b250

ReasonML Promise  
https://reasonml.github.io/docs/en/promise

ReasonReact Hacker News  
https://github.com/reasonml-community/reason-react-hacker-news

[1]: https://github.com/reasonml-community/bs-fetch
[2]: https://github.com/glennsl/bs-json
[3]: https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API
