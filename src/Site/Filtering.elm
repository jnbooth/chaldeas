module Site.Filtering exposing
  ( ScheduledFilter, getScheduled
  , updateListing
  , collectFilters
  , matchFilter, nameFilter, skillFilter
  )

{-| Sidebars for filtering displayed Servants/Craft Essences. -}

import List.Extra as List
import Date exposing (Date)

import StandardLibrary       exposing (..)
import Database              exposing (..)
import Database.CraftEssence exposing (..)
import Database.Skill        exposing (..)
import Persist.Preferences   exposing (..)
import Site.Algebra          exposing (..)
import Site.Base             exposing (..)

import Class.Has     as Has      exposing (Has)
import Class.ToImage as ToImage exposing (ToImage)


{-| A filter that only displays during a certain range of time.
Useful for event bonuses, weekly rate-ups, etc. -}
type alias ScheduledFilter a =
    { start  : Date
    , end    : Date
    , filter : Filter a
    }


{-| Retrieves all `Filter`s that are visible today. -}
getScheduled : List (ScheduledFilter a) -> Date -> List (Filter a)
getScheduled xs today =
    let
        sched x =
            Date.compare x.start today /= GT
                && Date.compare today x.end /= GT
    in
    List.map .filter <| List.filter sched xs


{-| Updates a `SiteModel`'s `.listing` with its `.sorted`,
filtered by its `.exclude` and `.filters`. -}
updateListing : Preferences -> (b -> a) -> SiteModel a b c -> SiteModel a b c
updateListing prefs f st =
    let
        noSelf =
            prefer prefs ExcludeSelf

        matches x filter =
            filter.match noSelf x

        howMany =
            if st.matchAny then
                List.any
            else
                List.all

        match x =
            (List.isEmpty st.exclude || List.all (not << matches x) st.exclude)
                && (List.isEmpty st.filters || howMany (matches x) st.filters)
    in
    { st | listing = List.filter (Tuple.second >> f >> match) st.sorted }


{-| Organizes all filters visible today into a `FilerList`. -}
collectFilters : (Date -> FilterTab -> List (Filter a)) -> Date -> FilterList a
collectFilters f today =
    flip List.map enumFilterTab <| \tab ->
        { tab = tab, filters = reduceFilters <| f today tab }


{-| Turns multiple filters with the same name into a single filter that
matches any of them. -}
reduceFilters : List (Filter a) -> List (Filter a)
reduceFilters =
    let
        go (x, xs) =
            { x | match = \a b -> List.any (\f -> f.match a b) <| x :: xs }
    in
    List.sortWith compareFilter
        >> List.groupWhile eqFilter
        >> List.map go

{-| Creates a `Filter` from a `Has` instance. -}
matchFilter : Maybe (ToImage b) -> Has a b -> FilterTab -> b -> Filter a
matchFilter toImage {show, has} tab x =
    { icon   = Maybe.map ((|>) x) toImage
    , tab    = tab
    , name   = show x
    , errors = []
    , match  = \b -> has b >> List.member x
    }

{-| Creates a `Filter` that matches a supplied list of `.name`s. -}
nameFilter : FilterTab -> String -> List String -> Filter { a | name : String }
nameFilter tab name names =
    let
        valid =
            List.map .name servants ++ List.map .name craftEssences

        warn label f =
            suite (name ++ ": " ++ label) <| f names
    in
    { icon   = Nothing
    , tab    = tab
    , name   = name
    , errors =  warn "DUPLICATE" duplicates
                    ++ warn "INVALID"
                       (List.filter <| not << flip List.member valid)
    , match  = always <| .name >> flip List.member names
    }


{-| Creates a `Filter` for a `SkillEffect`. -}
skillFilter : List a -> SkillEffect -> (a -> List SkillEffect)
           -> Maybe (Filter a)
skillFilter xs a getEffects =
    let
        isMultiple filter =
            xs
                |> List.filter (filter.match False)
                >> List.drop 1
                >> List.isEmpty
                >> not

        ifMultiple filter =
            if isMultiple filter then
                Just filter
            else
                Nothing

    in
    Maybe.andThen ifMultiple <| case a of
        Grant _ _ buff _ ->
            Just <| matchFilter
                (Just ToImage.buffEffect)
                (Has.buffEffect getEffects)
                (FilterBuff <| buffCategory buff)
                buff

        Debuff _ _ debuff _ ->
            Just <| matchFilter
                (Just ToImage.debuffEffect)
                (Has.debuffEffect getEffects)
                FilterDebuff
                debuff

        To _ action _ ->
            Just <| matchFilter
                Nothing
                (Has.instantEffect getEffects)
                FilterAction
                action

        Bonus bonus _ _ ->
            Just <| matchFilter
                Nothing
                (Has.bonusEffect getEffects)
                FilterBonus
                bonus

        Chance _ b ->
            skillFilter xs b getEffects

        Chances _ _ b ->
            skillFilter xs b getEffects

        When _ b ->
            skillFilter xs b getEffects

        Times _ b ->
            skillFilter xs b getEffects

        ToMax _ b ->
            skillFilter xs b getEffects

        After _ b ->
            skillFilter xs b getEffects
