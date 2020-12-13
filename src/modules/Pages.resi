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

let readContentCollection: string => Js.Promise.t<contentCollection>

let cleanDirectory: string => Js.Promise.t<unit>

let createBlog: (
  ~collectionDir: string,
  ~outputDir: string,
  ~indexName: string,
  ~renderBlogPost: blogPost => string,
  ~renderBlogIndex: array<blogPost> => string,
) => Js.Promise.t<unit>

let createPages: (string, string, page => string) => Js.Promise.t<unit>
