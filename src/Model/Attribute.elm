module Model.Attribute exposing
  ( Attribute(..)
  , enum
  , show
  )


{-| Determines the "attribute modifier" in `Database.Calculator`.
Currently used only for filters. -}
-- Note: There is a fifth category in the game, "Beast",
-- which is not represented here because only enemies can have it.
type Attribute
    = Human
    | Sky
    | Earth
    | Star
    | Beast


enum : List Attribute
enum =
    [ Human
    , Sky
    , Earth
    , Star
    , Beast
    ]


show : Attribute -> String
show a =
    case a of
        Human -> "Human"
        Sky   -> "Sky"
        Earth -> "Earth"
        Star  -> "Star"
        Beast -> "Beast"
