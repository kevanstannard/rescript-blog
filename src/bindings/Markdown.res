type md = {render: (. string) => string}

@bs.module external markdownIt_: unit => md = "markdown-it"

let markdownIt: md = markdownIt_()
