module Site.Update exposing (siteUpdate)

import List.Extra as List

import StandardLibrary exposing (pure, removeWith)
import Model.Skill.SkillEffect exposing (SkillEffect)
import Site.Algebra exposing (SiteModel, SiteMsg(..))
import Site.FilterTab as FilterTab
import Site.Common exposing (..)
import Site.Filter as Filter
import Site.Filtering as Filtering
import Site.SortBy exposing (SortBy(..))
import Persist.Preferences exposing (Preferences)


siteUpdate : (focus -> filt)
          -> (filt -> String)
          -> (SiteModel filt focus extra -> SiteModel filt focus extra)
          -> (SkillEffect -> SiteModel filt focus extra -> SiteModel filt focus extra)
          -> Preferences
          -> SiteMsg filt focus
          -> SiteModel filt focus extra
          -> (SiteModel filt focus extra, Cmd (SiteMsg filt focus))
siteUpdate transform show reSort effectSort prefs msg st =
    let
        relist =
            Filtering.updateListing prefs transform

        goUp x =
            (x, scrollToTop "content")

        toggleIn x xs =
            if List.any (Filter.eq x) xs then
                removeWith Filter.eq x xs
            else
                x :: xs
    in
    case msg of
        ToSection section ->
            pure { st | section = section }

        ClearAll ->
            goUp <| relist { st | exclude = [], filters = [] }

        Check t True ->
            goUp <| relist
            { st | exclude = List.filter (.tab >> (/=) t) st.exclude }

        Check t False ->
            let
                filters =
                    List.find (.tab >> (==) t) st.allFilters
                        |> Maybe.map .filters
                        >> Maybe.withDefault []
            in
            goUp <| relist
            { st | exclude = List.uniqueBy Filter.ord <| filters ++ st.exclude }

        SetSort sortBy ->
            goUp << relist <| reSort { st | sortBy = sortBy }

        EffectSort ef ->
            goUp << relist <|
            effectSort ef { st | dialog = False, sortBy = Effect }

        EffectDialog b ->
            goUp <| { st | dialog = b }

        MatchAny matchAny ->
            goUp <| relist { st | matchAny = matchAny }

        Focus focus ->
            ( { st | focus = focus }
            , setFocus st.navKey st.root <| Maybe.map (transform >> show) focus
            )

        FilterBy filters ->
            let
                resetPath (x, y) =
                    (x, Cmd.batch [y, setPath st.navKey [st.root]])
            in
            resetPath << goUp << relist <|
            if List.any (.tab >> FilterTab.exclusive) filters then
                { st
                | exclude = filters
                , filters = []
                , focus   = Nothing
                }
            else
                { st
                | exclude = []
                , filters = filters
                , focus   = Nothing
                }

        SetSources srcs ->
            pure { st | sources = srcs }

        SetPref _ _ ->
            pure << relist <| reSort st

        Toggle filter ->
            goUp << relist <|
            if FilterTab.exclusive filter.tab then
                { st | exclude = toggleIn filter st.exclude }
            else
                { st | filters = toggleIn filter st.filters }

        _ ->
            pure st
