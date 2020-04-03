module Model.Card exposing
  ( Card(..)
  , show
  )


{-| The building blocks of a Servant's Deck and NP type. -}
-- Note: "Extra" cards, also known as EX, are not represented as they only
-- occur at the end of a Brave Combo.
type Card
    = Quick
    | Arts
    | Buster
    | Extra


show : Card -> String
show a =
    case a of
        Quick  -> "Quick"
        Arts   -> "Arts"
        Buster -> "Buster"
        Extra  -> "Extra"
