module Site.CraftEssence.Component exposing (Model, Msg, component)


import Browser.Navigation as Navigation
import Html as H exposing (Html)
import Html.Events as E
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy3)
import Html.Attributes as P

import StandardLibrary exposing (flip)
import Class.ToImage as ToImage
import Model.CraftEssence exposing (CraftEssence)
import Model.Skill.Amount exposing (Amount(..))
import Model.Skill.SkillEffect as SkillEffect exposing (SkillEffect)
import Persist.Flags exposing (Flags)
import Persist.Preference exposing (Preference(..))
import Persist.Preferences exposing (Preferences, prefers)
import Print
import Site.Algebra as Site exposing (Component, SiteModel, SiteMsg(..))
import Site.Common exposing (..)
import Site.Filtering as Filtering
import Site.Rendering as Rendering
import Site.Update as Update
import Site.SortBy exposing (SortBy(..))
import Database.CraftEssences as CraftEssences
import Database.Calculator as C

import Site.CraftEssence.Filters as Filters
import Site.CraftEssence.Sorting as Sorting


type alias Model = SiteModel CraftEssence CraftEssence ()


type alias Msg = SiteMsg CraftEssence CraftEssence


reSort : Model -> Model
reSort st =
    case st.sortBy of
        Effect -> st
        x      -> { st | sorted = Sorting.get x }


effectSort : SkillEffect -> Model -> Model
effectSort ef st =
    { st | sorted = C.effectSort C.craftEssenceEffects ef CraftEssences.db st.sources }


component : Component Model Msg
component =
    let
        init : Flags -> Navigation.Key -> Model
        init flags navKey =
            Site.init (Filtering.collectFilters Filters.get) flags navKey
            (C.selfish + C.skills + C.np)
            ()
                |> reSort
                >> Filtering.updateListing flags.preferences identity
                >> \st -> { st | root = "CraftEssences" }

        view : Preferences -> Model -> Html Msg
        view prefs st =
            let
                nav =
                    [ text_ H.strong "Craft Essences"
                    , a_ ["Servants"]
                    , a_ ["My Servants"]
                    ]
            in
            lazy3 unlazyView prefs st.listing st.sortBy
                |> Rendering.siteView prefs st [Rarity, ID, ATK, HP, Effect] nav
                >> popup prefs st

        unlazyView prefs listing sortBy =
            listing
                |> List.map (keyedPortrait False prefs)
                |> (if sortBy == Rarity then identity else List.reverse)
                >> Keyed.node "section" [P.id "content"]

        update : Preferences -> Msg -> Model -> (Model, Cmd Msg)
        update =
            Update.siteUpdate identity .name reSort effectSort
  in
    { init = init, view = view, update = update }

portrait : Bool -> Preferences -> (String, CraftEssence) -> Html Msg
portrait big prefs (label, ce) =
    if not big && prefers prefs Thumbnails then
        H.a
        [ P.class "thumb"
        , P.href <| "/CraftEssences/" ++ Print.url ce.name
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
                    , P.href <| "/CraftEssences/" ++ Print.url ce.name
                    ]

            noBreak =
                noBreakName big False

            artorify =
                if prefers prefs Artorify then
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
            [text_ H.span <| Print.stars True ce.rarity]
        ]


keyedPortrait : Bool -> Preferences -> (String, CraftEssence)
             -> (String, Html Msg)
keyedPortrait big prefs (label, ce) =
    (ce.name, lazy3 portrait big prefs (label, ce))


ceEffects : List C.EffectsRaw
ceEffects =
    List.map C.craftEssenceEffects CraftEssences.db


popup : Preferences -> Model -> List (Html Msg) -> Html Msg
popup prefs st =
    if st.dialog then
        H.div [P.id "elm", P.class <| mode prefs ++ " fade"] << (++)
        [ H.a [P.id "cover", P.href <| "/CraftEssences"] []
        , effectsDialog (C.special + C.selfish + C.maxOver) st.sources
          "Max Limit Break"
          ceEffects
        ]
    else case st.focus of
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
                    SkillEffect.mapAmount f
                        >> effectEl CraftEssences.db (Just .effect)

                mlbEl =
                    if base == max then
                        []
                    else
                        [effectsEl <| \x _ -> Flat x, h_ 2 "Max Limit Break"]

                showInt =
                    toFloat
                        >> Print.commas
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
