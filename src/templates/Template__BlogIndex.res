let blogPostToListItem = (blogPost: Pages.blogPost) => {
  <li key={blogPost.id}>
    <p>
      <a href={blogPost.id ++ ".html"}> {ReasonReact.string(blogPost.title)} </a>
      <br />
      <span> {ReasonReact.string(Js.Date.toDateString(blogPost.date))} </span>
    </p>
  </li>
}

@react.component
let make = (~blogTitle: string, ~blogPosts: array<Pages.blogPost>) => {
  <Template__Html title={blogTitle}>
    <h1> {ReasonReact.string(blogTitle)} </h1>
    <ul> {blogPosts->Js.Array2.map(blogPostToListItem)->ReasonReact.array} </ul>
  </Template__Html>
}
