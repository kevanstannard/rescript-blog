let toPromise = (error: Js.Nullable.t(exn), data: Js.Nullable.t('a)) => {
  Js.Promise.make((~resolve: (. 'a) => unit, ~reject: (. exn) => unit) => {
    let errorOpt = Js.Nullable.toOption(error);
    let dataOpt = Js.Nullable.toOption(data);
    switch (errorOpt, dataOpt) {
    | (Some(exn), _) => reject(. exn)
    | (_, Some(data)) => resolve(. data)
    | (None, None) => reject(. Not_found)
    };
  });
};

let onReadPosts2 = (error, data) => {
  toPromise(error, data)
  |> Js.Promise.then_(data => {
       Js.log(data);
       Js.Promise.resolve();
     });
};

let onData = (data: array(string)) => {
  Js.log(data);
};

let onReadPosts = (error: Js.nullable(Glob.error), data: array(string)) => {
  let errorOpt = Js.Nullable.toOption(error);
  switch (errorOpt) {
  | Some(error) => Js.log(error)
  | None => onData(data)
  };
};

let readPosts = () => {
  Glob.glob("./content/posts/*.md", onReadPosts);
};

readPosts();

/*
 Glob.glob("./content/posts/*.md", (_, files) => Array.iter(Js.log, files));

  let path = "./content/posts/abstract-record-values.md";

  let onData = data => {
    let fmData = FrontMatter.fm(data);
    let md = Markdown.markdownIt.render(. fmData.body);
    Js.log(md);
  };

  let onReadFile =
    (. error, data) => {
      let errorOpt = Js.Nullable.toOption(error);
      let dataOpt = Js.Nullable.toOption(data);
      switch (errorOpt, dataOpt) {
      | (Some(exn), _) => Js.log(exn)
      | (_, Some(data)) => onData(data)
      | (None, None) => Js.log("No data found")
      };
    };

  Fs.readFile(path, "utf-8", onReadFile);
  */