type post = {
  key: string,
  content: string,
  data: Js.Dict.t(string),
};

let postsDir = "./content/posts";
let docsDir = "./docs";

let makeDocsDir = () =>
  if (!Fs.existsSync(docsDir)) {
    Fs.mkdirSync(docsDir) |> ignore;
  };

let pathToKey = path => Path.basename(~path, ~ext=".md", ());

let resultToPosts =
    (result: Js.Dict.t(Markdown.markdownItem)): Js.Promise.t(list(post)) => {
  let paths = Js.Dict.keys(result);
  let posts =
    paths
    |> Array.fold_left(
         (acc, path) => {
           Js.log(path);
           switch (Js.Dict.get(result, path)) {
           | None => acc
           | Some(markdownItem) =>
             let post = {
               key: pathToKey(path),
               content: markdownItem.content,
               data: markdownItem.data,
             };
             List.append(acc, [post]);
           };
         },
         [],
       );
  Js.Promise.resolve(posts);
};

let writePost = post => {
  let fileName = docsDir ++ "/" ++ post.key ++ ".html";
  Js.log2("Writing", fileName);
  Fs.writeFile(fileName, post.content, error => {Js.log(error)});
};

let handlePosts = (posts: list(post)) => {
  makeDocsDir();
  posts |> List.map(writePost) |> ignore;
  Js.Promise.resolve();
};

/*
 Markdown.readMarkdown(postsDir ++ "/ *.md")
 |> Js.Promise.then_(resultToPosts)
 |> Js.Promise.then_(handlePosts);
 */