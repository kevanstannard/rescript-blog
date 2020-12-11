type md = {render: (. string) => string}

@bs.module external markdown: md = "./Markdown.js"

let render = (content: string) => markdown.render(. content)
