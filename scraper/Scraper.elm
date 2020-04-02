module Scraper exposing (..)

import Browser
import Dict exposing (Dict)
import Http
import Url.Builder as Url
import List.Extra  as List
import Maybe.Extra as Maybe

import Html            as H exposing (Html)
import Html.Attributes as P

import StandardLibrary       exposing (..)
import Database              exposing (..)
import Database.Base         exposing (..)
import Database.CraftEssence exposing (..)
import Database.Servant      exposing (..)
import Site.Common           exposing (..)
import Class.Show as Show

import Wiki      exposing (Wiki)
import MaybeRank exposing (MaybeRank(..))
import Parse     exposing (..)
import Test      exposing (Test(..), Outcome(..))


main =
    Browser.element
      { init          = init
      , update        = update
      , subscriptions = always Sub.none
      , view          = view
      }


renderTest : Test -> Html msg
renderTest a =
    case a of
        Suite name tests ->
            let
                meta =
                    if List.member name pageTitles then
                        [P.href <| pageUrl False name, P.target "wiki"]
                    else
                    []
            in
            H.li []
            [ H.a meta [H.text name]
            , H.ul [] <| List.map renderTest tests
            ]
        Test name Success ->
            H.li []
            [H.text <| name ++ ": ", H.span [P.class "success"] [H.text "Success"]]

        Test name (Failure err) ->
            H.li []
            [H.text <| name ++ ": ", H.span [P.class "failure"] [H.text err]]


pageTitles : List String
pageTitles =
    List.map .name craftEssences
        ++ List.map .name servants
        ++ List.unique (List.concatMap skillNames servants |> List.map .name)


numPages : Int
numPages =
    List.length pageTitles


type alias Model =
    { pages    : Dict String String
    , progress : Int
    , errs     : List Test
    , tests    : List Test
    }


init : () -> (Model, Cmd Msg)
init = always
    ( { pages    = Dict.empty
      , progress = 0
      , errs     = []
      , tests    = []
      }
    , requestAll
    )


