@react.component
let make = (~blogPost: Pages.blogPost) => {
  <Template__Html title={blogPost.title}>
    <p> <a href="index.html"> {React.string(`← Back to index`)} </a> </p>
    <h1> {React.string(blogPost.title)} </h1>
    <p> {React.string(Js.Date.toDateString(blogPost.date))} </p>
    <div dangerouslySetInnerHTML={{"__html": blogPost.body}} />
  </Template__Html>
}
