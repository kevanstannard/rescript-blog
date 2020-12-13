// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var React = require("react");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");
var Template__Html$ReasonBlog = require("./Template__Html.bs.js");

function Template__Page(Props) {
  var page = Props.page;
  var title = Belt_Option.getWithDefault(page.title, "");
  return React.createElement(Template__Html$ReasonBlog.make, {
              title: title,
              children: null
            }, React.createElement("p", undefined, React.createElement("a", {
                      href: "index.html"
                    }, "← Back to index")), React.createElement("h1", undefined, title), React.createElement("div", {
                  dangerouslySetInnerHTML: {
                    __html: page.body
                  }
                }));
}

var make = Template__Page;

exports.make = make;
/* react Not a pure module */
