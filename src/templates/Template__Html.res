@react.component
let make = (~title, ~children) => {
  <html>
    <head>
      <title> {ReasonReact.string(title)} </title>
      <meta charSet="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet" />
      <link
        rel="stylesheet"
        href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.4.1/styles/default.min.css"
      />
    </head>
    <body> <div className="p-10"> {children} </div> </body>
  </html>
}
