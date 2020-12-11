let blogPostToListItem = (blogPost: Pages.blogPost) => {
  <p key={blogPost.id}>
    <a href={blogPost.id ++ ".html"}> {ReasonReact.string(blogPost.title)} </a>
    <br />
    <span> {ReasonReact.string(Js.Date.toDateString(blogPost.date))} </span>
  </p>
}

@react.component
let make = (~blogPosts: array<Pages.blogPost>) => {
  <Template__Html title="ReScript Blog">
    <h1> {ReasonReact.string("ReScript Blog")} </h1>
    {blogPosts->Js.Array2.map(blogPostToListItem)->ReasonReact.array}
  </Template__Html>
}
