module Model.Skill.BuffEffect exposing
  ( BuffEffect(..)
  , category
  , show, name
  )

import Model.Card as Card exposing (Card)
import Model.Class as Class exposing (Class)
import Model.Skill.Amount as Amount exposing (Amount(..))
import Model.Skill.BuffCategory exposing (BuffCategory(..))
import Model.Skill.DebuffEffect as DebuffEffect exposing (DebuffEffect)
import Model.Skill.Special as Special exposing (Special)
import Model.Skill.Target as Target exposing (Target)


type BuffEffect
    = AttackUp
    | CardGather Card
    | CardUp Card
    | BuffRemoveResist
    | BuffUp
    | CharmResist
    | CritPerHealth
    | CritUp
    | DamageCut
    | DamageUp
    | DebuffResist
    | DebuffUp
    | DefenseUp
    | Evasion
    | GatherDown
    | GatherUp
    | GaugePerTurn
    | Guts
    | GutsPercent
    | HealPerTurn
    | HealingReceived
    | HealUp
    | HitCount
    | IgnoreDef
    | IgnoreInvinc
    | Invincibility
    | DeathResist
    | DeathUp
    | HPUp
    | MentalResist
    | MentalSuccess
    | NoAffinity Class
    | NoDisadvantage
    | NPUp
    | NPFromDamage
    | NPGen
    | OffensiveResist
    | Overcharge
    | Resist DebuffEffect
    | Special BuffEffect Special
    | StarUp
    | StarsPerTurn
    | Success DebuffEffect
    | SureHit
    | Taunt


category : BuffEffect -> BuffCategory
category a =
    case a of
        AttackUp         -> Offensive
        CardUp _         -> Offensive
        BuffRemoveResist -> Utility
        BuffUp           -> Utility
        CardGather _     -> Support
        CharmResist      -> Utility
        CritPerHealth    -> Offensive
        CritUp           -> Offensive
        DamageCut        -> Defensive
        DamageUp         -> Offensive
        DebuffResist     -> Utility
        DebuffUp         -> Utility
        DefenseUp        -> Defensive
        Evasion          -> Defensive
        GatherDown       -> Support
        GatherUp         -> Support
        GaugePerTurn     -> Support
        Guts             -> Defensive
        GutsPercent      -> Defensive
        HealingReceived  -> Support
        HealPerTurn      -> Defensive
        HealUp           -> Support
        HitCount         -> Support
        IgnoreDef        -> Offensive
        IgnoreInvinc     -> Offensive
        Invincibility    -> Defensive
        DeathResist      -> Utility
        DeathUp          -> Utility
        HPUp             -> Defensive
        MentalResist     -> Utility
        MentalSuccess    -> Utility
        NoAffinity _     -> Offensive
        NoDisadvantage   -> Defensive
        NPUp             -> Offensive
        NPFromDamage     -> Support
        NPGen            -> Support
        OffensiveResist  -> Utility
        Overcharge       -> Support
        Resist _         -> Utility
        Special _ _      -> Specialist
        StarUp           -> Support
        StarsPerTurn     -> Support
        Success _        -> Utility
        SureHit          -> Offensive
        Taunt            -> Defensive


