let readFile = (filePath: string) => {
  Js.Promise.make((~resolve, ~reject) => {
    let onRead = (. error, content) => {
      let errorOpt = Js.Nullable.toOption(error)
      let contentOpt = Js.Nullable.toOption(content)
      switch (errorOpt, contentOpt) {
      | (Some(_error), _) => reject(. Failure("Error reading file " ++ filePath))
      | (_, Some(content)) => resolve(. content)
      | (None, None) => reject(. Failure("Error reading file " ++ filePath ++ " (returned null)"))
      }
    }
    Fs.readFile(filePath, "utf-8", onRead)
  })
}

let writeFile = (filePath: string, content: string): Js.Promise.t<unit> => {
  Js.Promise.make((~resolve, ~reject) => {
    Fs.writeFile(filePath, content, error => {
      let unit = ()
      let errorOpt = Js.Nullable.toOption(error)
      switch errorOpt {
      | Some(_error) => reject(. Failure("Error writing file " ++ filePath))
      | None => resolve(. unit)
      }
    })
  })
}

let glob = (glob: string): Js.Promise.t<array<string>> =>
  Js.Promise.make((~resolve, ~reject) => {
    Glob.glob(glob, (error, paths) => {
      let errorOpt = Js.Nullable.toOption(error)
      let pathsOpt = Js.Nullable.toOption(paths)
      switch (errorOpt, pathsOpt) {
      | (Some(error), _) => {
          let reason = Belt.Option.getWithDefault(Js.Exn.message(error), "Unknown")
          reject(. Failure("Error reading glob: " ++ glob ++ ". Reason: " ++ reason))
        }
      | (_, Some(paths)) => resolve(. paths)
      | (None, None) => reject(. Failure("Error reading glob: " ++ glob ++ ". Reason: Unknown"))
      }
    })
  })
