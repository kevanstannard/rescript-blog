---
title: Minimal Hello World using Apollo GraphQL and ReasonML
author: kevan-stannard
date: 2019-12-8 09:00
template: article.pug
---

## Overview

This is an absolutely bare-bones, minimal example application to demonstrate:

- Apollo GraphQL on the server.
- ReasonML on the client.

## Server code

Our server code does the following:

1. Accepts a GraphQL query “hello”, and
2. Responds with the text “World”.

Create a `package.json` file.

```
{
  "name": "hello-server",
  "private": true
}
```

Install our dependencies:

```
yarn add express
yarn add graphql
yarn add apollo-server
yarn add apollo-server-express
```

Create `src/index.js` for the server application.

```js
const express = require("express");
const { ApolloServer, gql } = require("apollo-server-express");

// Declare the GraphQL types.
// Here, we support a query "hello" that returns a string.
const typeDefs = gql`
  type Query {
    hello: String!
  }
`;

// Declare a function to execute when we send the "hello" query.
// Here, we wait a couple of seconds and return the string "World".
const helloQuery = () =>
  new Promise(resolve => {
    setTimeout(() => {
      resolve("World");
    }, 2000);
  });

// Declare the GraphQL resolvers.
// These map queries to implementations.
const resolvers = {
  Query: {
    hello: helloQuery
  }
};

// Create and start the server
const server = new ApolloServer({ typeDefs, resolvers });
const app = express();
server.applyMiddleware({ app });

const port = 4000;
app.listen({ port }, () =>
  console.log(`Server ready at http://localhost:${port}${server.graphqlPath}`)
);
```

Add a script to `package.json` that starts the server.

```
"scripts": {
  "start": "node src/index"
},
```

Start the server:

```
yarn start
```

Test that the server is working, by browsing to http://localhost:4000/graphql

Enter the following GraphQL query:

```graphql
query {
  hello
}
```

You should see the response:

```graphql
{
  "data": {
    "hello": "World"
  }
}
```

## Client

Create a minimal package.json:

```
{
  "name": "hello-client",
  "private": true
}
```

Install our application dependencies:

```
yarn add --exact react
yarn add --exact react-dom
yarn add --exact reason-apollo
yarn add --exact reason-react
```

Install our development dependencies:

```
yarn add --exact bs-platform@5.2.1
yarn add --exact graphql_ppx
yarn add --exact html-webpack-plugin
yarn add --exact webpack
yarn add --exact webpack-cli
yarn add --exact webpack-dev-server
```

**Important: At the time of writing (December 2019) you must install bs-platform@5.2.1. [Later versions are not yet compatible with reason-apollo.][1]**

Add some useful scripts to `package.json`:

```
"scripts": {
  "re:build": "bsb -make-world -clean-world",
  "re:watch": "bsb -make-world -clean-world -w",
  "build": "webpack",
  "start": "webpack-dev-server"
},
```

Add a `bsconfig.json` file:

```
{
  "name": "hello-client",
  "reason": { "react-jsx": 3 },
  "bsc-flags": ["-bs-super-errors"],
  "sources": [
    {
      "dir": "src",
      "subdirs": true
    }
  ],
  "package-specs": [
    {
      "module": "es6",
      "in-source": true
    }
  ],
  "suffix": ".bs.js",
  "namespace": true,
  "bs-dependencies": ["reason-react", "reason-apollo"],
  "ppx-flags": ["graphql_ppx/ppx"],
  "refmt": 3
}
```

Generate a GraphQL schema file for the client. This will generate a `graphql_schema.json` file.

```
yarn send-introspection-query http://localhost:4000/graphql
```

The `graphql_schema.json` file contains the types for the queries that the server is handling. The reason-apollo package uses these types to ensure that our handling of the responses is type safe.

Add a `webpack.config.js` file:

```js
const HtmlWebpackPlugin = require("html-webpack-plugin");
const path = require("path");
module.exports = {
  entry: "./src/Index.bs.js",
  mode: "development",
  plugins: [new HtmlWebpackPlugin({ template: "templates/index.html" })],
  devServer: {
    contentBase: path.join(__dirname, "build"),
    port: 9000
  }
};
```

Add a template for the application in `templates/index.html`:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Hello Client</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
</html>
```

Create a `src/Index.re` file:

```reasonml
ReactDOMRe.renderToElementWithId(
  <ReasonApollo.Provider client=Client.instance>
    <App />
  </ReasonApollo.Provider>,
  "root",
);
```

Create a `src/Client.re` file:

```reasonml
let inMemoryCache = ApolloInMemoryCache.createInMemoryCache();

let httpLink =
  ApolloLinks.createHttpLink(~uri="http://localhost:4000/graphql", ());

let instance =
  ReasonApollo.createApolloClient(~link=httpLink, ~cache=inMemoryCache, ());
```

Create a `src/App.re` file:

```reasonml
/* Create a GraphQL Query by using the graphql_ppx */
module GetHello = [%graphql {|
  query getHello {
    hello
  }
|}];

module GetHelloQuery = ReasonApollo.CreateQuery(GetHello);

[@react.component]
let make = () => {
  <GetHelloQuery>
    ...{({result}) =>
      switch (result) {
      | Loading =>
        <div> {ReasonReact.string("Loading")} </div>
      | Error(error) =>
        <div> {ReasonReact.string(error##message)} </div>
      | Data(response) =>
        <div>
          {ReasonReact.string("Hello")}
          {ReasonReact.string(response##hello)}
        </div>
      }
    }
  </GetHelloQuery>;
};
```

Start the client application

```
yarn start
```

You should then be able to browse to http://localhost:9000

In the browser see:

```
HelloWorld
```

## References

ReasonApollo installation  
https://github.com/apollographql/reason-apollo

ReasonReact installation  
https://reasonml.github.io/reason-react/docs/en/installation.html

[1]: https://github.com/apollographql/reason-apollo/issues/215
