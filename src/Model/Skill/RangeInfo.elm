module Model.Skill.RangeInfo exposing
  ( RangeInfo
  , show
  , Ord, ord
  )

import Print


type alias RangeInfo =
    { percent : Bool
    , min     : Float
    , max     : Float
    }


show : RangeInfo -> String
show r =
    Print.places 2 r.min
        ++ "% ~ "
        ++ Print.places 2 r.max
        ++ if r.percent then "" else "%"


type alias Ord =
    Float


ord : RangeInfo -> Ord
ord =
    .max
