module Site.CraftEssence.Sorting exposing (getSort)

import Dict exposing (Dict)

import StandardLibrary       exposing (..)
import Database.CraftEssence exposing (..)
import Sorting               exposing (..)


toSort : SortBy -> CraftEssence -> Float
toSort a ce = case a of
    ID     -> toFloat (-ce.id)
    Rarity -> toFloat ce.rarity
    ATK    -> toFloat ce.stats.max.atk
    HP     -> toFloat ce.stats.max.hp
    _      -> 1/0


doSort : SortBy -> List CraftEssence -> List (String, CraftEssence)
doSort a = case a of
    Rarity ->
        let
            sortOn ce =
                String.fromInt (5 - ce.rarity) ++ ce.name

            sortWith x y =
                compare (sortOn x) (sortOn y)

            showSort ce =
                (Maybe.withDefault "" ce.bond, ce)
        in
        List.sortWith sortWith
            >> List.map showSort
    _ ->
        let
            sortOn =
                toSort a

            sortWith x y =
                compare (sortOn x) (sortOn y)

            showFormat =
                sortOn
                    >> abs
                    >> formatSort a

            showSort ce =
                (showFormat ce, ce)
        in
        List.sortWith sortWith
            >> List.map showSort


sorted : Dict OrdSortBy (List (String, CraftEssence))
sorted =
    dict enumSortBy <| \sorter ->
        (ordSortBy sorter, doSort sorter craftEssences)


getSort : SortBy -> List (String, CraftEssence)
getSort sorter =
    Dict.get (ordSortBy sorter) sorted
        |> Maybe.withDefault []
