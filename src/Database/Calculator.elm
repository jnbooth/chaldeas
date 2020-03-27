module Database.Calculator exposing (npPer, starsPer, npDamage)

{-| Calculates information for sorting based on datamined formulas. -}

import StandardLibrary  exposing (..)
import Database.Base    exposing (..)
import Database.Skill   exposing (..)
import Database.Servant exposing (..)



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
    toFloat (hits card s)
        * offensiveNPRate
        * (firstCardBonus + (cardNpValue * (1 + cardMod)))
        * enemyServerMod
        * (1 + npChargeRateMod)
        * criticalModifier
        * overkillModifier


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
    toFloat (hits card s)
        * min 3 netMod
        * overkillModifier
        + overkillAdd


{-| Formula source: [Beast's Lair: Mining for Bits, by Kyte](http://blogs.nrvnqsr.com/entry.php/3309-How-is-damage-calculated) -}
npDamage : Bool -> Bool -> Bool -> Servant -> Float
npDamage addSkills special maxOver s =
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
            ifSpecial enumClassNpc
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
                |> (if not special then identity else (::) LastStand)
                >> List.map (matchSum instants)
                >> List.sum

        superEffectiveModifier =
            ifSpecial enumSpecial
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
            ifSpecial enumSpecial
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

        {card, effect, over, first} =
            s.phantasm

        costsCharge ef =
            case ef of
                To _ GaugeSpend _ -> True
                _                 -> False

        unCost efs =
            if List.any costsCharge efs then
                []
            else
                efs

        ifSpecial =
            if special then
                identity
            else
                always []

        maxIf x =
            if x then
                toMax
            else
                toMin

        npStrength =
            maxIf <| s.free || (s.rarity <= 3 && s.rarity > 0)

        overStrength =
            maxIf maxOver

        maybeAddSkills xs =
            if addSkills then
                xs
            else
                List.concatMap (.effect >> unCost) s.skills
                    ++ xs

        skillFs =
            s.passives
                |> List.concatMap .effect
                >> maybeAddSkills
                >> List.map simplify

        npFs =
            List.map simplify effect

        overFs =
            List.map simplify over

        firstFs =
            if first then
                List.take 1 overFs
            else
                []

        buffs =
            let
                go f a = case a of
                    Grant t _ (Special buff _) n ->
                        if special && selfable t then
                            [(buff, f n / 100)]
                        else
                            []

                    Grant t _ buff n ->
                        if selfable t then
                            [(buff, f n / 100)]
                        else
                            []

                    _ ->
                        []
            in
            List.concatMap (go toMax) skillFs
                ++ List.concatMap (go npStrength) npFs
                ++ List.concatMap (go overStrength) firstFs

        debuffs =
            let
                go f a =
                    case a of
                        Debuff t _ debuff n ->
                            if allied t || (not special && isSpecial t) then
                                []
                            else
                                [(debuff, f n / 100)]

                        _ ->
                            []
            in
            List.concatMap (go toMax) skillFs
                ++ List.concatMap (go npStrength) npFs
                ++ List.concatMap (go overStrength) firstFs

        instants =
            let
                go f a =
                    case a of
                        To t instant n ->
                            if allied t || (not special && isSpecial t) then
                                []
                            else
                                [(instant, f n / 100)]

                        _ ->
                            []
            in
            List.concatMap (go toMax) skillFs
                ++ List.concatMap (go npStrength) npFs
                ++ List.concatMap (go overStrength) overFs
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


{-| Obtains all self-granted always-active buff effects from passive skills.
Returns an array of (Buff, Strength%) pairs. -}
passiveBuffs : Servant -> List (BuffEffect, Float)
passiveBuffs s =
    let
        go a =
            case a of
                Grant t _ buff n ->
                    if selfable t then
                        [(buff, toMax n / 100)]
                    else
                        []
                _ ->
                    []
  in
    s.passives
        |> List.concatMap .effect
        >> List.concatMap (simplify >> go)


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
