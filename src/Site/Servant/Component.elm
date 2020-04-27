module Site.Servant.Component exposing (Model, Msg, component, setRoot)

import Browser.Navigation as Navigation
import Dict exposing (Dict)
import Json.Decode as D
import Json.Encode as E
import Html as H exposing (Html)
import Html.Attributes as P
import Html.Events as E
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy4, lazy5)
import List.Extra as List
import Maybe.Extra as Maybe

import StandardLibrary exposing (flip, pure)
import Database
import Database.Calculator as C
import Database.CraftEssences as CraftEssences
import Database.Servants as Servants
import Model.Material as Material exposing (Material(..))
import Model.Trait exposing (Trait(..))
import Model.CraftEssence exposing (CraftEssence)
import Model.Servant as Servant exposing (Ascension(..), Reinforcement(..), Servant)
import Model.Skill exposing (Skill)
import Model.Skill.RangeInfo as RangeInfo exposing (RangeInfo)
import Model.Skill.Rank as Rank exposing (Rank(..))
import Model.Skill.SkillEffect as SkillEffect exposing (SkillEffect)
import Persist.Flags as Flags exposing (Flags)
import Persist.Preference exposing (Preference(..))
import Persist.Preferences exposing (Preferences, prefers)
import Ports exposing (Ports)
import Print
import Model.MyServant as MyServant exposing (MyServant)
import Model.MyServant.Leveling as Leveling
import Site.Algebra as Site exposing (Component, SiteModel, SiteMsg(..))
import Site.Common exposing (..)
import Site.Filtering as Filtering
import Site.Rendering as Rendering
import Site.SortBy as SortBy exposing (SortBy(..))
import Site.Update as Update

import Class.Has as Has
import Class.ToImage as ToImage exposing (ImagePath)
import Site.FilterTab as FilterTab

import Site.Servant.Filters as Filters
import Site.Servant.Sorting as Sorting


type alias Model =
    SiteModel Servant MyServant
        { mine     : Dict Servant.Ord MyServant
        , mineOnly : Bool
        , ascent   : Int
        , myServs  : List MyServant
        , export   : Maybe String
        , entry    : String
        }


type alias Msg =
    SiteMsg Servant MyServant


reSort : Preferences -> Model -> Model
reSort prefs st =
    case st.sortBy of
        Effect -> st
        x     -> { st | sorted = Sorting.get prefs x st.extra.myServs }


effectSort : SkillEffect -> Model -> Model
effectSort  ef st =
    let
        sortWith =
            .servant
                >> C.servantEffects st.sources
    in
    { st | sorted = C.effectSort sortWith ef st.extra.myServs st.sources }


reMine : Model -> Model
reMine ({extra} as st) =
    { st
    | extra =
      { extra | myServs = List.map (MyServant.owned st.extra.mine) Servants.db }
    }


getRoot : Bool -> String
getRoot mineOnly =
    if mineOnly then
        "MyServants"
    else
        "Servants"


setRoot : Model -> Model
setRoot st =
    { st | root = getRoot st.extra.mineOnly }


