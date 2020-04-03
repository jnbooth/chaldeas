module Site.Filter exposing
  ( Filter
  , eq
  , Ord, ord, compare
  )

import StandardLibrary exposing (compareThen, alwaysEq)

import Class.ToImage exposing (ImagePath)
import Site.FilterTab as FilterTab exposing (FilterTab)


type alias Filter a =
    { errors : List String
    , icon   : Maybe ImagePath
    , tab    : FilterTab
    , name   : String
    , match  : Bool -> a -> Bool
    }


eq : Filter a -> Filter a -> Bool
eq x y =
    x.tab == y.tab && x.name == y.name


type alias Ord =
    String


ord : Filter a -> Ord
ord x =
    FilterTab.show x.tab ++
    if x.tab == FilterTab.Rarity then
        String.fromInt <| 10 - String.length x.name
    else if String.startsWith "+" x.name then
        case String.split " " x.name of
            w :: ws  ->
                "+" ++ String.join " " ws
                    ++ String.fromInt (String.length w) ++ w

            [] ->
                x.name
    else
        x.name


compare : Filter a -> Filter a -> Order
compare =
    compareThen (.tab >> FilterTab.ord) <|
    compareThen ord
    alwaysEq
