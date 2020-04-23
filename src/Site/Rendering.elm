module Site.Rendering exposing (siteView)

import Html as H
import Html.Events as E
import Html.Attributes as P

import StandardLibrary exposing (flip)
import Class.ToImage as ToImage
import Persist.Preference as Preference
import Persist.Preferences as Preferences exposing (Preferences)
import Site.Algebra exposing (SiteMsg(..), SiteModel)
import Site.FilterTab as FilterTab exposing (FilterTab)
import Site.Section as Section exposing (Section)
import Site.Common exposing (..)
import Site.Filter as Filter exposing (Filter)
import Site.SortBy as SortBy exposing (SortBy(..))


type alias Html a b = H.Html (SiteMsg a b)


render : Preferences -> Section -> SiteModel a b c -> List SortBy
      -> List (Html a b) -> List (Html a b)
render prefs a st sorts nav =
    case a of
        Section.Browse ->
            h_ 1 "Browse" :: nav ++
            [ h_ 1 "Links"
            , H.a
              [P.href "https://www.reddit.com/message/compose/?to=pareidolist"]
              [H.text "Send Feedback/Suggestions"]
            , H.a
              [P.href "https://github.com/jnbooth/chaldeas"]
              [H.text "GitHub"]
            , H.a
              [P.href "https://grandorder.wiki"]
              [H.text "GrandOrder Wiki"]
            ]

        Section.Settings ->
            [ h_ 1 "Settings"
            , H.form [] << flip List.map (Preferences.unfold prefs) <| \(k, v) ->
                H.p [E.onClick << SetPref k <| not v] <|
                checkbox_ Nothing (Preference.show k) v
            ]

        Section.SortBy ->
            if List.isEmpty sorts then
                []
            else
                let
                    renderSort sort =
                        case sort of
                            Effect ->
                                H.p [E.onClick <| EffectDialog True] <|
                                [ H.input
                                  [ P.type_ "radio"
                                  , P.checked <| st.sortBy == Effect
                                  ] []
                                , H.button
                                  [ P.type_ "button"
                                  , E.onClick <| EffectDialog True
                                  ]
                                  [H.text "Effect"]
                                ]

                            _ ->
                                H.p [E.onClick <| SetSort sort] <|
                                radio_ (SortBy.show sort) (st.sortBy == sort)
                in
                [ h_ 1 "Sort by"
                , H.form [] <| List.map renderSort sorts
                ]

        Section.Include ->
            let
                filters =
                    List.filter (.tab >> FilterTab.exclusive) st.allFilters
                        |> List.concatMap (filterSection st)
            in
            if List.isEmpty filters then
                []
            else
                h_ 1 "Include" :: filters

        Section.Filter ->
            let
                filters =
                    List.filter (not << FilterTab.exclusive << .tab) st.allFilters
                        |> List.concatMap (filterSection st)
            in
            if List.isEmpty filters then
                []
            else
                [ h_ 1 "Filter"
                , H.form [] <|
                  [ H.table []
                    [ H.tr []
                    [ text_ H.th "Match"
                    , H.td [E.onClick <| MatchAny False] <|
                      radio_ "All" (not st.matchAny)
                    , H.td [E.onClick <| MatchAny True]  <|
                      radio_ "Any" st.matchAny
                    ]
                    ]
                    , button_ "Reset All"
                     (not <| List.isEmpty st.filters && List.isEmpty st.exclude)
                      ClearAll
                  ] ++ filters
                ]


siteView : Preferences -> SiteModel a b c -> List SortBy
    -> List (Html a b) -> Html a b -> List (Html a b)
siteView prefs st sorts nav content =
    case st.section of
        Just x ->
            [ H.div [P.id "bg"] []
            , H.aside [] <|
              button_ "X" True (ToSection Nothing) ::
              render prefs x st sorts nav
            ]

        Nothing ->
            let
                renderSection x =
                    render prefs x st sorts nav
            in
            [ H.div [P.id "bg"] []
            , H.aside [] <|
              [ h_ 1 "Links"
              , H.a
                [P.href "https://www.reddit.com/message/compose/?to=pareidolist"]
                [H.text "Send Feedback/Suggestions"]
              , H.a
                [P.href "https://github.com/jnbooth/chaldeas"]
                [H.text "GitHub"]
              , H.a
                [P.href "https://grandorder.wiki"]
                [H.text "GrandOrder Wiki"]
              ]
              ++ renderSection Section.Settings
              ++ renderSection Section.SortBy
              ++ renderSection Section.Include
              , content
            , H.aside [] <| h_ 1 "Browse" :: nav ++ renderSection Section.Filter
            , H.footer [] << flip List.map Section.enum <| \section ->
                button_ (Section.show section) True << ToSection <| Just section
            ]


filterSection : SiteModel a b c
             -> { tab : FilterTab, filters : List (Filter a) }
             -> List (Html a b)
filterSection st {tab, filters} =
    case filters of
        [] ->
            []

        _  ->
            let
                checked =
                    List.length <| List.filter (.tab >> (==) tab) st.exclude

                addAll xs =
                    if FilterTab.exclusive tab && List.length filters > 2 then
                        H.div [P.class "exclusive"]
                        [ button_ "All" (checked /= 0) <| Check tab True
                        , button_ "None" (checked /= List.length filters) <|
                        Check tab False
                        ] :: xs
                    else
                        xs

                filterEl filter =
                    H.p [E.onClick <| Toggle filter] <<
                    checkbox_ (Maybe.map ToImage.image filter.icon)
                    filter.name <|
                    if FilterTab.exclusive filter.tab then
                        not <| List.any (Filter.eq filter) st.exclude
                    else
                        List.any (Filter.eq filter) st.filters
            in
            (::) (h_ 3 <| FilterTab.show tab) <<
            addAll << List.singleton << H.form [] <|
            List.map filterEl filters
