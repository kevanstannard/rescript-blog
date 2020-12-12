@bs.module("fs")
external readdir: (string, Node.callback<array<string>>) => unit = "readdir"

@bs.module("fs") external existsSync: string => bool = "existsSync"

@bs.module("fs") external mkdirSync: string => bool = "mkdirSync"

@bs.module("fs")
external writeFile: (string, string, Node.callbackWithError) => unit = "writeFile"

@bs.module("fs")
external readFile: (string, string, Node.callback<string>) => unit = "readFile"
