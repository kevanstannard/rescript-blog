type md = {render: (. string) => string};

let markdownIt: md = [%bs.raw {| require("markdown-it")() |}];