type frontmatter<'a> = {
  frontmatter: string,
  body: string,
  attributes: 'a,
}

@bs.module external parse: string => frontmatter<'a> = "front-matter"
