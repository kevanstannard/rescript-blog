@bs.module("mustache") @bs.val
external render: (string, {..}, ~partials: Js.Dict.t<string>=?, unit) => string = "render"
