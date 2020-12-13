@react.component
let make = (~page: Pages.page) => {
  let title = Belt.Option.getWithDefault(page.title, "")
  <Template__Html title={title}>
    <p> <a href="index.html"> {ReasonReact.string(`← Back to index`)} </a> </p>
    <h1> {ReasonReact.string(title)} </h1>
    <div dangerouslySetInnerHTML={{"__html": page.body}} />
  </Template__Html>
}
