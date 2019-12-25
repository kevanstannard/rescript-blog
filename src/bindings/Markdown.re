type markdownItem = {
  content: string,
  data: Js.Dict.t(string),
  excerpt: string,
};

[@bs.module "read-markdown"]
external readMarkdown: string => Js.Promise.t(Js.Dict.t(markdownItem)) =
  "default";

type markdown = {toHTML: (. string) => string};

[@bs.module "markdown"] external markdown: markdown = "markdown";

type md = {render: (. string) => string};

let markdownIt: md = [%bs.raw {| require("markdown-it")() |}];