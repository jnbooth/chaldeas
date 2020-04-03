module Model.Stat exposing
  ( Stat
  , add
  , show
  )


{-| Craft Essences have minimum and maximum Stats.
Servants have minimum, maximum, and grail Stats. -}
type alias Stat =
    { atk : Int, hp  : Int }


{-| Used for Fou +ATK and +DEF bonuses. -}
add : Stat -> Stat -> Stat
add x y =
    { atk = x.atk + y.atk
    , hp  = x.hp  + y.hp
    }


show : Stat -> String
show {atk, hp} =
    "ATK: "
        ++ String.fromInt atk
        ++ ", HP: "
        ++ String.fromInt hp

