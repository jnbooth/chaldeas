module Site.Filtering exposing
  ( ScheduledFilter, getScheduled
  , updateListing
  , collectFilters
  , has, name, skill
  )

{-| Sidebars for filtering displayed Servants/Craft Essences. -}

import List.Extra as List
import Date exposing (Date)

import StandardLibrary exposing (duplicates, flip, suite)
import Class.Has as Has exposing (Has)
import Class.ToImage as ToImage exposing (ToImage)
import Database.CraftEssences as CraftEssences
import Database.Servants as Servants
import Persist.Preference exposing (Preference(..))
import Persist.Preferences exposing (Preferences, prefers)
import Site.Algebra exposing (FilterList, SiteModel)
import Site.FilterTab as FilterTab exposing (FilterTab)
import Site.Filter as Filter exposing (Filter)
import Model.Skill.BuffEffect as BuffEffect
import Model.Skill.SkillEffect exposing (SkillEffect(..))


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
            prefers prefs ExcludeSelf

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
    flip List.map FilterTab.enum <| \tab ->
        { tab = tab, filters = reduceFilters <| f today tab }


{-| Turns multiple filters with the same name into a single filter that
matches any of them. -}
reduceFilters : List (Filter a) -> List (Filter a)
reduceFilters =
    let
        go (x, xs) =
            { x | match = \a b -> List.any (\f -> f.match a b) <| x :: xs }
    in
    List.sortWith Filter.compare
        >> List.groupWhile Filter.eq
        >> List.map go

{-| Creates a `Filter` from a `Has` instance. -}
has : Maybe (ToImage b) -> Has a b -> FilterTab -> b -> Filter a
has toImage cla tab x =
    { icon   = Maybe.map ((|>) x) toImage
    , tab    = tab
    , name   = cla.show x
    , errors = []
    , match  = \b -> cla.has b >> List.member x
    }

{-| Creates a `Filter` that matches a supplied list of `.name`s. -}
name : FilterTab -> String -> List String -> Filter { a | name : String }
name tab x names =
    let
        valid =
            List.map .name Servants.db
                ++ List.map .name CraftEssences.db

        warn label f =
            suite (x ++ ": " ++ label) <| f names
    in
    { icon   = Nothing
    , tab    = tab
    , name   = x
    , errors =  warn "DUPLICATE" duplicates
                    ++ warn "INVALID"
                       (List.filter <| not << flip List.member valid)
    , match  = always <| .name >> flip List.member names
    }


{-| Creates a `Filter` for a `SkillEffect`. -}
skill : List a -> SkillEffect -> (a -> List SkillEffect) -> Maybe (Filter a)
skill xs a getEffects =
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
            Just <| has
                (Just ToImage.buffEffect)
                (Has.buffEffect getEffects)
                (FilterTab.Buff <| BuffEffect.category buff)
                buff

        Debuff _ _ debuff _ ->
            Just <| has
                (Just ToImage.debuffEffect)
                (Has.debuffEffect getEffects)
                FilterTab.Debuff
                debuff

        To _ action _ ->
            Just <| has
                Nothing
                (Has.instantEffect getEffects)
                FilterTab.Action
                action

        Bonus bonus _ _ ->
            Just <| has
                Nothing
                (Has.bonusEffect getEffects)
                FilterTab.Bonus
                bonus

        Chance _ b ->
            skill xs b getEffects

        Chances _ _ b ->
            skill xs b getEffects

        When _ b ->
            skill xs b getEffects

        Times _ b ->
            skill xs b getEffects

        ToMax _ b ->
            skill xs b getEffects

        After _ b ->
            skill xs b getEffects
