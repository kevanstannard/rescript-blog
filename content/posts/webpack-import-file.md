---
title: Importing files using Webpack
date: 2021-05-27 10:15:23
---

```
ReScript version: rescript@9.1.2
```

```res
module Webpack = {
  type url = {href: string, pathname: string}

  @scope(("import", "meta")) @val external importMetaUrl: string = "url"
  @new external makeFileUrl: (string, string) => url = "URL"
}

let url = Webpack.makeFileUrl("./images/logo.png", Webpack.importMetaUrl)
```

Which produces a URL that can be used in front end code.

```js
var url = new URL("./images/logo.png", import.meta.url);
```
