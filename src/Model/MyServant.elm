module Model.MyServant exposing
  ( MyServant
  , recalc
  , unowned, newServant, owned
  )
{-| CHALDEAS has a "My Servants" feature for users to keep track of levels
and stats for particular Servants. This module defines the container for
such information, which is a `Database.Servant` wrapper with additional
user info such as Fou stats and skill levels. -}

import Dict exposing (Dict)

import StandardLibrary exposing (dict)
import Database.Servants as Servants
import Model.Card exposing (Card(..))
import Model.Deck as Deck
import Model.Stat as Stat exposing (Stat)
import Database.Calculator as Calculator
import Model.Servant as Servant exposing (Servant)
import Model.Skill.Amount exposing (Amount(..))
import Model.Skill.SkillEffect as SkillEffect
import Site.SortBy as SortBy exposing (SortBy(..))
import Model.MyServant.GrowthCurves as GrowthCurves


type alias MyServant =
    { level   : Int
    , fou     : Stat
    , skills  : List Int
    , npLvl   : Int
    , ascent  : Int
    , base    : Servant
    , servant : Servant
    , sorted  : Dict SortBy.Ord (Float, Float)
    }


recalc : MyServant -> MyServant
recalc ms =
    let
        s =
            ms.base

        calcStats =
            Stat.add ms.fou <| GrowthCurves.lvlStats s ms.level

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
            | effect = List.map (SkillEffect.mapAmount calc) skill.effect
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
                   | effect = List.map (SkillEffect.mapAmount calcNP)
                              phantasm.effect
                   , over   = case ms.level of
                         0 -> phantasm.over
                         _ -> List.map (SkillEffect.mapAmount calcOver)
                              phantasm.over
                   }
      , skills   = List.map2 calcActives ms.skills s.skills
      }
    }


deckSum : Bool -> (Servant -> Card -> Float) -> Servant -> Float
deckSum addExtra f s =
    let
        withExtra xs =
            if addExtra then
                Extra :: xs
            else
                xs
    in
        s.deck
        |> Deck.toList
        >> withExtra
        >> List.map (f s)
        >> List.sum


toSort : Bool -> SortBy -> Servant -> Float
toSort addBonus sortBy s =
    case sortBy of
        ID           -> toFloat <| -1 * s.id
        Rarity       -> toFloat s.rarity
        ATK          -> toFloat s.stats.max.atk
        HP           -> toFloat s.stats.max.hp
        StarWeight   -> toFloat s.gen.starWeight
        NPArts       -> Calculator.npPer s Arts
        NPDeck       -> deckSum addBonus Calculator.npPer s
        StarQuick    -> Calculator.starsPer s Quick
        StarDeck     -> deckSum addBonus Calculator.starsPer s
        NPDmg        -> Calculator.npDamage addBonus False False s
        NPDmgOver    -> Calculator.npDamage addBonus False True s
        NPSpec       -> Calculator.npDamage addBonus True False s
        NPSpecOver   -> Calculator.npDamage addBonus True True s
        NPRefund     -> Calculator.npRefund addBonus False s
        NPRefundOver -> Calculator.npRefund addBonus True s
        NPInstant    -> Calculator.gaugeUp addBonus s


mapSort : MyServant -> MyServant
mapSort ms =
    let
        go sorter =
            let
                doSort addBonus =
                    toSort addBonus sorter ms.servant
            in
            (SortBy.ord sorter, (doSort True, doSort False))
    in
    { ms | sorted = dict SortBy.enum go }


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


unowneds : Dict Servant.Ord MyServant
unowneds =
    dict Servants.db <| \x ->
        (Servant.ord x, makeUnowned x)


unowned : Servant -> MyServant
unowned s =
    case Dict.get (Servant.ord s) unowneds of
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


owned : Dict Servant.Ord MyServant -> Servant -> MyServant
owned mine s =
    case Dict.get (Servant.ord s) mine of
        Just ms -> ms
        Nothing -> unowned s
