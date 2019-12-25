var Markdown = require("markdown").markdown;
console.log(Markdown.toHTML("```\nhello\n```"));

/*
var Path = require("path");
var path = "/aaa/bbb/ccc.md";
console.log(Path.basename(path, undefined));
console.log(Path.basename(path, ".md"));
*/

/*
var path = require("path");
var p1 = path.basename("/foo/bar/baz/asdf/quux.html", undefined);
var p2 = path.basename("/foo/bar/baz/asdf/quux.html", ".html");
console.log(p1);
console.log(p2);
*/

/*
var path = "/Users/kevan.stannard/dev/reason-blog";

var readMarkdown = require("read-markdown").default;

readMarkdown("/Users/kevan.stannard/dev/reason-blog/content/posts/*.md")
  .then(function(data) {
    console.log(data);
  })
  .catch(console.error);
*/
