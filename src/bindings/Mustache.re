[@bs.module "mustache"] [@bs.val]
external render:
  (string, Js.t({..}), ~partials: Js.Dict.t(string)=?, unit) => string =
  "render";