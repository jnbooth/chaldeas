module Site.Servant.Filters exposing (get, single, errors)

import List.Extra as List
import Date exposing (Date)
import Time exposing (Month(..))

import StandardLibrary exposing (flip)
import Class.Has as Has exposing (Has)
import Class.ToImage as ToImage
import Database.Servants as Database
import Model.Class exposing (Class(..))
import Model.Servant exposing (Servant)
import Model.Skill.BuffEffect as BuffEffect
import Model.Skill.InstantEffect as InstantEffect
import Print
import Site.FilterTab as FilterTab exposing (FilterTab)
import Site.Filter exposing (Filter)
import Site.Filtering as Filtering exposing (ScheduledFilter)



extra : List (Filter Servant)
extra = List.concat
    [ [ Filtering.name FilterTab.Availability "New"
        [ "Anastasia Nikolaevna Romanova"
        , "Atalante (Alter)"
        , "Avicebron"
        , "Antonio Salieri"
        , "Ivan the Terrible"
        ]
      , Filter [] Nothing FilterTab.Availability "Free" <| \_ s ->
            s.free
      , Filter [] Nothing FilterTab.Source "Limited" <| \_ s ->
            s.limited
      , Filter [] Nothing FilterTab.Source "Non-Limited" <| \_ s ->
            not s.limited
    ]
    , flip List.map (List.range 1 5) <| \rarity ->
        Filter [] Nothing FilterTab.Rarity (Print.stars False rarity) <| \_ s ->
            rarity == s.rarity
    ]


scheduled : List (ScheduledFilter Servant)
scheduled =
    [ ScheduledFilter (Date 2020 Mar 26) (Date 2020 Apr 9) <|
        Filtering.name FilterTab.Availability "Rate-Up"
        [ "Anastasia Nikolaevna Romanova"
        , "Atalante (Alter)"
        , "Avicebron"
        ]
    , ScheduledFilter (Date 2020 Apr 2) (Date 2020 Apr 16) <|
        Filtering.name FilterTab.Availability "Rate-Up"
        [ "Ivan the Terrible"
        , "Antonio Salieri"
        ]
    ]


single : Has Servant a -> FilterTab -> a -> List (Filter Servant)
single has tab x =
    if FilterTab.exclusive tab then
        Database.getAll has
            |> List.remove x
            >> List.map (Filtering.has Nothing has tab)
    else
        [Filtering.has Nothing has tab x]


getExtra : Date -> FilterTab -> List (Filter Servant)
getExtra today tab =
    Filtering.getScheduled scheduled today ++ extra
        |> List.filter (.tab >> (==) tab)


get : Date -> FilterTab -> List (Filter Servant)
get today tab =
    let
        allEffects has toImage pred =
            Database.getAll (has Has.servant)
                |> List.filter pred
                >> List.map (Filtering.has toImage (has Has.servant) tab)

        all has toImage =
            Database.getAll has
                |> List.map (Filtering.has toImage has tab)
    in
    case tab of
        FilterTab.Alignment ->
            all Has.alignment Nothing

        FilterTab.Attribute ->
            all Has.attribute Nothing

        FilterTab.Card ->
            all Has.card <| Just ToImage.card

        FilterTab.Class ->
            all Has.class <| Just ToImage.class

        FilterTab.Deck ->
            all Has.deck Nothing

        FilterTab.Gender ->
            all Has.gender Nothing

        FilterTab.Phantasm ->
            all Has.phantasmType Nothing

        FilterTab.Trait ->
            all Has.trait Nothing

        FilterTab.PassiveSkill ->
            all Has.passive << Just <| ToImage.icon << .icon

        FilterTab.Material ->
            all Has.material <| Just ToImage.material

        FilterTab.Debuff ->
            allEffects Has.debuffEffect (Just ToImage.debuffEffect) <|
            always True

        FilterTab.Buff c ->
            allEffects Has.buffEffect (Just ToImage.buffEffect) <|
            BuffEffect.category >> (==) c

        FilterTab.Action ->
            allEffects Has.instantEffect Nothing <|
            not << InstantEffect.isDamage

        FilterTab.Damage ->
            allEffects Has.instantEffect Nothing <|
            InstantEffect.isDamage

        _ ->
            getExtra today tab


errors : List String
errors =
    extra ++ List.map .filter scheduled
        |> List.concatMap .errors