component : Ports Msg -> Component Model Msg
component ports =
    let
        init : Flags -> Navigation.Key -> Model
        init flags navKey =
            Site.init (Filtering.collectFilters Filters.get) flags navKey
            (C.selfish + C.special + C.skills + C.np)
            { mine = flags.mine
            , mineOnly = False
            , ascent = 1
            , myServs = []
            , export = Nothing
            , entry = ""
            }
                |> reMine
                >> reSort flags.preferences
                >> Filtering.updateListing flags.preferences .base
                >> setRoot

        view : Preferences -> Model -> Html Msg
        view prefs st =
            let
                nav =
                    [ a_ ["Craft Essences"]
                    , if st.extra.mineOnly then
                          a_ ["Servants"]
                      else
                          text_ H.strong "Servants"
                    , if st.extra.mineOnly then
                          text_ H.strong "My Servants"
                      else
                          a_ ["My Servants"]
                    --, a_ ["Teams"]
                    ]
            in
            lazy4 unlazyView prefs st.extra.mineOnly st.listing st.sortBy
                |> Rendering.siteView prefs st SortBy.enum nav
                >> popup prefs st

        unlazyView prefs mineOnly listing sortBy =
            let
                baseAscend =
                    if prefers prefs MaxAscension then
                        4
                    else
                        1

                withStats (_, ms) =
                    (showStats ms, ms)

                listed =
                    if mineOnly then
                        listing
                            |> List.filter isMine
                            >> if sortBy /= Rarity then
                                   identity
                               else
                                   List.map withStats
                    else
                        listing

                getMats label f = case f <| List.map Tuple.second listed of
                    []   -> []
                    mats ->
                        [ ( label ++ "H"
                          , h_ 2 <| "Total " ++ label ++ " Materials Needed"
                          )
                        , ( label
                          , H.footer [P.class "materials"] <|
                            List.map materialEl mats
                          )
                        ]

                addButtons xs =
                    if mineOnly then
                        xs
                            ++ getMats "Ascension" Leveling.ascendWishlist
                            ++ getMats "Skill" (Leveling.skillWishlist prefs)
                            ++ [ ( "I/O"
                                , H.div [P.id "io"]
                                  [ button_ "Export" True Export
                                  , button_ "Import" True <| ReceiveCompress ""
                                  ]
                                )
                              ]
                    else
                        xs
            in
            listed
                |> List.map (keyedPortrait False prefs mineOnly baseAscend)
                >> (if sortBy == Rarity then identity else List.reverse)
                >> addButtons
                >> Keyed.node "section" [P.id "content"]

        update : Preferences -> Msg -> Model -> (Model, Cmd Msg)
        update prefs a ({extra} as st) =
            let
                relist = Filtering.updateListing prefs .base
            in
            case a of
                Ascend ms ascent -> case ms.level of
                    0 ->
                        pure { st | extra = { extra | ascent = ascent } }

                    _ ->
                        update prefs (OnMine True { ms | ascent = ascent }) st

                Focus focus ->
                    ( { st | focus = focus, extra = { extra | ascent = 1 } }
                    , setFocus st.navKey st.root <|
                        Maybe.map (.base >> Servant.show True) focus
                    )

                OnMine keep msPreCalc ->
                    let
                        ms =
                            if keep then
                                MyServant.recalc msPreCalc
                            else
                                msPreCalc

                        mine =
                            if keep then
                                Dict.insert (Servant.ord ms.base) ms st.extra.mine
                            else
                                Dict.remove (Servant.ord ms.base) st.extra.mine
                    in
                        ( relist << reSort prefs <| reMine
                            { st
                            | extra = { extra | mine = mine }
                            , focus = Maybe.next st.focus <| Just ms
                            }
                        , Flags.storeMine ports.store mine
                        )

                Entry x ->
                    pure { st | extra = { extra | entry = x }}

                Import ->
                    (st, ports.sendDecompress st.extra.entry)

                ReceiveDecompress de  ->
                    case D.decodeString Flags.decodeMine de of
                        Ok mine ->
                            ( relist << reSort prefs <| reMine
                                { st
                                | extra =
                                    { extra | mine = mine, export = Nothing }
                                }
                            , Flags.storeMine ports.store mine
                            )

                        Err err ->
                            pure { st
                                 | extra =
                                    { extra
                                    | export = Just <| D.errorToString err
                                    }
                                 }

                Export ->
                    let
                        cmd =
                            st.extra.mine
                                |> Flags.encodeMine
                                >> E.encode 0
                                >> ports.sendCompress
                    in
                    (st, cmd)

                ReceiveCompress x ->
                    pure { st | extra = { extra | export = Just x } }

                _ ->
                    Update.siteUpdate .base
                    (Servant.show <| prefers prefs HideSpoilers)
                    (reSort prefs) effectSort prefs a st
    in
    { init = init, view = view, update = update }


showStats : MyServant -> String
showStats ms =
    String.fromInt ms.level
        ++ "/"
        ++ String.fromInt (Leveling.maxLevel ms.servant)
        ++ " "
        ++ String.join "·" (List.map String.fromInt ms.skills)


