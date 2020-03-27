module Database exposing (servants, getAll, ceGetAll, ranges)

{-| Packages together all information from the Database folder, including
a collection of all Servants in the [Database.Servant](./Servant/) folder. -}

import List.Extra as List

import Class.Has             exposing (..)
import Database.Base         exposing (..)
import Database.Skill        exposing (..)
import Database.Servant      exposing (..)
import Database.CraftEssence exposing (..)

import Database.Servant.Archer    exposing (archers)
import Database.Servant.Assassin  exposing (assassins)
import Database.Servant.Berserker exposing (berserkers)
import Database.Servant.Caster    exposing (casters)
import Database.Servant.Extra     exposing (extras)
import Database.Servant.Lancer    exposing (lancers)
import Database.Servant.Rider     exposing (riders)
import Database.Servant.Saber     exposing (sabers)

import Class.Show as Show


{-| All Servants available in EN. Collects the database in
[Database/Servant](./Servant/). -}
-- Note: Names _must_ be true to their EN localization.
-- GrandOrder.Wiki is only trustworthy for Servants that have been in the game
-- for a while, especially for skills.
-- Servants introduced during events and the like should be checked against
-- the official announcement.
servants : List Servant
servants =
    let
        addEarthOrSky s =
            case s.attr of
                Earth -> { s | traits = EarthOrSky :: s.traits }
                Sky   -> { s | traits = EarthOrSky :: s.traits }
                _     -> s

        addUniversal s =
            { s
            | traits   = List.sortBy Show.trait <|
                         Database.Base.Servant :: s.traits
            , passives = List.sortBy .name s.passives
            }
    in
    [ archers
    , assassins
    , berserkers
    , casters
    , extras
    , lancers
    , riders
    , sabers
    ]
        |> List.concat
        >> List.map (addEarthOrSky >> addUniversal)


{-| Retrieves all values of a `Has <a>` Enum
that at least one `<a>` in the database `has`. -}
genericGetAll : List a -> Has a b -> List b
genericGetAll xs {show, has} =
    xs
        |> List.concatMap (has False)
        >> List.sortBy show
        >> List.uniqueBy show


getAll : Has Servant a -> List a
getAll =
    genericGetAll servants


ceGetAll : Has CraftEssence a -> List a
ceGetAll =
    genericGetAll craftEssences


ranges : List SkillEffect -> List RangeInfo
ranges =
    let
        toInfo ef =
            List.map (info <| isPercent ef) <| acc ef

        isPercent =
            Show.skillEffect >> String.contains "%"

        info isPerc {from, to} =
            RangeInfo isPerc from to

        acc a =
            case a of
                Grant _ _ _ x  -> go x
                Debuff _ _ _ x -> go x
                To _ _ x       -> go x
                Bonus _ _ x    -> go x
                Chance _ ef    -> acc ef
                When _ ef      -> acc ef
                Times _ ef     -> acc ef
                ToMax _ ef     -> acc ef
                After _ ef     -> acc ef

                Chances x y ef ->
                    {from = Basics.toFloat x, to = Basics.toFloat y} :: acc ef

        go a =
            case a of
                Range x y -> [{from = x, to = y}]
                _         -> []
    in
    List.concatMap toInfo

