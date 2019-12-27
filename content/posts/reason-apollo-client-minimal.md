---
title: Minimal ReasonML and GraphQL Apollo Client
date: 2019-12-27 17:41:36
---

## Prerequisites

You will need a working GraphQL server.

For this example we will use a public [Star Wars GraphQL API](http://apis.guru/graphql-apis/).

Or, you may like to browse other [public GraphQL APIs](http://apis.guru/graphql-apis/).

## Versions used in this example

| Package                 | Version |
| ----------------------- | ------- |
| bs-platform             | 7.0.1   |
| reason-apollo           | 0.18.0  |
| @baransu/graphql_ppx_re | 0.4.6   |
| graphql                 | 14.5.8  |

## Install BuckleScript globally

```
yarn global add bs-platform
```

## Create the project

```bash
bsb -init reason-apollo-simple -theme react-starter
cd ./reason-apollo-simple
yarn
```

## Test the project is working

```bash
yarn build
yarn server
```

Then browse to http://localhost:8000/

## Install Apollo GraphQL dependencies

```bash
yarn add reason-apollo
yarn add --dev @baransu/graphql_ppx_re
```

## Update bsconfig.json

Add `reason-apollo` to the `bs-dependencies` and add `ppx-flags` for `graphql_ppx_re`:

```json
"bs-dependencies": [
  "reason-react",
  "reason-apollo"
],
"ppx-flags": ["@baransu/graphql_ppx_re/ppx6"],
```

## Write code for sending an introspection query

I couldn't figure out a nice way to do this.

This is a slightly modified version of [sendIntrospectionQuery.js](https://github.com/mhallin/graphql_ppx/blob/master/sendIntrospectionQuery.js) from the [graphql_ppx](https://github.com/mhallin/graphql_ppx) package.

Install dependencies.

```bash
yarn add --dev yargs
yarn add --dev request
```

Create a new file `./tools/send-introspection-query.js`.

Add the content:

```js
const argv = require("yargs").argv;
const request = require("request");
const fs = require("fs");
const { getIntrospectionQuery } = require("graphql");

const requestOptions = {
  json: true,
  body: { query: getIntrospectionQuery() },
  headers: { "user-agent": "node.js", ...argv.headers }
};

request.post(argv._[0], requestOptions, function(error, response, body) {
  if (error) {
    console.error("Could not send introspection query: ", error);
    process.exit(1);
  }

  if (response.statusCode !== 200) {
    console.error(
      "Non-ok status code from API: ",
      response.statusCode,
      response.statusMessage
    );
    process.exit(1);
  }

  var result = JSON.stringify(body, null, 2);

  fs.writeFileSync("graphql_schema.json", result, { encoding: "utf-8" });
});
```

Then add a new script to your `package.json` file:

```
"send-introspection-query": "node ./tools/send-introspection-query"
```

## Run the introspection query

```bash
yarn send-introspection-query https://swapi-graphql.netlify.com/.netlify/functions/index
```

If successful, this will generate a `graphql_schema.json` file in the root of your project.

## Create the Apollo Client

Now we can start following the instructions on the [reason-apollo](https://github.com/apollographql/reason-apollo) site.

Create the file `src/Client.re`

```reasonml
/* Create an InMemoryCache */
let inMemoryCache = ApolloInMemoryCache.createInMemoryCache();

/* Create an HTTP Link */
let httpLink =
  ApolloLinks.createHttpLink(~uri="https://swapi-graphql.netlify.com/.netlify/functions/index", ());

let instance =
  ReasonApollo.createApolloClient(~link=httpLink, ~cache=inMemoryCache, ());
```

## Add the provider

Change the render code in `src/Index.re` from this:

```reasonml
ReactDOMRe.renderToElementWithId(<App />, "root");
```

to this:

```reasonml
ReactDOMRe.renderToElementWithId(
  <ReasonApollo.Provider client=Client.instance>
    <App />
  </ReasonApollo.Provider>,
  "root",
);
```

## Add the query

Next add a file `src/Movies.re` and add the GraphQL query:

```reasonml
module GetMovies = [%graphql
  {|
    query {
      allFilms {
        films {
          id
          title
        }
      }
    }
  |}
];

module GetMoviesQuery = ReasonApollo.CreateQuery(GetMovies);
```

## Add a type

Let's also add a type for the film titles we will be displaying:

```reasonml
type film = {
  id: string,
  title: string,
};
```

## Handle the API response

Next add a function for handling the API response.
The response `option` values, so parsing it is a bit involved:

```reasonml
let responseToFilms = response =>
  response##allFilms
  ->Belt.Option.flatMap(allFilms => allFilms##films)
  ->Belt.Option.mapWithDefault([||], film => film)
  |> Array.fold_left(
       (acc, filmOpt) => {
         switch (filmOpt) {
         | Some(film) =>
           let id = film##id;
           let titleOpt = film##title;
           switch (titleOpt) {
           | Some(title) => Array.append(acc, [|{id, title}|])
           | None => acc
           };
         | None => acc
         }
       },
       [||],
     );
```

## Add the component

Lastly, now we can add the component to the same file:

```reasonml
[@react.component]
let make = () => {
  let getMoviesQuery = GetMovies.make();
  <GetMoviesQuery variables=getMoviesQuery##variables>
    ...{({result}) =>
      switch (result) {
      | Loading => <div> {React.string("Loading")} </div>
      | Error(error) => <div> {React.string(error##message)} </div>
      | Data(response) =>
        let films = responseToFilms(response);
        <ul>
          {films
           |> Array.map(film =>
                <li key={film.id}> {React.string(film.title)} </li>
              )
           |> React.array}
        </ul>;
      }
    }
  </GetMoviesQuery>;
};
```

## Updating the App component

Lastly, let's update the `App` component in `src/App.re`. Replace the file with the following content:

```reasonml
[@react.component]
let make = () => {
  <Movies />;
};
```
