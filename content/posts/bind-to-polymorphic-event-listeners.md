---
title: How to bind to polymorphic event listeners in ReScript?
date: 2022-02-24 13:07:32
---

```
ReScript version: rescript@9.1.4
```

Service worker binding example.

```res
module Self = {
  type t

  @val external instance: t = "self"

  // Keep unsafe addEventListener private, and consumers
  // may only use the safe event listener functions.
  %%private(
    @send
    external addEventListener: (t, [#install | #activate | #fetch], 'a => unit) => unit =
      "addEventListener"
  )

  let addInstallEventListener: (t, InstallEvent.t => unit) => unit = (self, cb) =>
    addEventListener(self, #install, cb)

  let addActivateEventListener: (t, ActivateEvent.t => unit) => unit = (self, cb) =>
    addEventListener(self, #activate, cb)

  let addFetchEventListener: (t, FetchEvent.t => unit) => unit = (self, cb) =>
    addEventListener(self, #fetch, cb)
}
```
