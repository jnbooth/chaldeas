module Site.CraftEssence.Filters exposing (getFilters, errors)

import Maybe.Extra as Maybe
import Date exposing (Date)
import Time exposing (Month(..))

import StandardLibrary       exposing (..)
import Database              exposing (..)
import Database.CraftEssence exposing (..)
import Database.Skill        exposing (..)
import Printing              exposing (..)
import Site.Algebra          exposing (..)
import Site.Base             exposing (..)
import Site.Filtering        exposing (..)

import Class.Has     as Has
import Class.ToImage as ToImage


extraFilters : List (Filter CraftEssence)
extraFilters = List.concat
    [ [ nameFilter FilterAvailability "New"
        [ "Room Guard"
        , "Devilish Bodhisattva"
        ]
      , Filter [] Nothing FilterSource "Limited" <| \_ ce ->
            ce.limited && Maybe.isNothing ce.bond
      , Filter [] Nothing FilterSource "Non-Limited" <| \_ ce ->
            not ce.limited && Maybe.isNothing ce.bond
      , Filter [] Nothing FilterSource "Bond" <| \_ ce ->
            Maybe.isJust ce.bond
      ]
    , flip List.map (List.range 1 5) <| \rarity ->
        Filter [] Nothing FilterRarity (stars False rarity) <| \_ ce ->
            rarity == ce.rarity
    ]


scheduledFilters : List (ScheduledFilter CraftEssence)
scheduledFilters =
  [ ScheduledFilter (Date 2018 Dec 6) (Date 2018 Dec 30) <|
    nameFilter FilterAvailability "Rate-Up"
    [ "Devilish Bodhisattva", "Room Guard" ]
  ]


getExtraFilters : Date -> FilterTab -> List (Filter CraftEssence)
getExtraFilters today tab =
    getScheduled scheduledFilters today ++ extraFilters
    |> List.filter (.tab >> (==) tab)


getFilters : Date -> FilterTab -> List (Filter CraftEssence)
getFilters today tab =
    let
        allEffects has toImage pred =
            ceGetAll (has .effect)
                |> List.filter pred
                >> List.map (matchFilter toImage (has .effect) tab)
    in
    case tab of
        FilterBonus ->
            allEffects Has.bonusEffect Nothing <|
            always True

        FilterDebuff ->
            allEffects Has.debuffEffect (Just ToImage.debuffEffect) <|
            always True

        FilterBuff c ->
            allEffects Has.buffEffect (Just ToImage.buffEffect) <|
            buffCategory >> (==) c

        FilterAction ->
            allEffects Has.instantEffect Nothing <|
            not << isDamage

        FilterDamage ->
            allEffects Has.instantEffect Nothing <|
            isDamage

        _ ->
            getExtraFilters today tab

errors : List String
errors =
    extraFilters ++ List.map .filter scheduledFilters
        |> List.concatMap .errors
