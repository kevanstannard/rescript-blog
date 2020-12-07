type fm<'a> = {
  frontmatter: string,
  body: string,
  attributes: 'a,
}

@bs.module external fm: string => fm<'a> = "front-matter"
