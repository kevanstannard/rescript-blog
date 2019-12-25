type attributes = {
  title: string,
  date: Js.Date.t,
};

type fm = {
  frontmatter: string,
  body: string,
  attributes,
};

let fm: string => fm = [%bs.raw {| require("front-matter") |}];