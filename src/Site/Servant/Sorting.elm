module Site.Servant.Sorting exposing (getSort)

import Dict

import StandardLibrary     exposing  (..)
import MyServant           exposing (..)
import Sorting             exposing (..)
import Persist.Preferences exposing (..)


getSort : Preferences -> SortBy -> List MyServant -> List (String, MyServant)
getSort prefs a = case a of
    Rarity ->
        let
            sortOn {base} =
                String.fromInt (5 - base.rarity) ++ base.name

            sortWith x y =
                compare (sortOn x) (sortOn y)
        in
        List.sortWith sortWith
            >> List.map (\x -> ("", x))
    _ ->
        let
            sortOn ms =
                Dict.get (ordSortBy a) ms.sorted
                    |> Maybe.withDefault (1/0, 1/0)
                    >> if addToSort prefs a then
                           Tuple.first
                       else
                           Tuple.second

            sortWith x y =
                compare (sortOn x) (sortOn y)

            showNP npLvl xs =
                if List.member a [NPDmg, NPDmgOver, NPSpec, NPSpecOver] then
                    "NP" ++ String.fromInt npLvl ++ ": " ++ xs
                else
                    xs

            showFormat ms =
                ms
                    |> sortOn
                    >> abs
                    >> formatSort a
                    >> showNP ms.npLvl

            showSort ms = ( showFormat ms, ms )
        in
        List.sortWith sortWith
            >> List.map showSort
