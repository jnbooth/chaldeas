module Model.Skill.Amount exposing
  ( Amount(..)
  , show
  , toMin, toMax
  )


type Amount
    = Placeholder
    | Full
    | Flat Float
    | Range Float Float


show : Amount -> String
show a =
    case a of
        Placeholder -> "X"
        Full        -> ""
        Flat x      -> String.fromFloat x
        Range x y   -> String.fromFloat x ++ "~" ++ String.fromFloat y


toMin : Amount -> Float
toMin a =
    case a of
        Placeholder -> 0
        Full        -> 0
        Flat x      -> x
        Range x _   -> x


toMax : Amount -> Float
toMax a =
    case a of
        Placeholder -> 0
        Full        -> 1/0
        Flat x      -> x
        Range _ y   -> y
