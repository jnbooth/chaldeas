module Site.CraftEssence.Filters exposing (get, errors)

import Maybe.Extra as Maybe
import Date exposing (Date)
import Time exposing (Month(..))

import StandardLibrary exposing (flip)
import Class.Has as Has
import Class.ToImage as ToImage
import Database.CraftEssences as Database
import Model.CraftEssence exposing (CraftEssence)
import Model.Skill.BuffEffect as BuffEffect
import Model.Skill.InstantEffect as InstantEffect
import Print
import Site.FilterTab as FilterTab exposing (FilterTab)
import Site.Filter exposing (Filter)
import Site.Filtering as Filtering exposing (ScheduledFilter)


extra : List (Filter CraftEssence)
extra = List.concat
    [ [ Filtering.name FilterTab.Availability "New"
        [ "Pray Upon the Sword, Wish Upon Life"
        , "Fate/Apocrypha"
        , "An Afternoon at the Fortress"
        , "At Trifas"
        , "Distant Pilgrimage"
        , "Moment of Bliss"
        , "Away We Go!"
        ]
      , Filter [] Nothing FilterTab.Source "Limited" <| \_ ce ->
            ce.limited && Maybe.isNothing ce.bond
      , Filter [] Nothing FilterTab.Source "Non-Limited" <| \_ ce ->
            not ce.limited && Maybe.isNothing ce.bond
      , Filter [] Nothing FilterTab.Source "Bond" <| \_ ce ->
            Maybe.isJust ce.bond
      ]
    , flip List.map (List.range 1 5) <| \rarity ->
        Filter [] Nothing FilterTab.Rarity (Print.stars False rarity) <| \_ ce ->
            rarity == ce.rarity
    ]


scheduled : List (ScheduledFilter CraftEssence)
scheduled =
  [ ScheduledFilter (Date 2018 Dec 6) (Date 2018 Dec 30) <|
    Filtering.name FilterTab.Availability "Rate-Up"
    [ "Devilish Bodhisattva", "Room Guard" ]
  ]


getExtra : Date -> FilterTab -> List (Filter CraftEssence)
getExtra today tab =
    Filtering.getScheduled scheduled today ++ extra
    |> List.filter (.tab >> (==) tab)


get : Date -> FilterTab -> List (Filter CraftEssence)
get today tab =
    let
        allEffects has toImage pred =
            Database.getAll (has .effect)
                |> List.filter pred
                >> List.map (Filtering.has toImage (has .effect) tab)
    in
    case tab of
        FilterTab.Bonus ->
            allEffects Has.bonusEffect Nothing <|
            always True

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
