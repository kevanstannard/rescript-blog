let postsDir = "./content/posts"
let blogDir = "./docs"

let prefixWithDocType = html => "<!doctype html>" ++ html

let renderBlogIndex = (blogPosts: array<Pages.blogPost>) => {
  let el = <Template.BlogIndex blogPosts={blogPosts} />
  ReactDOMServer.renderToString(el)->prefixWithDocType
}

let renderBlogPost = (blogPost: Pages.blogPost) => {
  let el = <Template.BlogPost blogPost={blogPost} />
  ReactDOMServer.renderToString(el)->prefixWithDocType
}

let makeBlog = () => {
  let createBlog = Pages.createBlog(blogDir, renderBlogPost, renderBlogIndex)
  Pages.readPageCollection(postsDir)->Js.Promise.then_(createBlog, _)
}

let make = () => {
  makeBlog()
}
