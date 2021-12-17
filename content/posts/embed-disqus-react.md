---
title: How embed a Disqus discussion in ReScript React?
date: 2021-12-17 19:14:56
---

```
rescript@9.1.4
```

The simplest approach is to use the `disqus-react` package.

You will need to install the `disqus-react` and `prop-types` packages.

At the time of writing this was:

```
disqus-react@1.1.2
prop-types@15.7.2
```

We can then create a binding to the library

```res
// DisqusReact.res

module DiscussionEmbed = {
  type config = {
    url: string,
    identifier: string,
  }

  @module("disqus-react") @react.component
  external make: (~shortname: string, ~config: config) => React.element = "DiscussionEmbed"
}
```

And we can then use this in a ReScript React component.

Example Product page:

```res
<DisqusReact.DiscussionEmbed
  shortname="disqus-account-short-name"
  config={{
    identifier: "product-" ++ productId,
    url: "https://www.example.com/product/" ++ productId,
  }}
/>
```

