module BlogPost = {
  @react.component
  let make = (~blogPost: Pages.blogPost) => {
    <p>
      <a href={blogPost.id ++ ".html"}> {ReasonReact.string(blogPost.title)} </a>
      <br />
      <span> {ReasonReact.string(Js.Date.toDateString(blogPost.date))} </span>
    </p>
  }
}

@react.component
let make = (~blogPosts: array<Pages.blogPost>) => {
  let title = "ReScript Blog"
  <Template__Html title={title}>
    <p> <a href="about.html"> {ReasonReact.string(`About this blog →`)} </a> </p>
    <h1> {ReasonReact.string(title)} </h1>
    {blogPosts
    ->Js.Array2.map(blogPost => <BlogPost key={blogPost.id} blogPost={blogPost} />)
    ->ReasonReact.array}
  </Template__Html>
}
