type attributes = {
  title: string,
  date: Js.Date.t,
}

type fm = {
  frontmatter: string,
  body: string,
  attributes: attributes,
}

@bs.module external fm: string => fm = "front-matter"
