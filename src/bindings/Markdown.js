const hljs = require("highlight.js");

const md = require("markdown-it")({
  linkify: true,
  highlight: function (code, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        return hljs.highlight(code, { language: re }).value;
      } catch (__) {}
    }
    return "";
  },
});

md.linkify.set({ fuzzyEmail: false });

module.exports = md;
