module Database.Skill exposing
  ( Amount(..), toMin, toMax
  , Rank(..)
  , Target(..), Special(..), enumSpecial, allied, isSpecial
  , BuffEffect(..)
  , BuffCategory(..), enumBuffCategory, buffCategory
  , DebuffEffect(..)
  , InstantEffect(..), isDamage
  , BonusEffect(..), BonusType(..)
  , SkillEffect(..), demerit, simplify
  , Skill
  , RangeInfo, OrdRangeInfo, ordRangeInfo
  , mapAmount
  )
{-| There are three types of skill effects in the game:
buffs, or positive status effects with a duration;
debuffs, or negative status effects with a duration;
and instant actions like gaining stars or reducing an enemy's NP gauge.

In CHALDEAS, Buffs are represented by `BuffEffect`s,
debuffs by `DebuffEffect`s, and instant actions by `InstantEffect`s.
This system is also used by passive skills, Noble Phantasm effects,
and Craft Essences.

For Craft Essences only, there are also `BonusEffect`s that increase gains
of Quartz Points, Bond, and so on. -}

import Database.Base exposing (..)
import Database.Icon exposing (Icon)


type BonusEffect
    = Bond
    | EXP
    | FriendPoints
    | MysticCode
    | QPDrop
    | QPQuest


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


type BuffCategory
    = BuffOffensive
    | BuffDefensive
    | BuffSupport
    | BuffUtility
    | BuffSpecialist


enumBuffCategory : List BuffCategory
enumBuffCategory =
    [ BuffOffensive
    , BuffDefensive
    , BuffSupport
    , BuffUtility
    , BuffSpecialist
    ]


buffCategory : BuffEffect -> BuffCategory
buffCategory a =
    case a of
        AttackUp         -> BuffOffensive
        CardUp _         -> BuffOffensive
        BuffRemoveResist -> BuffUtility
        BuffUp           -> BuffUtility
        CardGather _     -> BuffSupport
        CharmResist      -> BuffUtility
        CritPerHealth    -> BuffOffensive
        CritUp           -> BuffOffensive
        DamageCut        -> BuffDefensive
        DamageUp         -> BuffOffensive
        DebuffResist     -> BuffUtility
        DebuffUp         -> BuffUtility
        DefenseUp        -> BuffDefensive
        Evasion          -> BuffDefensive
        GatherDown       -> BuffSupport
        GatherUp         -> BuffSupport
        GaugePerTurn     -> BuffSupport
        Guts             -> BuffDefensive
        GutsPercent      -> BuffDefensive
        HealingReceived  -> BuffSupport
        HealPerTurn      -> BuffDefensive
        HealUp           -> BuffSupport
        HitCount         -> BuffSupport
        IgnoreDef        -> BuffOffensive
        IgnoreInvinc     -> BuffOffensive
        Invincibility    -> BuffDefensive
        DeathResist      -> BuffUtility
        DeathUp          -> BuffUtility
        HPUp             -> BuffDefensive
        MentalResist     -> BuffUtility
        MentalSuccess    -> BuffUtility
        NoAffinity _     -> BuffOffensive
        NoDisadvantage   -> BuffDefensive
        NPUp             -> BuffOffensive
        NPFromDamage     -> BuffSupport
        NPGen            -> BuffSupport
        OffensiveResist  -> BuffUtility
        Overcharge       -> BuffSupport
        Resist _         -> BuffUtility
        Special _ _      -> BuffSpecialist
        StarUp           -> BuffSupport
        StarsPerTurn     -> BuffSupport
        Success _        -> BuffUtility
        SureHit          -> BuffOffensive
        Taunt            -> BuffDefensive


isDamage : InstantEffect -> Bool
isDamage a =
    case a of
        Avenge          -> True
        Damage          -> True
        DamageThruDef   -> True
        LastStand       -> True
        SpecialDamage _ -> True
        _               -> False


{-| Paired with BonusEffect -}
type BonusType
    = Units
    | Percent


{-| Int field is duration -}
type SkillEffect
    = Grant Target Int BuffEffect Amount
    | Debuff Target Int DebuffEffect Amount
    | To Target InstantEffect Amount
    | Bonus BonusEffect BonusType Amount
    | Chance Int SkillEffect
    | Chances Int Int SkillEffect
    | When String SkillEffect
    | Times Int SkillEffect
    | ToMax Amount SkillEffect
    | After Int SkillEffect


