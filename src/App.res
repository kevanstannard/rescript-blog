let pagesDir = "./content/pages"
let postsDir = "./content/posts"
let outputDir = "./docs"

module Render = {
  let prefixWithDocType = html => "<!doctype html>" ++ html

  let blogIndex = (blogPosts: array<Pages.blogPost>) => {
    let el = <Template.BlogIndex blogPosts={blogPosts} />
    ReactDOMServer.renderToString(el)->prefixWithDocType
  }

  let blogPost = (blogPost: Pages.blogPost) => {
    let el = <Template.BlogPost blogPost={blogPost} />
    ReactDOMServer.renderToString(el)->prefixWithDocType
  }

  let page = (page: Pages.page) => {
    let el = <Template.Page page={page} />
    ReactDOMServer.renderToString(el)->prefixWithDocType
  }
}

let makeBlog = () =>
  Pages.createBlog(
    ~collectionDir=postsDir,
    ~outputDir,
    ~indexName="index",
    ~renderBlogPost=Render.blogPost,
    ~renderBlogIndex=Render.blogIndex,
  )

let makePages = () =>
  Pages.createPages(~collectionDir=pagesDir, ~outputDir, ~renderPage=Render.page)

let make = () => {
  Pages.cleanDirectory(outputDir)->Js.Promise.then_(makeBlog, _)->Js.Promise.then_(makePages, _)
}