show : Target -> Amount -> BuffEffect -> String
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

        by =
            " by " ++ n ++ "%"

        grant x =
            "Grant" ++ s ++ " " ++ x

        decrease x =
            "Decrease" ++ p ++ " " ++ x ++ by

        increase x =
            "Increase" ++ p ++ " " ++ x ++ by

        success x =
            increase <| x ++ " success rate"

        resist x =
            case amt of
                Full -> "Grant" ++ s ++ " " ++ x ++ " immunity"
                _    -> "Increase" ++ p ++ " " ++ x ++ " resistance" ++ by
    in
    case a of
        AttackUp         -> increase "attack"
        CardGather c     -> increase <| Card.show c ++ " C. Star absorption"
        CardUp c         -> increase <| Card.show c ++ " performance"
        BuffRemoveResist -> resist "Buff Removal"
        BuffUp           -> success "buff"
        CharmResist      -> resist "Charm"
        CritPerHealth    -> "Increase " ++ p ++ " critical damage by up to " ++ n ++ "% based on missing health"
        CritUp           -> increase "critical damage"
        DamageCut        -> "Reduce" ++ p ++ " damage taken by " ++ n
        DamageUp         -> "Increase" ++ p ++ " damage by " ++ n
        DebuffResist     -> resist "debuff"
        DebuffUp         -> success "debuff"
        DefenseUp        -> increase "defense"
        Evasion          -> grant "Evasion"
        GatherDown       -> decrease "C. Star absorption"
        GatherUp         -> increase "C. Star absorption"
        GaugePerTurn     -> "Charge" ++ p ++ " NP gauge" ++ by ++ " every turn"
        Guts             -> "Grant" ++ s ++ " Guts with " ++ n ++ " HP"
        GutsPercent      -> "Grant" ++ s ++ " Guts with " ++ n ++ "% HP"
        HealingReceived  -> increase "healing received"
        HealPerTurn      -> "Restore " ++ n ++ " HP" ++ to
        HealUp           -> increase "healing power"
        HitCount         -> "Multiply number of hits per attack by " ++ n ++ "%"
        IgnoreDef        -> grant "Ignore Defense"
        IgnoreInvinc     -> grant "Ignore Invincibility"
        Invincibility    -> grant "Invincibility"
        DeathResist      -> resist "Death"
        DeathUp          -> success "Death"
        HPUp             -> "Increase" ++ p ++ " maximum HP by " ++ n
        MentalResist     -> resist "mental debuff"
        MentalSuccess    -> success "mental debuff"
        NoAffinity c     -> "Negate [" ++ Class.show c ++ "] class affinity"
        NoDisadvantage   -> "Ignore class disadvantage when taking damage"
        NPUp             -> increase "NP Damage"
        NPFromDamage     -> increase "NP generation rate when taking damage"
        NPGen            -> increase "NP generation rate"
        OffensiveResist  -> resist "offensive debuffs"
        Overcharge       -> "Overcharge" ++ p ++ " NP by " ++ n ++ " stages"
        Resist debuff    -> resist <| DebuffEffect.name debuff
        Special ef x     -> show target amt ef ++  " against " ++ Special.show x
        StarUp           -> increase "C. Star drop rate"
        Success debuff   -> success <| DebuffEffect.name debuff
        SureHit          -> grant "Sure Hit"
        Taunt            -> "Draw attention of all enemies" ++ to
        StarsPerTurn     -> "Gain " ++ n ++ " stars every turn"


name : BuffEffect -> String
name a =
    case a of
        AttackUp         -> "AttackUp"
        BuffRemoveResist -> "BuffRemoveResist"
        BuffUp           -> "BuffUp"
        CardGather c     -> "CardGather " ++ Card.show c
        CardUp c         -> "CardUp " ++ Card.show c
        CharmResist      -> "CharmResist"
        CritPerHealth    -> name CritUp
        CritUp           -> "CritUp"
        DamageCut        -> "DamageCut"
        DamageUp         -> "DamageUp"
        DebuffResist     -> "DebuffResist"
        DebuffUp         -> "DebuffUp"
        DefenseUp        -> "DefenseUp"
        Evasion          -> "Evasion"
        GatherDown       -> "GatherDown"
        GatherUp         -> "GatherUp"
        GaugePerTurn     -> "GaugePerTurn"
        Guts             -> "Guts"
        GutsPercent      -> name Guts
        HealingReceived  -> "HealingReceived"
        HealPerTurn      -> "HealPerTurn"
        HealUp           -> "HealUp"
        HitCount         -> "HitCount"
        IgnoreDef        -> "IgnoreDef"
        IgnoreInvinc     -> "IgnoreInvinc"
        Invincibility    -> "Invincibility"
        DeathResist      -> "DeathResist"
        DeathUp          -> "DeathUp"
        HPUp             -> "HPUp"
        MentalResist     -> name DebuffResist
        MentalSuccess    -> name DebuffUp
        NoAffinity _     -> "NoAffinity"
        NoDisadvantage   -> "NoDisadvantage"
        NPUp             -> "NPUp"
        NPFromDamage     -> "NPFromDamage"
        NPGen            -> "NPGen"
        OffensiveResist  -> name DebuffResist
        Overcharge       -> "Overcharge"
        Resist _         -> name DebuffResist
        Special ef _     -> name ef
        StarUp           -> "StarUp"
        Success _        -> name DebuffUp
        SureHit          -> "SureHit"
        Taunt            -> "Taunt"
        StarsPerTurn     -> "StarsPerTurn"