isMine : (a, MyServant) -> Bool
isMine (_, ms) =
    ms.level /= 0

-- http://localhost:8000/img/CraftEssence/Cha%CC%82teau%20d'If.png
-- http://localhost:8000/img/CraftEssence/Ch%C3%A2teau%20d'If.png
portrait : Bool -> Preferences -> Bool -> Int -> (String, MyServant)
        -> Html Msg
portrait big prefs mineOnly baseAscension (label, ms) =
    let
        name = Servant.show (prefers prefs HideSpoilers) ms.base
    in
    if not big && prefers prefs Thumbnails then
        H.a
        [ P.class "thumb"
        , P.href <| "/" ++ getRoot mineOnly ++  "/" ++ Print.url name
        , E.onClick << Focus <| Just ms
        ]
        [ToImage.servantThumb name ms.base]
    else
        let
            class =
                P.class <| "portrait stars" ++ String.fromInt ms.base.rarity

            parent =
                if big then
                    H.div [class]
                else
                    H.a
                    [ class
                    , E.onClick << Focus <| Just ms
                    , P.href <|
                      "/" ++ getRoot mineOnly ++ "/" ++ Print.url name
                    ]

            noBreak =
                noBreakName big <|
                prefers prefs HideClasses

            artorify xs =
                if prefers prefs Artorify then
                    String.replace "Altria" "Artoria" xs
                else
                    xs

            addLabel xs =
                if String.isEmpty label then
                    xs
                else
                    [text_ H.span <| noBreak label, H.br [] []] ++ xs

            ascension =
                if ms.level /= 0 then
                    ms.ascent
                else
                    baseAscension

            ascent =
                if ascension <= 1 then
                    ""
                else
                    " " ++ String.fromInt ascension
        in
        parent
        [ ToImage.image << ImagePath "Servant" <| ms.base.name ++ ascent
        , H.div [] [ ToImage.image <| ToImage.class ms.base.class ]
        , H.header [] <| addLabel [text_ H.span << noBreak <| artorify name ]
        , if big then
              H.footer []
              [ button_ "<" (ascension > 1) << Ascend ms <| ascension - 1
              , text_ H.span <| Print.stars True ms.base.rarity
              , button_ ">" (ascension < 4) << Ascend ms <| ascension + 1
              ]
          else
              H.footer [] [text_ H.span <| Print.stars True ms.base.rarity]
        ]


keyedPortrait : Bool -> Preferences -> Bool -> Int -> (String, MyServant)
             -> (String, Html Msg)
keyedPortrait big prefs mineOnly baseAscension (label, ms) =
    (ms.base.name, lazy5 portrait big prefs mineOnly baseAscension (label, ms))


