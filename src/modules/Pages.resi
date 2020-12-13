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

let findContentById: (contentCollection, string) => option<content>

let cleanDirectory: string => Js.Promise.t<unit>

let createBlog: (
  string,
  string,
  blogPost => string,
  array<blogPost> => string,
) => Js.Promise.t<unit>

let createPages: (string, string, page => string) => Js.Promise.t<unit>
