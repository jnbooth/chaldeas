module Model.Skill.InstantEffect exposing
  ( InstantEffect(..)
  , show
  , isDamage
  )

import Model.Trait as Trait exposing (Trait(..))
import Model.Skill.Amount as Amount exposing (Amount(..))
import Model.Skill.BuffEffect as BuffEffect exposing (BuffEffect)
import Model.Skill.Special as Special exposing (Special)
import Model.Skill.Target as Target exposing (Target(..))
import Print


type InstantEffect
    = ApplyAtRandom
    | ApplyTrait Trait
    | Avenge
    | BecomeHyde -- is there a better way to do this?
    | Cure
    | Damage
    | DamageThruDef
    | Death
    | DemeritCharge
    | DemeritDamage
    | DemeritGauge
    | DemeritHealth
    | DemeritKill
    | DemeritStars
    | GainStars
    | GaugeDown
    | GaugeSpend
    | GaugeUp
    | Heal
    | HealthSpend
    | LastStand
    | OverChance
    | ReduceCooldowns
    | Remove BuffEffect
    | RemoveBuffs
    | RemoveDebuffs
    | RemoveMental
    | SpecialDamage Special


show : Target -> Amount -> InstantEffect -> String
show target amt a =
    let
        n =
            Amount.show amt

        {p, s} =
            Target.possessiveAndSubject target

        to =
            case s of
                "" -> ""
                _  -> " to" ++ s

        full =
            amt == Full
    in
    case a of
        ApplyAtRandom ->
            "Apply " ++ n ++ " random effect"
                ++ (if amt /= Flat 1 then "s" else "")
                ++ " from below:"

        ApplyTrait t ->
            "Apply [" ++ Trait.show t ++ "]" ++ to
                ++ (if full then "" else " for " ++ n ++ " turns")

        Avenge ->
            "At the end of the next turn, deal "
                ++ n ++ "% of damage taken during that turn" ++ to

        BecomeHyde ->
            "Transform into Hyde. Class: [Berserker]. Star Weight: 9. Star Rate: 5%. NP/Hit: 1.02%. NP/Defend: 5%. Alignment: Chaotic Evil. Lose ["
                ++ Trait.show LovedOne
                ++ "] trait. Skills are more effective"

        Cure ->
            "Remove" ++ p ++ " poison debuffs"

        Damage ->
            "Deal " ++ n ++ "% damage" ++ to

        DamageThruDef ->
            "Deal " ++ n ++ "% damage" ++ to ++ ", ignoring defense"

        DemeritCharge ->
            "Increase" ++ s ++ " NP gauge by " ++ n

        DemeritGauge ->
            "Decrease" ++ p ++ " NP gauge by " ++ n ++ "%"

        DemeritDamage ->
            "Deal " ++ n ++ " damage" ++ to

        DemeritKill ->
            "Sacrifice" ++ s ++ " (can trigger Guts)"

        DemeritHealth ->
            "Deal " ++ n ++ " damage" ++ to ++ " down to a minimum of 1"

        DemeritStars ->
            "Spend " ++ n ++ " stars"

        GaugeDown ->
            "Reduce" ++ p ++ " NP gauge by " ++ n

        GaugeSpend ->
            "Costs " ++ n ++ "% of" ++ p ++ " NP gauge to use"

        GaugeUp ->
            "Increase" ++ p ++ " NP gauge by " ++ n ++ "%"

        Heal ->
            "Restore "
                ++ (if full then "all" else n)
                ++ " HP" ++ to

        HealthSpend ->
            "Costs " ++ n ++ " of" ++ p ++ " HP to use"

        LastStand ->
            "Deal up to " ++ n ++ "% damage based on missing health" ++ to

        OverChance ->
            "Gain " ++ n ++ "% chance to apply Overcharge buffs"

        ReduceCooldowns ->
            "Reduce" ++ p ++ " cooldowns by " ++ n

        Remove ef ->
            "Remove" ++ p ++ " "
                ++ Print.unCamel (BuffEffect.name ef)
                ++ " buffs"

        RemoveBuffs ->
            "Remove" ++ p ++ " buffs"

        RemoveDebuffs ->
            "Remove" ++ p ++ " debuffs"

        RemoveMental ->
            "Remove" ++ p ++ " mental debuffs"

        Death ->
            if full then
                "inflict Death" ++ to
            else
                n ++ "% chance to inflict Death" ++ to

        GainStars ->
            "Gain " ++ n ++ " critical stars"
                ++ case target of
                       Self -> " for yourself"
                       _    -> ""

        SpecialDamage x ->
            "Deal " ++ n ++ "% extra damage to " ++ Special.show x



isDamage : InstantEffect -> Bool
isDamage a =
    case a of
        Avenge          -> True
        Damage          -> True
        DamageThruDef   -> True
        LastStand       -> True
        SpecialDamage _ -> True
        _               -> False
