module BlogPost = {
  @react.component
  let make = (~blogPost: Pages.blogPost) => {
    <p>
      <a href={blogPost.id ++ ".html"}> {React.string(blogPost.title)} </a>
      <br />
      <span> {React.string(Js.Date.toDateString(blogPost.date))} </span>
    </p>
  }
}

@react.component
let make = (~blogPosts: array<Pages.blogPost>) => {
  let title = "ReScript Blog"
  <Template__Html title={title}>
    <p> <a href="about.html"> {React.string(`About this blog →`)} </a> </p>
    <h1> {React.string(title)} </h1>
    {blogPosts
    ->Js.Array2.map(blogPost => <BlogPost key={blogPost.id} blogPost={blogPost} />)
    ->React.array}
  </Template__Html>
}
