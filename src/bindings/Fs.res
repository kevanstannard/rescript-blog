type nodeCallback<'a> = (. Js.nullable<Js.Exn.t>, Js.nullable<'a>) => unit
type nodeErrorCallback = Js.nullable<Js.Exn.t> => unit

@bs.module("fs")
external readdir: (string, nodeCallback<array<string>>) => unit = "readdir"

@bs.module("fs") external existsSync: string => bool = "existsSync"

@bs.module("fs") external mkdirSync: string => bool = "mkdirSync"

@bs.module("fs")
external writeFile: (string, string, nodeErrorCallback) => unit = "writeFile"

@bs.module("fs")
external readFile: (string, string, nodeCallback<string>) => unit = "readFile"
