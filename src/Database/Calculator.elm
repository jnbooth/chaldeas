module Database.Calculator exposing
    ( Sources, allSources, contains
    , special, skills, passives, np, maxOver, selfish, gaugeSpend
    , npPer
    , starsPer
    , npDamage
    , npRefund
    , effectSort, servantEffects, craftEssenceEffects
    , EffectsRaw, all, has
    )

{-| Calculates information for sorting based on datamined formulas. -}

import Bitwise exposing (and, complement)
import Dict

import Model.Card exposing (Card(..))
import Model.Class as Class exposing (Class(..))
import Model.CraftEssence exposing (CraftEssence)
import Model.Servant as Servant exposing (Servant)
import Model.Skill.Amount as Amount exposing (Amount(..))
import Model.Skill.BonusEffect exposing (BonusEffect(..), BonusType(..))
import Model.Skill.BuffEffect exposing (BuffEffect(..))
import Model.Skill.DebuffEffect exposing (DebuffEffect(..))
import Model.Skill.InstantEffect as InstantEffect exposing (InstantEffect(..))
import Model.Skill.SkillEffect as SkillEffect exposing (SkillEffect(..))
import Model.Skill.Special as Special exposing (Special(..))
import Model.Skill.Target as Target exposing (Target(..))
import Print


