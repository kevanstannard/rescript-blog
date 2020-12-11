let rawCss = "
  pre {
    border: 1px solid black
  }
"

@react.component
let make = (~title, ~children) => {
  <html>
    <head>
      <title> {ReasonReact.string(title)} </title>
      <meta charSet="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link
        rel="stylesheet"
        href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.4.1/styles/default.min.css"
      />
      <link rel="stylesheet" href="static/styles.css" />
    </head>
    <body> <div className="container"> {children} </div> </body>
  </html>
}
