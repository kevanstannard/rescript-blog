type page = {
  filePath: string,
  id: string,
  date: option<Js.Date.t>,
  title: option<string>,
  body: string,
}

type pageCollection = array<page>

type blogPost = {
  id: string,
  date: Js.Date.t,
  title: string,
  body: string,
}

type blog = {posts: array<blogPost>}

type attributes = {
  id: option<string>,
  title: option<string>,
  date: option<Js.Date.t>,
}

let pathBaseName = (path: string) => Path.basename(~path, ~ext=".md", ())

let parsePage = (data: string, filePath: string): page => {
  let fmData = FrontMatter.fm(data)
  let {id, title, date}: attributes = fmData.attributes
  let body = Markdown.render(fmData.body)
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

let readPage = (filePath: string): Js.Promise.t<page> =>
  filePath
  ->File.readFile
  ->Js.Promise.then_((content: string) => content->parsePage(filePath)->Js.Promise.resolve, _)

let readPages = (filePaths: array<string>): Js.Promise.t<pageCollection> =>
  filePaths->Js.Array2.map(readPage)->Js.Promise.all

let compareDateDescending = (pageA: page, pageB: page) => {
  switch (pageA.date, pageB.date) {
  | (Some(a), Some(b)) =>
    if a == b {
      0
    } else if a < b {
      1
    } else {
      -1
    }
  | _ => 0
  }
}

let sortByDateDescending = (collection: pageCollection): pageCollection =>
  collection->Belt.SortArray.stableSortBy(compareDateDescending)

let readPageCollection = (dirPath: string): Js.Promise.t<pageCollection> =>
  File.readMarkdownFilePaths(dirPath)
  ->Js.Promise.then_(readPages, _)
  ->Js.Promise.then_(collection => sortByDateDescending(collection)->Js.Promise.resolve, _)

let findPageById = (collection: pageCollection, id: string): option<page> =>
  collection->Js.Array2.find((page: page) => page.id == id)

let pageCollectionToBlogPosts = (collection: pageCollection) => {
  Belt.Array.reduce(collection, [], (blogPosts, page): array<blogPost> => {
    let {filePath, id, date, title, body} = page
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
}

let ensureDirectoryExists = (dir: string) =>
  if !Fs.existsSync(dir) {
    Fs.mkdirSync(dir)->ignore
  }

let deleteDirectoryContents = (dir: string) => Js.Promise.make((~resolve, ~reject) => {
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
  renderBlogIndex: array<blogPost> => string,
  blogPosts: array<blogPost>,
): Js.Promise.t<unit> => {
  let html = blogPosts->renderBlogIndex
  let filePath = outputDir ++ "/index.html"
  File.writeFile(filePath, html)
}

let createBlog = (
  outputDir: string,
  renderBlogPost: blogPost => string,
  renderBlogIndex: array<blogPost> => string,
  collection: pageCollection,
) => {
  let blogPosts = collection->pageCollectionToBlogPosts

  let createPosts = () => {
    blogPosts
    ->Belt.Array.map(writeBlogPost(outputDir, renderBlogPost))
    ->Js.Promise.all
    ->Js.Promise.then_(_ => Js.Promise.resolve(), _)
  }

  let createIndex = () => {
    writeBlogIndex(outputDir, renderBlogIndex, blogPosts)
  }

  ensureDirectoryExists(outputDir)

  deleteDirectoryContents(outputDir)
  ->Js.Promise.then_(createPosts, _)
  ->Js.Promise.then_(createIndex, _)
}
