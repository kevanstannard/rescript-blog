let blogPostToListItem = (blogPost: Pages.blogPost) => {
  <li key={blogPost.id}>
    <p className="mb-8">
      <a className="text-3xl font-bold hover:underline" href={blogPost.id ++ ".html"}>
        {ReasonReact.string(blogPost.title)}
      </a>
      <br />
      <span> {ReasonReact.string(Js.Date.toDateString(blogPost.date))} </span>
    </p>
  </li>
}

@react.component
let make = (~blogPosts: array<Pages.blogPost>) => {
  <Template__Html title="ReScript Blog">
    <h1 className="text-5xl font-black mb-12"> {ReasonReact.string("ReScript Blog")} </h1>
    <ul> {blogPosts->Js.Array2.map(blogPostToListItem)->ReasonReact.array} </ul>
  </Template__Html>
}
