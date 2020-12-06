type nodeErrorCallback = Js.nullable<Js.Exn.t> => unit

@bs.module external rimraf: (. string, nodeErrorCallback) => unit = "rimraf"