popup : Preferences -> Model -> List (Html Msg) -> Html Msg
popup prefs st = case (st.dialog, st.extra.export, st.focus) of
  (True, _, _) ->
    H.div [P.id "elm", P.class <| mode prefs ++ " fade"] << (++)
    [ H.a [P.id "cover", P.href <| "/" ++ getRoot st.extra.mineOnly] []
    , effectsDialog C.allSources st.sources "Fully overcharge NP" <|
      List.map (.servant >> C.servantEffects st.sources) st.extra.myServs
    ]
  (_, Just "", _) ->
    H.div [P.id "elm", P.class <| mode prefs ++ " fade"] << (++)
    [ H.a [P.id "cover", P.href <| "/" ++ getRoot st.extra.mineOnly] []
    , H.article [P.id "focus"]
      [ H.textarea [E.onInput Entry] []
      , button_ "Import" True Import
      ]
    ]
  (_, Just export, _) ->
    H.div [P.id "elm", P.class <| mode prefs ++ " fade"] << (++)
    [ H.a [P.id "cover", P.href <| "/" ++ getRoot st.extra.mineOnly] []
    , H.article [P.id "focus"] [H.textarea [P.value export] []]
    ]
  (_, _, Nothing) ->
    H.div [P.id "elm", P.class <| mode prefs] << (++)
    [ H.a [P.id "cover", P.href <| "/" ++ getRoot st.extra.mineOnly] []
    , H.article [P.id "focus"] []
    ]
  (_, _, Just ms) ->
    let
      b   = ms.base
      s   = ms.servant
      fou = ms.fou
      link ({show} as has) tab x =
          H.a
          [ P.href <| "/" ++ getRoot st.extra.mineOnly
          , E.onClick << FilterBy <| Filters.single has tab x
          ]
          [H.text <| show x]
      npRank rank   = case rank of
        Unknown -> "--"
        _       -> Rank.show rank
      {base}        = s.stats
      {max, grail}  = b.stats
      showTables    = prefers prefs ShowTables
      showTable showCol effects xs =
          if not showTables then xs else xs ++
          [ table_ (List.map showCol <| List.range 1 5) <|
            List.map npRow (List.uniqueBy RangeInfo.ord <| Database.ranges effects)
          ]
      linkAlignment = link Has.alignment FilterTab.Alignment
      alignBox      = case s.align of
        [] ->
            [H.text "None"]
        [Neutral, Neutral] ->
            [H.text "True ", linkAlignment Neutral]
        [a1, a2, a3, a4] ->
            [ linkAlignment a1
            , H.text " "
            , linkAlignment a2
            , H.text " / "
            , linkAlignment a3
            , H.text " "
            , linkAlignment a4
            ]
        _ -> s.align |> List.concatMap (\x -> [linkAlignment x, H.text " "])
      calcWith sort =
          if SortBy.addToSort prefs sort then
            Tuple.first
          else
            Tuple.second
      calc sort =
          Dict.get (SortBy.ord sort) ms.sorted
          |> Maybe.withDefault (1/0, 1/0)
          >> calcWith sort
          >> SortBy.format sort
      skillBox i ({icon}, lvl) =
          [ H.td [] [ToImage.image <| ToImage.icon icon]
          , H.td [] << int_ 1 10 lvl <| \val ->
              OnMine True
              { ms | skills = List.updateAt i (always val) ms.skills }
          ]
      myServantBox = List.singleton <| case ms.level of
        0 ->
            button_ "+Add to My Servants" True << OnMine True <|
            MyServant.newServant s
        _ ->
            H.table []
            [ H.tr []
                [ H.td [] [text_ H.strong "Level:"]
                , H.td [] << int_ 1 100 ms.level <| \val ->
                  OnMine True { ms | level = val }
                , H.td [] [text_ H.strong "NP:"]
                , H.td [] << int_ 1 5 ms.npLvl <| \val ->
                  OnMine True { ms | npLvl = val }
                , H.td [] [text_ H.strong "+ATK:"]
                , H.td [] << int_ 0 2000 fou.atk <| \val ->
                  OnMine True { ms | fou = { fou | atk = val } }
                , H.td [] [text_ H.strong "+HP:"]
                , H.td [] << int_ 0 2000 fou.hp <| \val ->
                  OnMine True { ms | fou = { fou | hp = val } }
                ]
            , H.tr [] << (++)
                [ H.td []
                  [button_ "Delete" True << OnMine False <| MyServant.unowned s]
                , H.td [] [text_ H.strong "Skills:"]
                ] << List.concat << List.map2 skillBox (List.range 0 10) <|
                  List.zip s.skills ms.skills
            ]
      showInt =
          toFloat
          >> Print.commas
          >> H.text
          >> List.singleton
      showPercent =
          String.fromFloat
          >> flip (++) "%"
          >> H.text
          >> List.singleton
    in
      H.div [P.id "elm", P.class <| mode prefs ++ " fade"] << (++)
      [ H.a [P.id "cover", P.href <| "/" ++ getRoot st.extra.mineOnly] []
      , H.article [P.id "focus"] <|
        [ H.div []
          [ portrait True prefs st.extra.mineOnly st.extra.ascent ("", ms)
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
                , H.tr []
                [ text_ H.th "Grail"
                , H.td [] <| showInt grail.atk
                , H.td [] <| showInt grail.hp
                ]
                ]
            , table_ ["", "Q", "A", "B", "EX", "NP"]
                [ H.tr [] <<
                (::) (text_ H.th "Hits") <|
                List.map (String.fromInt >> text_ H.td)
                [ s.hits.quick
                , s.hits.arts
                , s.hits.buster
                , s.hits.ex
                , s.phantasm.hits
                ]
                ]
            , H.table []
                [ tr_ "Class"       [ link Has.class FilterTab.Class s.class ]
                , tr_ "Deck"        [ link Has.deck FilterTab.Deck s.deck ]
                , tr_ "Gender"      [ link Has.gender FilterTab.Gender s.gender ]
                , tr_ "Attribute"   [ link Has.attribute FilterTab.Attribute s.attr ]
                , tr_ "Alignment"   alignBox
                , tr_ "ID"          [H.text <| "#" ++ String.fromInt s.id]
                , tr_ "Star Weight" [H.text <| String.fromInt s.gen.starWeight]
                , tr_ "Star Rate"   <| showPercent s.gen.starRate
                , tr_ "NP/Hit"      <| showPercent s.gen.npAtk
                , tr_ "NP/Defend"   [H.text <| String.fromInt s.gen.npDef ++ "%"]
                , tr_ "Death Rate"  <| showPercent s.death
                ]
            ]
          ]
        , H.form [P.id "myservant"] myServantBox
        , h_ 2 "Noble Phantasm"
        , H.table [P.id "phantasm"]
          [ tr_ "Name" [H.text s.phantasm.name]
          , tr_ "Rank" [H.text <| npRank s.phantasm.rank]
          , tr_ "Card" [link Has.card FilterTab.Card s.phantasm.card]
          , tr_ "Class" [H.text s.phantasm.kind]
          , tr_ "Effects" <<
            showTable (String.fromInt >> (++) "NP")
            b.phantasm.effect <|
            List.map (effectEl Servants.db <| Just Has.servant) s.phantasm.effect
          , tr_ "Overcharge" <<
            showTable ((*) 100 >> String.fromInt >> flip (++) "%")
            b.phantasm.over <|
            List.map (effectEl Servants.db <| Just Has.servant) s.phantasm.over
          ]
        , h_ 2 "Active Skills"
        ] ++ List.map2 (skillEl showTables) s.skills b.skills ++
          h_ 2 "Passive Skills"
          :: List.map passiveEl s.passives ++ bondEl (CraftEssences.getBond s) ++
        [ h_ 2 "Traits"
        , H.section [] << List.intersperse (H.text ", ") <|
          List.map (link Has.trait FilterTab.Trait) s.traits
        , h_ 2 "Ascension"
        , H.table [P.class "materials"] <<
          flip List.indexedMap (ascendUpEl s.ascendUp) <| \i el ->
              H.tr []
                [ text_ H.th << String.fromInt <| i + 1
                , H.td [] <| withCost (Leveling.ascendCost s i) el
                ]
        , h_ 2 "Skill Reinforcement"
        , H.table [P.class "materials"] <<
          flip List.indexedMap (skillUpEl s.skillUp) <| \i el ->
              H.tr []
                [ text_ H.th << String.fromInt <| i + 2
                , H.td [] <| withCost (Leveling.skillCost s i) el
                ]
        , h_ 2 "Calculator"
        , H.table [P.id "calc"]
          [ H.tr []
            [ H.td []
                [ h_ 3 "NP Generation"
                , H.table []
                [ tr_ "Per Arts card" [H.text <| calc NPArts]
                , tr_ "Per full deck" [H.text <| calc NPDeck]
                ]
                ]
            , H.td []
                [ h_ 3 "NP Damage"
                , H.table []
                [ tr_ "100% Overcharge" [H.text <| calc NPDmg]
                , tr_ "500% Overcharge" [H.text <| calc NPDmgOver]
                ]
                ]
            ]
          , H.tr []
            [ H.td []
                [ h_ 3 "Star Generation"
                , H.table []
                [ tr_ "Per Quick card" [H.text <| calc StarQuick]
                , tr_ "Per full deck"  [H.text <| calc StarDeck]
                ]
                ]
            , H.td []
                [ h_ 3 "NP Special Damage"
                , H.table []
                [ tr_ "100% Overcharge" [H.text <| calc NPSpec]
                , tr_ "500% Overcharge" [H.text <| calc NPSpecOver]
                ]
                ]
            ]
          ]
        ]
      ]