{-| Formula source: [Beast's Lair: Mining for Bits, by Kyte](http://blogs.nrvnqsr.com/entry.php/3306-How-much-NP-do-I-get-in-combat) -}
npPer : Servant -> Card -> Float
npPer s card =
    let
        offensiveNPRate  =
            s.gen.npAtk

        firstCardBonus =
            0

        cardNpValue =
            1.5 * case card of
                Arts   -> 3
                Quick  -> 1
                Buster -> 0
                Extra  -> 1

        cardMod =
            matchSum buffs <| CardUp card

        enemyServerMod =
            1

        npChargeRateMod =
            matchSum buffs NPGen

        criticalModifier =
            1

        overkillModifier =
            1

        buffs =
            passiveBuffs s
    in
    toFloat (Servant.hits card s)
        * offensiveNPRate
        * (firstCardBonus + (cardNpValue * (1 + cardMod)))
        * enemyServerMod
        * (1 + npChargeRateMod)
        * criticalModifier
        * overkillModifier


{-| Formula source: [Beast's Lair: Mining for Bits, by Kyte](http://blogs.nrvnqsr.com/entry.php/3306-How-much-NP-do-I-get-in-combat) -}
npRefund : Servant -> Sources -> Float
npRefund s srcs =
    let
        getter =
            if srcs |> contains maxOver then
                Amount.toMax
            else
                Amount.toMin

        offensiveNPRate  =
            s.gen.npAtk

        firstCardBonus =
            0

        cardNpValue =
            1.5 * case s.phantasm.card of
                Arts   -> 3
                Quick  -> 1
                Buster -> 0
                Extra  -> 1

        {buffs} =
            effects srcs <| servantEffects srcs s

        cardMod =
            matchSum buffs <| CardUp s.phantasm.card

        enemyServerMod =
            1

        npChargeRateMod =
            matchSum buffs NPGen

        criticalModifier =
            1

        overkillModifier =
            1

        gauge =
            let
                go a =
                    case a of
                        To t GaugeUp n ->
                            if selfable t then
                                getter n
                            else
                                0

                        _ ->
                            0
            in
            s.phantasm.effect ++ s.phantasm.over
                |> List.map (SkillEffect.simplify >> go)
                >> List.sum
    in
    toFloat s.phantasm.hits
        * offensiveNPRate
        * (firstCardBonus + (cardNpValue * (1 + cardMod)))
        * enemyServerMod
        * (1 + npChargeRateMod)
        * criticalModifier
        * overkillModifier
        + gauge


{-| Formula source: [Beast's Lair: Mining for Bits, by Kyte](http://blogs.nrvnqsr.com/entry.php/3307-How-many-crit-stars-do-I-get-in-combat) -}
starsPer : Servant -> Card -> Float
starsPer s card =
    let
        baseStarRate =
            s.gen.starRate / 100

        firstCardBonus =
            0

        cardStarValue = case card of
            Quick  -> 1.3
            Arts   -> 0.15
            Buster -> 0
            Extra  -> 1

        cardMod =
            matchSum buffs <| CardUp card

        serverRate =
            0

        starDropMod =
            matchSum buffs StarUp

        enemyStarDropMod =
            0

        criticalModifier =
            0

        overkillModifier =
            1

        overkillAdd =
            0

        buffs =
            passiveBuffs s

        netMod =
            baseStarRate
                + firstCardBonus
                + (cardStarValue * (1 + cardMod))
                + serverRate
                + starDropMod
                - enemyStarDropMod
                + criticalModifier
    in
    toFloat (Servant.hits card s)
        * min 3 netMod
        * overkillModifier
        + overkillAdd


{-| Formula source: [Beast's Lair: Mining for Bits, by Kyte](http://blogs.nrvnqsr.com/entry.php/3309-How-is-damage-calculated) -}
npDamage : Servant -> Sources -> Float
npDamage s srcs =
    let
        --------------------
        -- FROM YOUR SERVANT
        --------------------

        servantAtk =
            toFloat s.stats.max.atk

        classAtkBonus =
            case s.class of
                Archer    -> 0.95
                Lancer    -> 1.05
                Caster    -> 0.9
                Assassin  -> 0.9
                Berserker -> 1.1
                Ruler     -> 1.1
                Avenger   -> 1.1
                _         -> 1

        triangleModifier =
            useIf (srcs |> contains special) Class.enumNpc
                |> List.map (VsClass >> Special AttackUp >> matchSum buffs)
                >> List.sum
                >> (+) 1

        attributeModifier =
            1

        -------------
        -- FROM CARDS
        -------------

        firstCardBonus =
            0

        cardDamageValue =
            case card of
                Quick  -> 0.8
                Arts   -> 1
                Buster -> 1.5
                Extra  -> 1

        busterChainMod =
            0

        extraCardModifier =
            1

        -----------
        -- FROM RNG
        -----------

        randomModifier =
            1

        criticalModifier =
            1

        ---------------------
        -- FROM NP PROPERTIES
        ---------------------

        npDamageMultiplier =
            [Damage, DamageThruDef]
                |> (if srcs |> contains special then (::) LastStand else identity)
                >> List.map (matchSum instants)
                >> List.sum

        superEffectiveModifier =
            useIf (srcs |> contains special) Special.enum
                |> List.map (SpecialDamage >> matchSum instants)
                >> List.maximum
                >> Maybe.withDefault 0
                >> (+) 1

        isSuperEffective =
            1.0

        directDamage =
            toFloat (max s.stats.base.hp s.stats.max.hp)
                * matchSum instants Avenge

        -------------
        -- FROM BUFFS
        -------------

        cardMod =
            matchSum buffs <| CardUp card

        atkMod =
            useIf (srcs |> contains special) Special.enum
                |> List.map (matchSum buffs << Special AttackUp)
                >> List.maximum
                >> Maybe.withDefault 0
                >> (+) (matchSum buffs AttackUp)

        defMod =
            -1 * matchSum debuffs DefenseDown

        specialDefMod =
            -0

        powerMod =
            0

        selfDamageMod =
            0

        isCrit =
            0

        critDamageMod =
            0

        isNP =
            1

        npDamageMod =
            matchSum buffs NPUp

        dmgPlusAdd =
            100 * (matchSum buffs DamageUp + matchSum debuffs DamageVuln)

        selfDmgCutAdd =
            0

        -----------
        -- INTERNAL
        -----------

        card =
            s.phantasm.card

        {buffs, debuffs, instants} =
            effects srcs <| servantEffects srcs s
    in
    if npDamageMultiplier + directDamage == 0 then
        0
    else
        servantAtk
            * npDamageMultiplier
            * ( firstCardBonus + (cardDamageValue * (1.0 + cardMod)) )
            * classAtkBonus
            * triangleModifier
            * attributeModifier
            * randomModifier
            * 0.23
            * ( 1.0 + atkMod - defMod )
            * criticalModifier
            * extraCardModifier
            * ( 1.0 - specialDefMod )
            * ( 1.0
                + powerMod
                + selfDamageMod
                + (critDamageMod * isCrit)
                + (npDamageMod * isNP)
                )
            * ( 1.0 + ((superEffectiveModifier - 1.0) * isSuperEffective) )
            + dmgPlusAdd
            + selfDmgCutAdd
            + ( servantAtk * busterChainMod )
            + directDamage


total : EffectsRaw -> SkillEffect -> Sources -> Float
total efs skillEffect srcs =
    let
        sum getter ef =
            effects srcs efs
                |> getter
                >> List.filter (Tuple.first >> (==) ef)
                >> List.map Tuple.second
                >> List.sum

        go a =
            case a of
                Grant _ _ ef _  -> sum .buffs ef
                Debuff _ _ ef _ -> sum .debuffs ef
                To _ ef _       -> sum .instants ef
                Bonus ef _ _    -> sum .bonuses ef
                Chance _ ef     -> go ef
                Chances _ _ ef  -> go ef
                When _ ef       -> go ef
                Times _ ef      -> go ef
                ToMax _ ef      -> go ef
                After _ ef      -> go ef
    in
    go skillEffect


effectSort : (a -> EffectsRaw) -> SkillEffect -> List a -> Sources -> List (String, a)
effectSort getter ef xs srcs =
    let
        isBonus =
            case ef of
                Bonus _ _ _ -> True
                _           -> False

        totaled x =
            (total (getter x) ef srcs, x)

        sortWith (x, _) (y, _) =
            if isBonus && x < 1 && y >= 1 then
                GT
            else
                compare x y

        isPercent =
            String.contains "%" <| SkillEffect.show ef

        showAmt x =
            if isBonus && x >= 1 then
                Print.places 2 x
            else if isPercent then
                Print.places 2 (x * 100) ++ "%"
            else
                Print.commas <| x * 100
    in
    xs
        |> List.map totaled
        >> List.filter (Tuple.first >> (/=) 0)
        >> List.sortWith sortWith
        >> List.map (Tuple.mapFirst showAmt)


type alias Sources =
    Int


contains : Sources -> Sources -> Bool
contains x y =
    and x y /= 0


special : Sources
special = 1

skills : Sources
skills = 2

passives : Sources
passives = 4

np : Sources
np = 8

maxOver : Sources
maxOver = 16

gaugeSpend : Sources
gaugeSpend = 32

selfish : Sources
selfish = 64


allSources : Sources
allSources =
    complement 0

type alias Effects =
    { buffs : List (BuffEffect, Float)
    , debuffs :  List (DebuffEffect, Float)
    , instants : List (InstantEffect, Float)
    , bonuses : List (BonusEffect, Float)
    }


type alias EffectsRaw =
    { skills : List SkillEffect
    , np : List SkillEffect
    , over : List SkillEffect
    , npStrength : Amount -> Float
    }


servantEffects : Sources -> Servant -> EffectsRaw
servantEffects srcs s =
    let
        {effect, over, first} =
            s.phantasm

        chargeFree ef =
            case ef of
                To _ GaugeSpend _ -> False
                _                 -> True

        unCost efs =
            useIf (contains gaugeSpend srcs || List.all chargeFree efs) efs

        skillFs =
            useIf (srcs |> contains passives) s.passives
                ++ useIf (srcs |> contains skills) s.skills
                |> List.concatMap (.effect >> unCost)
                >> List.map SkillEffect.simplify
                >> List.filter (not << SkillEffect.demerit)

        npFs =
            useIf (srcs |> contains np) effect
                |> List.map SkillEffect.simplify
                >> List.filter (not << SkillEffect.demerit)

        overFs =
            useIf (srcs |> contains np) over
                |> List.map SkillEffect.simplify
                >> List.filter (not << SkillEffect.demerit)

        firstFs =
            useIf first overFs
                |> List.take 1
    in
    { skills = skillFs
    , np = npFs
    , over = firstFs
    , npStrength = Amount.maxIf s.free
    }


craftEssenceEffects : CraftEssence -> EffectsRaw
craftEssenceEffects ce =
    { skills = []
    , np = ce.effect |> List.filter (not << SkillEffect.demerit)
    , over = []
    , npStrength = Amount.toMin
    }


all : Sources -> List EffectsRaw -> List SkillEffect
all srcs =
    let
        buff (a, x) =
            if x == 0 || isInfinite x then
                Nothing
            else
                Just <| Grant Someone 0 a Placeholder

        debuff (a, x) =
            if x == 0 || isInfinite x then
                Nothing
            else
                Just <| Debuff Someone 0 a Placeholder

        instant (a, x) =
            if x == 0 || isInfinite x || InstantEffect.isDamage a then
                Nothing
            else
                Just <| To Someone a Placeholder

        bonus (a, x) =
            if x == 0 || isInfinite x then
                Nothing
            else
                Just <| Bonus a Percent Placeholder

        collect efs =
            List.filterMap buff efs.buffs
                ++ List.filterMap debuff efs.debuffs
                ++ List.filterMap instant efs.instants
                ++ List.filterMap bonus efs.bonuses

        go dict acc xxs =
            case xxs of
                [] ->
                    acc

                x :: xs ->
                    let
                        shown =
                            SkillEffect.show x
                    in
                    case Dict.get shown dict of
                        Nothing ->
                            go (Dict.insert shown False dict) acc xs

                        Just False ->
                            go (Dict.insert shown True dict) (x :: acc) xs

                        Just True ->
                            go dict acc xs

        in
        List.map (effects srcs)
            >> List.concatMap collect
            >> go Dict.empty []
            >> List.sortBy SkillEffect.ord


has : SkillEffect -> Sources -> EffectsRaw -> Bool
has ef srcs raw =
    let
        efs =
            effects srcs raw

        go a =
            case a of
                Grant _ _ f _ ->
                    List.any (Tuple.first >> (==) f) efs.buffs

                Debuff _ _ f _ ->
                    List.any (Tuple.first >> (==) f) efs.debuffs

                To _ f _ ->
                    List.any (Tuple.first >> (==) f) efs.instants

                Bonus f _ _ ->
                    List.any (Tuple.first >> (==) f) efs.bonuses

                Chance _ f    -> go f
                Chances _ _ f -> go f
                When _ f      -> go f
                Times _ f     -> go f
                ToMax _ f     -> go f
                After _ f     -> go f
    in
    go ef


{-| Formula source: [Beast's Lair: Mining for Bits, by Kyte](http://blogs.nrvnqsr.com/entry.php/3309-How-is-damage-calculated) -}
effects : Sources -> EffectsRaw -> Effects
effects srcs raw =
    let
        overStrength =
            Amount.maxIf (srcs |> contains maxOver)

        sum go =
             List.concatMap (go Amount.toMax) raw.skills
                ++ List.concatMap (go raw.npStrength) raw.np
                ++ List.concatMap (go overStrength) raw.over

        buffs =
            sum <| \f a ->
                case a of
                    Grant t _ (Special buff _) n ->
                        useIf (contains special srcs && selfable t)
                        [(buff, f n / 100)]

                    Grant t _ buff n ->
                        useIf (selfable t) [(buff, f n / 100)]

                    _ ->
                        []

        usable t =
            (contains selfish srcs || t /= Self)
                && (contains special srcs || not (Target.isSpecial t))

        debuffs =
            sum <| \f a ->
                case a of
                    Debuff t _ debuff n ->
                        useIf (not (Target.allied t) && usable t)
                        [(debuff, f n / 100)]

                    _ ->
                        []

        instants =
            sum <| \f a ->
                case a of
                    To t instant n ->
                        useIf (usable t) [(instant, f n / 100)]

                    _ ->
                        []

        bonuses =
            sum <| \f a ->
                case a of
                    Bonus bonus Units n ->
                        [(bonus, f n)]

                    Bonus bonus Percent n ->
                        [(bonus, f n / 100)]

                    _ ->
                        []
    in
    {buffs = buffs, debuffs = debuffs, instants = instants, bonuses = bonuses}


{-| Obtains all self-granted always-active buff effects from passive skills.
Returns an array of (Buff, Strength%) pairs. -}
passiveBuffs : Servant -> List (BuffEffect, Float)
passiveBuffs s =
    let
        go a =
            case a of
                Grant t _ buff n ->
                    useIf (selfable t) <| [(buff, Amount.toMax n / 100)]

                _ ->
                    []
  in
    s.passives
        |> List.concatMap .effect
        >> List.concatMap (SkillEffect.simplify >> go)


useIf : Bool -> List a -> List a
useIf pred =
    if pred then
        identity
    else
        always []


{-| If a skill's target is not `Self`, `Ally`, or `Party`,
it cannot be self-applied and therefore should not be used in calculations. -}
selfable : Target -> Bool
selfable a =
    case a of
        Self  -> True
        Ally  -> True
        Party -> True
        _     -> False


{-| Sums up all effects of a certain type from a Servant's skills
in (Effect, Strength%) format. -}
matchSum : List (a, Float) -> a -> Float
matchSum xs k =
    xs
        |> List.map (\(k1, v) -> if k == k1 then v else 0)
        >> List.sum

{-

{-| Attacker vs. Defender. -}
classAffinity : Class -> Class -> Float
classAffinity a b =
    case (a, b) of
        (Shielder, _) -> 1
        (_, Shielder) -> 1
        (Beast2, _) -> 1
        (Beast3L, _) -> 1
        (Beast3R, _) -> 1
        (Berserker, Berserker) -> 1.5
        (Berserker, Foreigner) -> 1.5
        (Berserker, Beast2) -> 1
        (Berserker, Beast3L) -> 1
        (Berserker, Beast3R) -> 1
        (Berserker, _) -> 1.5
        (_, Berserker) -> 2

        (Saber, Archer) -> 0.5
        (Saber, Lancer) -> 2
        (Saber, Ruler) -> 0.5
        (Archer, Saber) -> 2
        (Archer, Lancer) -> 0.5
        (Archer, Ruler) -> 0.5
        (Lancer, Saber) -> 0.5
        (Lancer, Archer) -> 2
        (Lancer, Ruler) -> 0.5
        (Rider, Caster) -> 2
        (Rider, Assassin) -> 0.5
        (Rider, Ruler) -> 0.5
        (Rider, Beast1) -> 2
        (Caster, Rider) -> 0.5
        (Caster, Assassin) -> 2
        (Caster, Ruler) -> 0.5
        (Caster, Beast1) -> 2
        (Assassin, Rider) -> 2
        (Assassin, Caster) -> 0.5
        (Assassin, Ruler) -> 0.5
        (Assassin, Beast1) -> 2
        (Ruler, Avenger) -> 0.5
        (Ruler, MoonCancer) -> 2
        (Avenger, Ruler) -> 2
        (Avenger, MoonCancer) -> 0.5
        (AlterEgo, Saber) -> 0.5
        (AlterEgo, Archer) -> 0.5
        (AlterEgo, Lancer) -> 0.5
        (AlterEgo, Rider) -> 1.5
        (AlterEgo, Caster) -> 1.5
        (AlterEgo, Assassin) -> 1.5
        (AlterEgo, Foreigner) -> 2
        (AlterEgo, Beast3L) -> 1.2
        (AlterEgo, Beast3R) -> 1.2
        (MoonCancer, Ruler) -> 0.5
        (MoonCancer, Avenger) -> 2
        (MoonCancer, Beast3L) -> 1.2
        (Foreigner, AlterEgo) -> 0.5
        (Foreigner, Foreigner) -> 2
        (Foreigner, Beast3R) -> 1.2
        (Beast1, Saber) -> 2
        (Beast1, Archer) -> 2
        (Beast1, Lancer) -> 2
        _ -> 1


{-| Attacker vs. Defender. -}
attributeAffinity : Attribute -> Attribute -> Float
attributeAffinity a b =
    case (a, b) of
        (Man, Sky) -> 1.1
        (Man, Earth) -> 0.9
        (Sky, Man) -> 0.9
        (Sky, Earth) -> 1.1
        (Earth, Man) -> 1.1
        (Earth, Sky) -> 0.9
        (Star, Beast) -> 1.1
        (Beast, Star) -> 1.1
        _ -> 1

-}
