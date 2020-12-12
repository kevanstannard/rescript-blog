type callbackError = Js.nullable<Js.Exn.t>
type callbackValue<'a> = Js.nullable<'a>
type callback<'a> = (callbackError, callbackValue<'a>) => unit