ascendUpEl : Ascension -> List (List (Html Msg))
ascendUpEl x = case x of
    Clear a b c d ->
        flip List.map [a, b, c, d] <|
        (++) "Clear "
            >> H.text
            >> List.singleton

    Welfare a ->
        ImagePath "Material" a
            |> ToImage.image
            >> List.singleton
            >> List.repeat 4

    Ascension a b c d ->
        [a, b, c, d]
            |> List.map (List.map materialEl)


skillUpEl : Reinforcement -> List (List (Html Msg))
skillUpEl (Reinforcement a b c d e f g h) =
    [a, b, c, d, e, f, g, h, [ (CrystallizedLore, 1) ]]
        |> List.map (List.map materialEl)


withCost : Int -> List (Html Msg) -> List (Html Msg)
withCost a xs = case a of
  0 -> xs
  _ -> materialEl (QP, a) :: xs


materialEl : (Material, Int) -> Html Msg
materialEl (mat, amt) =
    let
        base =
            [ ToImage.src <| ToImage.material mat
            , P.title <| Material.show mat
            ]

        imageLinkEl =
            if Material.ignore mat then
                base
            else
                [ P.class "link"
                , E.onClick << FilterBy <|
                  Filters.single Has.material FilterTab.Material mat
                ] ++ base
    in
    H.div []
    [ H.img imageLinkEl []
    , text_ H.span <| "×" ++ Print.commas (toFloat amt)
    ]