mapAmount : (Float -> Float -> Amount) -> SkillEffect -> SkillEffect
mapAmount f eff =
  let
    f_ x =
        case x of
            Range a b -> f a b
            _         -> x

    go x =
        case x of
            Grant a b c d  -> Grant a b c <| f_ d
            Debuff a b c d -> Debuff a b c <| f_ d
            To a b c       -> To a b <| f_ c
            Bonus a b c    -> Bonus a b <| f_ c
            Chance a b     -> Chance a <| go b
            When a b       -> When a <| go b
            Times a b      -> Times a <| go b
            ToMax a b      -> ToMax (f_ a) <| go b
            After a b      -> After a <| go b
            Chances a b c  -> case f (toFloat a) (toFloat b) of
                Flat y      -> Chance (floor y) <| go c
                Range y z   -> Chances (floor y) (floor z) <| go c
                Placeholder -> go c
                Full        -> go c
    in
    go eff


simplify : SkillEffect -> SkillEffect
simplify a =
    case a of
        Chance _ ef    -> simplify ef
        Chances _ _ ef -> simplify ef
        When _ ef      -> simplify ef
        Times _ ef     -> simplify ef
        ToMax _ ef     -> simplify ef
        After _ ef     -> simplify ef
        _              -> a


demerit : SkillEffect -> Bool
demerit a =
    case a of
        Grant _ _ Taunt _      -> False
        Grant t _ _ _          -> not <| allied t
        Debuff t _ _ _         -> allied t
        To t Cure _            -> not <| allied t
        To t Death _           -> allied t
        To _ DemeritCharge _   -> True
        To _ DemeritDamage _   -> True
        To _ DemeritGauge _    -> True
        To _ DemeritHealth _   -> True
        To _ DemeritKill _     -> True
        To _ DemeritStars _    -> True
        To _ GaugeSpend _      -> True
        To _ HealthSpend _     -> True
        To t (Remove _) _      -> allied t
        To t RemoveBuffs _     -> allied t
        To t RemoveDebuffs _   -> not <| allied t
        To t RemoveMental _    -> not <| allied t
        To t Heal _            -> not <| allied t
        To t OverChance _      -> not <| allied t
        To t ReduceCooldowns _ -> not <| allied t
        To _ _ _               -> False
        Bonus _ _ _            -> False
        Chance _ ef            -> demerit ef
        Chances _ _ ef         -> demerit ef
        When _ ef              -> demerit ef
        Times _ ef             -> demerit ef
        ToMax _ ef             -> demerit ef
        After _ ef             -> demerit ef


type Amount
    = Placeholder
    | Full
    | Flat Float
    | Range Float Float


toMin : Amount -> Float
toMin a =
    case a of
        Placeholder -> 0
        Full        -> 0
        Flat x      -> x
        Range x _   -> x


toMax : Amount -> Float
toMax a =
    case a of
        Placeholder -> 0
        Full        -> 0
        Flat x      -> x
        Range _ y   -> y


type Rank
    = Unknown | EX
    | APlusPlusPlus | APlusPlus | APlus | A | AMinus
    | BPlusPlusPlus | BPlusPlus | BPlus | B | BMinus
    | CPlusPlusPlus | CPlusPlus | CPlus | C | CMinus
    | DPlusPlusPlus             | DPlus | D
                                | EPlus | E | EMinus


type Special
    = VsTrait Trait
    | VsClass Class
    | VsAttribute Attribute


enumSpecial : List Special
enumSpecial =
    List.map VsTrait enumTrait
    ++ List.map VsClass enumClassNpc
    ++ List.map VsAttribute enumAttribute


type Target
    = Someone
    | Self | Ally | Party | Enemy | Enemies | Others
    | AlliesType Trait | EnemyType Trait | EnemiesType Trait
    | Killer | Target


allied : Target -> Bool
allied a =
    case a of
        Self         -> True
        Ally         -> True
        Party        -> True
        Others       -> True
        AlliesType _ -> True
        _            -> False


isSpecial : Target -> Bool
isSpecial a =
    case a of
        AlliesType _  -> True
        EnemyType _   -> True
        EnemiesType _ -> True
        _             -> False


type alias RangeInfo =
    { percent : Bool
    , min     : Float
    , max     : Float
    }


type alias OrdRangeInfo = Float


ordRangeInfo : RangeInfo -> OrdRangeInfo
ordRangeInfo r =
    r.max


type alias Skill =
    { name   : String
    , rank   : Rank
    , icon   : Icon
    , cd     : Int
    , effect : List SkillEffect
    }
