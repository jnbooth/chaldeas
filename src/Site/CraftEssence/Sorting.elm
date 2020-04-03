module Site.CraftEssence.Sorting exposing (get)

import Dict exposing (Dict)

import StandardLibrary exposing (dict)
import Model.CraftEssence exposing (CraftEssence)
import Database.CraftEssences as CraftEssences
import Site.SortBy as SortBy exposing (SortBy(..))


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
                    >> SortBy.format a

            showSort ce =
                (showFormat ce, ce)
        in
        List.sortWith sortWith
            >> List.map showSort


sorted : Dict SortBy.Ord (List (String, CraftEssence))
sorted =
    dict SortBy.enum <| \sorter ->
        (SortBy.ord sorter, doSort sorter CraftEssences.db)


get : SortBy -> List (String, CraftEssence)
get sorter =
    Dict.get (SortBy.ord sorter) sorted
        |> Maybe.withDefault []
