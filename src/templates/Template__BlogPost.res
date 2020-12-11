@react.component
let make = (~blogPost: Pages.blogPost) => {
  <Template__Html title={blogPost.title}>
    <p className="mb-4">
      <a className="hover:underline" href={"index.html"}>
        {ReasonReact.string(`← Back to index`)}
      </a>
    </p>
    <h1 className="text-5xl font-black mb-4"> {ReasonReact.string(blogPost.title)} </h1>
    <p className="mb-12"> {ReasonReact.string(Js.Date.toDateString(blogPost.date))} </p>
    <div className="blogPostBody" dangerouslySetInnerHTML={{"__html": blogPost.body}} />
  </Template__Html>
}
