module Model.Deck exposing
  ( Deck(..)
  , show
  , toList
  )


import Model.Card as Card exposing (Card)


type Deck
    = Deck Card Card Card Card Card


toList : Deck -> List Card
toList (Deck a b c d e) =
    [a, b, c, d, e]


show : Deck -> String
show =
    toList
        >> List.map (Card.show >> String.left 1)
        >> String.concat
