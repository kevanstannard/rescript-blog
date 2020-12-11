@react.component
let make = (~title, ~children) => {
  <html>
    <head> <title> {ReasonReact.string(title)} </title> </head> <body> {children} </body>
  </html>
}
