let format: (Js.Date.t, string) => string = [%bs.raw
  {| require("date-fns/format") |}
];