type content = {
  filePath: string,
  id: string,
  date: option<Js.Date.t>,
  title: option<string>,
  body: string,
}

type contentCollection = array<content>

type blogPost = {
  id: string,
  date: Js.Date.t,
  title: string,
  body: string,
}

type page = {
  id: string,
  title: string,
  body: string,
}

type contentAttributes = {
  id: option<string>,
  title: option<string>,
  date: option<Js.Date.t>,
}

let pathBaseName = (path: string) => Path.basename(~path, ~ext=".md", ())

let parseContent = (data: string, filePath: string): content => {
  let fm = FrontMatter.parse(data)
  let {id, title, date}: contentAttributes = fm.attributes
  let body = Markdown.render(fm.body)
  let pageId = {
    switch id {
    | Some(id) => id
    | None => pathBaseName(filePath)
    }
  }
  {
    filePath: filePath,
    id: pageId,
    title: title,
    date: date,
    body: body,
  }
}

let readContentFile = (filePath: string): Js.Promise.t<content> =>
  filePath
  ->File.readFile
  ->Js.Promise.then_((content: string) => content->parseContent(filePath)->Js.Promise.resolve, _)

let readContentFiles = (filePaths: array<string>): Js.Promise.t<contentCollection> =>
  filePaths->Js.Array2.map(readContentFile)->Js.Promise.all

let readContentCollection = (dirPath: string): Js.Promise.t<contentCollection> =>
  File.glob(dirPath ++ "/*.md")->Js.Promise.then_(readContentFiles, _)

let compareDateDescending = (blogPostA: blogPost, blogPostB: blogPost) => {
  let a = blogPostA.date
  let b = blogPostB.date
  if a == b {
    0
  } else if a < b {
    1
  } else {
    -1
  }
}

let sortByDateDescending = (blogPosts: array<blogPost>): array<blogPost> =>
  blogPosts->Belt.SortArray.stableSortBy(compareDateDescending)

let contentCollectionToBlogPosts = (collection: contentCollection) => {
  let posts = Belt.Array.reduce(collection, [], (blogPosts, content): array<blogPost> => {
    let {filePath, id, date, title, body} = content
    switch (date, title) {
    | (Some(date), Some(title)) => {
        let blogPost: blogPost = {id: id, date: date, title: title, body: body}
        Belt.Array.concat(blogPosts, [blogPost])
      }
    | (None, _) => {
        Js.log("date missing in " ++ filePath)
        blogPosts
      }
    | (_, None) => {
        Js.log("title missing in " ++ filePath)
        blogPosts
      }
    }
  })
  posts->sortByDateDescending
}

let contentCollectionToPages = (collection: contentCollection) => {
  Belt.Array.reduce(collection, [], (pages, content): array<page> => {
    let {filePath, id, title, body} = content
    switch title {
    | Some(title) => {
        let page: page = {id: id, title: title, body: body}
        Belt.Array.concat(pages, [page])
      }

    | None => {
        Js.log("title missing in " ++ filePath)
        pages
      }
    }
  })
}

let ensureDirectoryExists = (dir: string) =>
  if !Fs.existsSync(dir) {
    Fs.mkdirSync(dir)->ignore
  }

let deleteDirectoryContents = (dir: string) =>
  Js.Promise.make((~resolve, ~reject) => {
    let glob = dir ++ "/**/*"
    Rimraf.rimraf(.glob, error => {
      let errorOpt = Js.Nullable.toOption(error)
      switch errorOpt {
      | Some(_error) => reject(. Failure("Error deleting the directory " ++ dir))
      | None =>
        let unit = ()
        resolve(. unit)
      }
    })
  })

let writeBlogPost = (
  outputDir: string,
  renderBlogPost: blogPost => string,
  blogPost: blogPost,
): Js.Promise.t<unit> => {
  let html = blogPost->renderBlogPost
  let filePath = outputDir ++ "/" ++ blogPost.id ++ ".html"
  File.writeFile(filePath, html)
}

let writeBlogIndex = (
  outputDir: string,
  indexName: string,
  renderBlogIndex: array<blogPost> => string,
  blogPosts: array<blogPost>,
): Js.Promise.t<unit> => {
  let html = blogPosts->renderBlogIndex
  let filePath = outputDir ++ "/" ++ indexName ++ ".html"
  File.writeFile(filePath, html)
}

let createBlogFromCollection = (
  outputDir: string,
  indexName: string,
  renderBlogPost: blogPost => string,
  renderBlogIndex: array<blogPost> => string,
  collection: contentCollection,
) => {
  let blogPosts = collection->contentCollectionToBlogPosts

  let createPosts = () => {
    blogPosts
    ->Belt.Array.map(writeBlogPost(outputDir, renderBlogPost))
    ->Js.Promise.all
    ->Js.Promise.then_(_ => Js.Promise.resolve(), _)
  }

  let createIndex = () => {
    writeBlogIndex(outputDir, indexName, renderBlogIndex, blogPosts)
  }

  ensureDirectoryExists(outputDir)

  createPosts()->Js.Promise.then_(createIndex, _)
}

let writePage = (outputDir: string, renderPage: page => string, page: page): Js.Promise.t<unit> => {
  let html = page->renderPage
  let filePath = outputDir ++ "/" ++ page.id ++ ".html"
  File.writeFile(filePath, html)
}

let createPagesFromCollection = (
  outputDir: string,
  renderPage: page => string,
  collection: contentCollection,
) => {
  ensureDirectoryExists(outputDir)
  collection
  ->contentCollectionToPages
  ->Belt.Array.map(writePage(outputDir, renderPage))
  ->Js.Promise.all
  ->Js.Promise.then_(_ => Js.Promise.resolve(), _)
}

let cleanDirectory = (dir: string) => {
  deleteDirectoryContents(dir)
}

let createBlog = (~collectionDir, ~outputDir, ~indexName, ~renderBlogPost, ~renderBlogIndex) => {
  readContentCollection(collectionDir)->Js.Promise.then_(
    createBlogFromCollection(outputDir, indexName, renderBlogPost, renderBlogIndex),
    _,
  )
}

let createPages = (collectionDir, outputDir, renderPage) => {
  readContentCollection(collectionDir)->Js.Promise.then_(
    createPagesFromCollection(outputDir, renderPage),
    _,
  )
}
