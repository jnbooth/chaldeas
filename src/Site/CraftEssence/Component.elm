module Site.CraftEssence.Component exposing (Model, Msg, component)

import Html.Keyed         as Keyed
import Browser.Navigation as Navigation
import Html.Lazy exposing (lazy3)

import Html.Events     as E
import Html            as H exposing (Html)
import Html.Attributes as P

import StandardLibrary       exposing (..)
import Database.CraftEssence exposing (..)
import Database.Skill        exposing (..)
import Persist.Flags         exposing (..)
import Persist.Preferences   exposing (..)
import Printing              exposing (..)
import Site.Algebra          exposing (..)
import Site.Common           exposing (..)
import Site.Filtering        exposing (..)
import Site.Rendering        exposing (..)
import Site.Update           exposing (..)
import Sorting               exposing (..)

import Class.ToImage as ToImage

import Site.CraftEssence.Filters exposing (..)
import Site.CraftEssence.Sorting exposing (..)


type alias Model = SiteModel CraftEssence CraftEssence ()


type alias Msg = SiteMsg CraftEssence CraftEssence


reSort : Model -> Model
reSort st = { st | sorted = getSort st.sortBy }


component : (String -> Value -> Cmd Msg) -> Component Model Msg
component = always <|
    let
        init : Flags -> Navigation.Key -> Model
        init flags navKey =
            siteInit (collectFilters getFilters) flags navKey ()
                |> reSort
                >> updateListing flags.preferences identity
                >> \st -> { st | root = "CraftEssences" }

        view : Preferences -> Model -> Html Msg
        view prefs st =
            let
                nav =
                    [ text_ H.strong "Craft Essences"
                    , a_ ["Servants"]
                    , a_ ["My Servants"]
                    --, a_ ["Teams"]
                    ]
            in
            lazy3 unlazyView prefs st.listing st.sortBy
                |> siteView prefs st [Rarity, ID, ATK, HP] nav
                >> popup prefs st.focus

        unlazyView prefs listing sortBy =
            listing
                |> List.map (keyedPortrait False prefs)
                |> (if sortBy == Rarity then identity else List.reverse)
                >> Keyed.node "section" [P.id "content"]

        update : Preferences -> Msg -> Model -> (Model, Cmd Msg)
        update =
            siteUpdate identity .name reSort
  in
    { init = init, view = view, update = update }

portrait : Bool -> Preferences -> (String, CraftEssence) -> Html Msg
portrait big prefs (label, ce) =
    if not big && prefer prefs Thumbnails then
        H.a
        [ P.class "thumb"
        , P.href <| "/CraftEssences/" ++ urlName ce.name
        , E.onClick << Focus <| Just ce
        ]
        [ToImage.ceThumb ce]
    else
        let
            class =
                P.class <| "portrait stars" ++ String.fromInt ce.rarity

            parent =
                if big then
                    H.div [class]
                else
                    H.a
                    [ class
                    , E.onClick << Focus <| Just ce
                    , P.href <| "/CraftEssences/" ++ urlName ce.name
                    ]

            noBreak =
                noBreakName big False

            artorify =
                if prefer prefs Artorify then
                    String.replace "Altria" "Artoria"
                else
                    identity

            addLabel xs =
                if String.isEmpty label then
                    xs
                else
                    [text_ H.span <| noBreak label, H.br [] []] ++ xs
        in
        parent
        [ ToImage.image <| ToImage.craftEssence ce
        , H.header [] << addLabel <|
            [text_ H.span << noBreak <| artorify ce.name]
        , H.footer []
            [text_ H.span <| stars True ce.rarity]
        ]


keyedPortrait : Bool -> Preferences -> (String, CraftEssence)
             -> (String, Html Msg)
keyedPortrait big prefs (label, ce) =
    (ce.name, lazy3 portrait big prefs (label, ce))


popup : Preferences -> Maybe CraftEssence -> List (Html Msg) -> Html Msg
popup prefs a =
    case a of
        Nothing ->
            H.div [P.id "elm", P.class <| mode prefs] << (++)
            [ H.a [P.id "cover", P.href "/CraftEssences"] []
            , H.article [P.id "focus"] []
            ]

        Just ce ->
            let
                {base, max} =
                    ce.stats

                bondMsg =
                    case ce.bond of
                        Just bond ->
                            [ H.em []
                            [ H.text "If equipped by "
                            , a_ ["Servants", bond]
                            , H.text ": "
                            ]
                            ]

                        Nothing ->
                            []

                effectsEl f =
                    H.section [] << (++) bondMsg <<
                    flip List.map ce.effect <|
                    mapAmount f
                        >> effectEl craftEssences (Just .effect)

                mlbEl =
                    if base == max then
                        []
                    else
                        [effectsEl <| \x _ -> Flat x, h_ 2 "Max Limit Break"]

                showInt =
                    toFloat
                        >> commas
                        >> H.text
                        >> List.singleton
            in
            H.div [P.id "elm", P.class <| mode prefs ++ " fade"] << (++)
            [ H.a [P.id "cover", P.href "/CraftEssences"] []
            , H.article [P.id "focus"]
                [ H.div []
                [ portrait True prefs ("", ce)
                , H.div [] <|
                    [ table_ ["", "ATK", "HP"]
                    [ H.tr []
                        [ text_ H.th "Base"
                        , H.td [] <| showInt base.atk
                        , H.td [] <| showInt base.hp
                        ]
                    , H.tr []
                        [ text_ H.th "Max"
                        , H.td [] <| showInt max.atk
                        , H.td [] <| showInt max.hp
                        ]
                    ]
                    , ToImage.image <| ToImage.icon ce.icon
                    , h_ 2 "Effects"
                    ] ++ mlbEl ++
                    [ effectsEl <| \_ y -> Flat y ]
                ]
                ]
            ]