skillEl : Bool -> Skill -> Skill -> Html Msg
skillEl showTables sk base =
    let
        table xs =
            if showTables then
                xs ++ [ base.effect
                            |> Database.ranges
                            >> List.uniqueBy RangeInfo.ord
                            >> List.map lvlRow
                            >> table_
                               (List.map String.fromInt <| List.range 1 10)
                      ]
            else
                xs

        cd xs =
            if sk == base then
                xs ++ "~" ++ String.fromInt (sk.cd - 2)
            else
                xs
    in
    H.section [] << table <|
    [ ToImage.image <| ToImage.icon sk.icon
    , h_ 3 <| sk.name ++ Rank.show sk.rank
    , text_ H.strong "CD: "
    , H.text << cd <| String.fromInt sk.cd
    ] ++ List.map (effectEl Servants.db <| Just Has.servant) sk.effect


passiveEl : Skill -> Html Msg
passiveEl p =
    let
        filter =
            Filtering.has (Just <| .icon >> ToImage.icon) Has.passive
            FilterTab.PassiveSkill p
    in
    H.section [] <|
    [  ToImage.image <| ToImage.icon p.icon
    , H.h3 []
    [ H.span [P.class "link", E.onClick <| FilterBy [filter]] [H.text p.name]
    , H.text <| " " ++ Rank.show p.rank
    ]
    ] ++ List.map (SkillEffect.show >> text_ H.p) p.effect

bondEl : Maybe CraftEssence -> List (Html Msg)
bondEl a =
    case a of
        Just ce ->
            [ h_ 2 "Max-Bond Craft Essence"
            , H.section []
              [ ToImage.image <| ToImage.icon ce.icon
              , H.h3 [] [a_ ["Craft Essences", ce.name]]
              , H.p [] <|
                [ text_ H.span "★★★★ "
                , text_ H.strong "ATK: ", text_ H.span "100 "
                , text_ H.strong "HP: ", text_ H.span "100"
                ] ++ List.map (effectEl Servants.db Nothing) ce.effect
              ]
            ]

        Nothing ->
            []


npRow : RangeInfo -> Html Msg
npRow r =
    let
        step =
            r.max - r.min

        col x =
            x * step + r.min
                |> toCell r.percent
    in
    H.tr [] <| List.map col [0, 0.5, 0.75, 0.825, 1.0]
