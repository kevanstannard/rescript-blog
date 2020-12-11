type page

type pageCollection

type blogPost = {
  id: string,
  date: Js.Date.t,
  title: string,
  body: string,
}

type blog = {posts: array<blogPost>}

let readPageCollection: string => Js.Promise.t<pageCollection>

let findPageById: (pageCollection, string) => option<page>

let createBlog: (
  string,
  blogPost => string,
  array<blogPost> => string,
  pageCollection,
) => Js.Promise.t<unit>
