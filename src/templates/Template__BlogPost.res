@react.component
let make = (~blogPost: Pages.blogPost) => {
  <Template__Html title={blogPost.title}>
    <p> <a href={"index.html"}> {ReasonReact.string(`← Back to index`)} </a> </p>
    <h1> {ReasonReact.string(blogPost.title)} </h1>
    <p> {ReasonReact.string(Js.Date.toDateString(blogPost.date))} </p>
    <div dangerouslySetInnerHTML={{"__html": blogPost.body}} />
  </Template__Html>
}
