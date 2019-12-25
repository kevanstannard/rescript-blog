let rootDir = "./content";
let postsDir = rootDir ++ "/posts";

type readDirResult =
  | ReadDirError(Js.Exn.t)
  | ReadDirResult(list(string));

let toResult = (error, items) => {
  let errorOption = Js.Nullable.toOption(error);
  switch (errorOption) {
  | Some(exn) => ReadDirError(exn)
  | None =>
    let itemsOption = Js.Nullable.toOption(items);
    switch (itemsOption) {
    | None => ReadDirResult([])
    | Some(items) => ReadDirResult(Array.to_list(items))
    };
  };
};

let onItems = items => {
  Js.log(items);
};

let onDir =
  (. error, items) => {
    let result = toResult(error, items);
    switch (result) {
    | ReadDirError(exn) => Js.log(exn)
    | ReadDirResult(items) => onItems(items)
    };
  };

Fs.readdir(postsDir, onDir);