module Model.Skill.DebuffEffect exposing
  ( DebuffEffect(..)
  , show, name
  )

import Model.Card as Card exposing (Card)
import Model.Skill.Amount as Amount exposing (Amount)
import Model.Skill.Target as Target exposing (Target)


type DebuffEffect
    = AttackDown
    | BuffBlock
    | AttackBuffDown
    | Burn
    | CardVuln Card
    | Charm
    | CharmVuln
    | CritChance
    | CritDown
    | Confusion
    | Curse
    | DamageVuln
    | DeathVuln
    | DebuffVuln
    | DebuffDown
    | DefenseDown
    | Fear
    | HealthLoss
    | HealDown
    | HPDown
    | MentalVuln
    | NPDown
    | Pig
    | Poison
    | PoisonVuln
    | SealNP
    | SealSkills
    | StarDown
    | Stun


show : Target -> Amount -> DebuffEffect -> String
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

        reduce x =
            "Reduce" ++ p ++ " " ++ x ++ " by " ++ n ++ "%"

        unresist x =
            reduce <| x ++ " resistance"

        damage x =
            "Inflict " ++ n ++ " " ++ x ++ " damage" ++ to ++ " every turn"

        eachTurn x perTurn =
            "Inflict " ++ x ++ " status" ++ to ++ ", causing "
                ++ n ++ "% chance to " ++ perTurn ++ " every turn"
    in
    case a of
        AttackDown   -> reduce "attack"
        BuffBlock    -> "Inflict Buff Block status" ++ to
        AttackBuffDown     -> reduce "attack buff success rate"
        Burn         -> damage "Burn"
        CardVuln c   -> reduce <| "defense against " ++ Card.show c ++ " cards"
        Charm        -> "Charm" ++ s
        CharmVuln    -> unresist "Charm"
        Confusion    -> eachTurn "Confusion" "Seal skills"
        CritChance   -> reduce "critical attack chance"
        CritDown     -> reduce "critical damage"
        Curse        -> damage "Curse"
        DamageVuln   -> "Increase" ++ s ++ " damage taken by " ++ n
        DeathVuln    -> unresist "Death"
        DebuffDown   -> reduce "debuff success rate"
        DebuffVuln   -> unresist "debuff"
        DefenseDown  -> reduce "defense"
        Fear         -> eachTurn "Fear" "be Stunned"
        HealDown     -> reduce "healing power"
        HealthLoss   -> "Decrease" ++ p ++ " HP by " ++ n ++ " per turn"
        HPDown       -> reduce "maximum HP"
        MentalVuln   -> unresist "mental debuff"
        NPDown       -> reduce "NP Damage"
        Pig          -> "Stun" ++ s ++ " by applying Pig Transformation"
        Poison       -> damage "Poison"
        PoisonVuln   -> "Increase" ++ s ++ " poison damage taken by " ++ n ++ "%"
        SealNP       -> "Seal" ++ p ++ " NP"
        SealSkills   -> "Seal" ++ p ++ " skills"
        StarDown     -> reduce "C. Star drop rate"
        Stun         -> "Stun" ++ s


name : DebuffEffect -> String
name a =
    case a of
        AttackDown     -> "AttackDown"
        BuffBlock      -> "BuffBlock"
        AttackBuffDown -> "AttackBuffDown"
        Burn           -> "Burn"
        CardVuln c     -> "CardVuln " ++ Card.show c
        Charm          -> "Charm"
        CharmVuln      -> name DebuffVuln
        Confusion      -> "Confusion"
        CritChance     -> "CritChance"
        CritDown       -> "CritDown"
        Curse          -> "Curse"
        DamageVuln     -> "DamageVuln"
        DeathVuln      -> "DeathVuln"
        DebuffDown     -> "DebuffDown"
        DebuffVuln     -> "DebuffVuln"
        DefenseDown    -> "DefenseDown"
        Fear           -> "Fear"
        HPDown         -> "HPDown"
        HealDown       -> "HealDown"
        HealthLoss     -> "HealthLoss"
        MentalVuln     -> name DebuffVuln
        NPDown         -> "NPDown"
        Pig            -> "Pig"
        Poison         -> "Poison"
        PoisonVuln     -> "PoisonVuln"
        SealNP         -> "SealNP"
        SealSkills     -> "SealSkills"
        StarDown       -> "StarDown"
        Stun           -> "Stun"
