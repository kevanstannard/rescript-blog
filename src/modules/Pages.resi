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

let readPageCollection: string => Js.Promise.t<pageCollection>

let findPageById: (pageCollection, string) => option<page>

let cleanDirectory: string => Js.Promise.t<unit>

let createBlog: (
  string,
  blogPost => string,
  array<blogPost> => string,
  pageCollection,
) => Js.Promise.t<unit>

let createPages: (string, page => string, pageCollection) => Js.Promise.t<unit>
