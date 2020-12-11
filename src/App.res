let postsDir = "./content/posts"
let blogDir = "./docs"

let renderBlogIndex = (blogPosts: array<Pages.blogPost>) => {
  let el = <Template.BlogIndex blogTitle="ReScript Blog" blogPosts={blogPosts} />
  let html = ReactDOMServer.renderToString(el)
  "<!DOCTYPE HTML>" ++ html
}

let renderBlogPost = (blogPost: Pages.blogPost) => {
  let el = <Template.BlogPost blogPost={blogPost} />
  let html = ReactDOMServer.renderToString(el)
  "<!DOCTYPE HTML>" ++ html
}

let makeBlog = () => {
  let createBlog = Pages.createBlog(blogDir, renderBlogPost, renderBlogIndex)
  Pages.readPageCollection(postsDir)->Js.Promise.then_(createBlog, _)
}

let make = () => {
  makeBlog()
}
