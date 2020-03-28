module MyServant exposing
  ( MyServant
  , recalc
  , unowned, newServant, owned
  )
{-| CHALDEAS has a "My Servants" feature for users to keep track of levels
and stats for particular Servants. This module defines the container for
such information, which is a `Database.Servant` wrapper with additional
user info such as Fou stats and skill levels. -}

import Dict exposing (Dict)

import StandardLibrary        exposing (..)
import Database               exposing (..)
import Database.Base          exposing (..)
import Database.Calculator    exposing (..)
import Database.Skill         exposing (..)
import Database.Servant       exposing (..)
import Sorting                exposing (..)
import MyServant.GrowthCurves exposing (..)

type alias MyServant =
    { level   : Int
    , fou     : Stat
    , skills  : List Int
    , npLvl   : Int
    , ascent  : Int
    , base    : Servant
    , servant : Servant
    , sorted  : Dict OrdSortBy (Float, Float)
    }


recalc : MyServant -> MyServant
recalc ms =
    let
        s =
            ms.base

        calcStats =
            addStats ms.fou <| lvlStats s ms.level

        calcNP minAmount maxAmount =
            Flat <| minAmount + (maxAmount - minAmount) * case ms.npLvl of
                1 -> 0
                2 -> 0.5
                3 -> 0.75
                4 -> 0.875
                _ -> 1

        calcOver minAmount maxAmount =
            case ms.npLvl of
                1 ->
                    Flat minAmount

                _ ->
                    Range minAmount <|
                    minAmount
                        + (maxAmount - minAmount)
                        * (toFloat ms.npLvl - 1)
                        / 4

        calcActives lvl skill =
            let
                calc minAmount maxAmount =
                    case lvl of
                        10 ->
                            Flat maxAmount

                        _  ->
                            Flat <|
                            minAmount
                                + (maxAmount - minAmount)
                                * (toFloat lvl - 1)
                                / 10
            in
            { skill
            | effect = List.map (mapAmount calc) skill.effect
            , cd     = skill.cd - (max 2 lvl - 2) // 4
            }
    in
    mapSort
    { ms
    | servant =
      { s
      | stats    = let
                       stats = s.stats
                   in
                   { stats | base = calcStats, max = calcStats }
      , phantasm = let
                       phantasm = s.phantasm
                   in
                   { phantasm
                   | effect = List.map (mapAmount calcNP) phantasm.effect
                   , over   = case ms.level of
                         0 -> phantasm.over
                         _ -> List.map (mapAmount calcOver) phantasm.over
                   }
      , skills   = List.map2 calcActives ms.skills s.skills
      }
    }


deckSum : Bool -> (Servant -> Card -> Float) -> Servant -> Float
deckSum addExtra f s =
    (if addExtra then Extra :: getDeck s else getDeck s)
        |> List.map (f s)
        >> List.sum


toSort : Bool -> SortBy -> Servant -> Float
toSort addBonus sortBy s =
    case sortBy of
        ID           -> toFloat <| -1 * s.id
        Rarity       -> toFloat s.rarity
        ATK          -> toFloat s.stats.max.atk
        HP           -> toFloat s.stats.max.hp
        StarWeight   -> toFloat s.gen.starWeight
        NPArts       -> npPer s Arts
        NPDeck       -> deckSum addBonus npPer s
        StarQuick    -> starsPer s Quick
        StarDeck     -> deckSum addBonus starsPer s
        NPDmg        -> npDamage addBonus False False s
        NPDmgOver    -> npDamage addBonus False True s
        NPSpec       -> npDamage addBonus True False s
        NPSpecOver   -> npDamage addBonus True True s
        NPRefund     -> npRefund addBonus False s
        NPRefundOver -> npRefund addBonus True s
        NPInstant    -> gaugeUp addBonus s


mapSort : MyServant -> MyServant
mapSort ms =
    let
        go sorter =
            let
                doSort addBonus =
                    toSort addBonus sorter ms.servant
            in
            (ordSortBy sorter, (doSort True, doSort False))
    in
    { ms | sorted = dict enumSortBy go }


makeUnowned : Servant -> MyServant
makeUnowned s =
    mapSort <|
    { servant = s
    , base    = s
    , level   = 0
    , fou     = { atk = 0, hp = 0 }
    , skills  = [10, 10, 10]
    , npLvl   = if s.free then 5 else 1
    , ascent  = 1
    , sorted  = Dict.empty
    }


unowneds : Dict OrdServant MyServant
unowneds =
    dict servants <| \x ->
        (ordServant x, makeUnowned x)


unowned : Servant -> MyServant
unowned s =
    case Dict.get (ordServant s) unowneds of
        Just ms -> ms
        Nothing -> makeUnowned s -- But if this actually happens, something is weird


newServant : Servant -> MyServant
newServant s =
    { servant = s
    , base    = s
    , level   = 1
    , fou     = { atk = 0, hp = 0 }
    , skills  = [1, 1, 1]
    , npLvl   = 1
    , ascent  = 1
    , sorted  = Dict.empty
    }


owned : Dict OrdServant MyServant -> Servant -> MyServant
owned mine s =
    case Dict.get (ordServant s) mine of
        Just ms -> ms
        Nothing -> unowned s
