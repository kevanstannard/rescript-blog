---
title: Fetching data in React components
date: 2021-02-13 21:23:48
---

```
ReScript version: bs-platform@9.0.0
```

When fetching data within React components, we can use `XMLHttpRequest` so the requests are cancellable.

```res
// Notice that instead of `useEffect`, we have `useEffect0`. See
// reasonml.github.io/reason-react/docs/en/components#hooks for more info
React.useEffect0(() => {
  let request = makeXMLHttpRequest()
  request->addEventListener("load", () => {
    setState(_previousState => LoadedDogs((request->response->parseResponse)##message));
  })
  request->addEventListener("error", () => {
    setState(_previousState => ErrorFetchingDogs);
  })
  request->open_("GET", "https://dog.ceo/api/breeds/image/random/3");
  request->send

  // the return value is called by React's useEffect when the component unmounts
  Some(() => {
    request->abort
  })
});
```

## References

- https://forum.rescript-lang.org/t/how-do-i-perform-http-requests/251/28
- https://gist.github.com/chenglou/b6cf738a5d7adbde2ee008eb93117b49#file-fetcheddogpictures-re-L50
