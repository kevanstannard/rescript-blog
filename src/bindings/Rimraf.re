type nodeErrorCallback = Js.nullable(Js.Exn.t) => unit;

let rimraf: (. string, nodeErrorCallback) => unit = [%bs.raw
  {| require("rimraf") |}
];