type Msg = ReceivePage String (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update (ReceivePage title result) st =
    let
        newSt =
            case result of
                Ok page ->
                    { st | pages = Dict.insert title page st.pages }

                Err fail ->
                    let
                        err =
                            Debug.toString fail
                                |> maybeDo (String.split " " >> List.head)
                                >> Failure
                                >> Test title
                    in
                    { st | errs = err :: st.errs }

        newProgress =
            st.progress + 1

        tests =
            if newProgress == numPages then
                runTests newSt.pages
            else
                st.tests
    in
    ({ newSt | progress = st.progress + 1, tests = tests }, Cmd.none)


view : Model -> Html Msg
view st =
  let
    size   = Dict.size st.pages
    loaded = st.progress == numPages
    msg    = String.fromInt size ++ "/" ++ String.fromInt numPages
    scored =
      if not loaded then
        []
      else
        let
          (passed, total) = Test.score st.tests
          tot = String.fromInt total ++ " tests passed."
        in
          [ if passed == total then
              H.li [P.class "success"]
              [H.text <| "Yorokobe, shounen! All " ++ tot ]
            else
              H.li [P.class "failure"]
              [H.text <| String.fromInt passed ++ "/" ++ tot]
          ]

  in
    H.ul [] <|
    H.li [P.class "progress"]
      [ H.text <| "Loading " ++ msg ++ "..."
      , H.ul [] <| (List.map renderTest <| Test.discardSuccesses st.errs)
      ]
    :: (if not loaded then identity else (::) <|
      H.li
      [ P.class <|
        if String.fromInt size == String.fromInt numPages then
          "success"
        else
          "failure"
      ]
      [H.text <| "Loaded " ++ msg ++ "."]
    ) (List.map renderTest <| Test.discardSuccesses st.tests)
    ++ scored

pageUrl : Bool -> String -> String
pageUrl raw title =
    Url.crossOrigin "http://grandorder.wiki"
    ["index.php"]
    [ Url.string "title"  <| translate title
    , Url.string "action" <| if raw then "raw" else "view"
    ]

requestPage : String -> Cmd Msg
requestPage title =
    pageUrl True title
    |> Http.getString
    >> Http.send (ReceivePage title)

requestAll : Cmd Msg
requestAll = Cmd.batch <| List.map requestPage pageTitles

runTests : Dict String String -> List Test
runTests pages =
    List.map (Wiki.suite pages testCraftEssence) craftEssences
    ++ List.map (Wiki.suite pages testServant) servants

testCraftEssence : (MaybeRank -> Wiki) -> CraftEssence -> List Test
testCraftEssence getWiki ce =
  let
    wiki  = getWiki Unranked
    match = Wiki.match wiki
    matchInt x = match x << String.fromInt
  in
    (if Maybe.isJust ce.bond then identity else
    ((::) << Wiki.matchEffects wiki "effect" (0, 6) <| effects ce.effect))
    [ matchInt "id"           ce.id
    , matchInt "maxatk"       ce.stats.max.atk
    , matchInt "maxhp"        ce.stats.max.hp
    , matchInt "minatk"       ce.stats.base.atk
    , matchInt "minhp"        ce.stats.base.hp
    , matchInt "rarity"       ce.rarity
    , match    "imagetype" <| printIcon ce.icon
    , match    "limited"   <| Wiki.printBool ce.limited
    ]
testServant : (MaybeRank -> Wiki) -> Servant -> List Test
testServant getWiki s =
  let
    wiki  = getWiki Unranked
    match = Wiki.match wiki
    matchInt x = match x << String.fromInt
    showAttr a = case a of
      Sky -> "Heaven"
      _   -> Show.attribute a
    showAlign xs = case (s.name, xs) of
      ("Nursery Rhyme", _) -> "Changes per Master"
      (_, [x, Mad])        -> Show.trait x ++ " Madness"
      _                    -> String.join " " <| List.map Show.trait xs
    showHitcount a = case a of
      0 -> "－"
      _ -> String.fromInt a
  in
    [ Suite "Profile"
      [ matchInt "id"          s.id
      , match "class"       <| Show.class s.class
      , matchInt "rarity"      s.rarity
      , match "attribute"   <| showAttr s.attr
      , match "alignment"   <| showAlign s.align
      , match "deathresist" <| String.fromFloat s.death
      -- TODO , assert "status" <|
      ]
    , Suite "Stats"
      [ matchInt "minatk"   s.stats.base.atk
      , matchInt "maxatk"   s.stats.max.atk
      , matchInt "minhp"    s.stats.base.hp
      , matchInt "maxhp"    s.stats.max.hp
      , matchInt "grailatk" s.stats.grail.atk
      , matchInt "grailhp"  s.stats.grail.hp
      ]
    , Suite "Hitcounts"
      [ matchInt "quickhit"  s.hits.quick
      , matchInt "artshit"   s.hits.arts
      , matchInt "busterhit" s.hits.buster
      , matchInt "extrahit"  s.hits.ex
      ]
    , Suite "Generation"
      [ matchInt "starabsorption"  s.gen.starWeight
      , match "stargeneration"  <| String.fromFloat s.gen.starRate
      , match "npchargeattack"  <| String.fromFloat s.gen.npAtk
      , matchInt "npchargedefense" s.gen.npDef
      ]
    , Suite "Deck"
      [ match "commandcard" <| Show.deck s.deck
      , match "icon"        <| Show.card s.phantasm.card
      , match "hitcount"    <| showHitcount s.phantasm.hits
      ]
    , Wiki.matchList wiki "Ascension" <| showAscension s.ascendUp
    , Wiki.matchList wiki "Skill Reinforcement" <| showReinforcement s.skillUp
    , Suite "Noble Phantasm" <|
      let
        npWiki = getWiki <| npRank s
      in
        [ {-Wiki.matchOne npWiki "Name" 0 s.phantasm.name
        , Wiki.matchOne npWiki "Description" 1 s.phantasm.desc
        , -}
          Wiki.matchEffects npWiki "effect" (0, 6) <|
          effects s.phantasm.effect
        , Wiki.matchEffects npWiki "oceffect" (0, 6) <|
          effects s.phantasm.over
        ]
    ]

showMaterials : List (List (Material, Int)) -> List (List String)
showMaterials =
    List.map << List.map <| \(mat, count) ->
        Show.material mat ++ "*" ++ String.fromInt count

showAscension : Ascension -> List (List String)
showAscension z = case z of
  Clear _ _ _ _ -> []
  Welfare x -> List.repeat 4 [x ++ "*1"]
  Ascension a b c d -> showMaterials [a, b, c, d]

showReinforcement : Reinforcement -> List (List String)
showReinforcement (Reinforcement a b c d e f g h) =
    showMaterials [a, b, c, d, e, f, g, h]
