module Class.Show exposing (..)

{-| String representations.

# `Database.Base`
@docs alignment, attribute, card, class, stat, trait, icon, material
# `Database.Servant`
@docs deck, phantasmType
# `Database.Skill`
@docs amount, bonusEffect, buffCategory, buffEffect, debuffEffect, instantEffect, nameBuffEffect, nameDebuffEffect, possessiveAndSubject, rangeInfo, rank, skillEffect, special
# `Persist.Preferences`
@docs preference
# `Site.Base`
@docs filterTab, section
# `Sorting`
@docs sortBy
-}

import List.Extra as List

import StandardLibrary     exposing (..)
import Database.Base       exposing (..)
import Database.Skill      exposing (..)
import Database.Servant    exposing (Deck(..), PhantasmType(..))
import Persist.Preferences exposing (..)
import Printing            exposing (..)
import Site.Base           exposing (..)
import Sorting             exposing (..)

import Database.Icon as Icon exposing (Icon)


-------
-- BASE
-------


attribute : Attribute -> String
attribute a =
    case a of
        Man   -> "Man"
        Sky   -> "Sky"
        Earth -> "Earth"
        Star  -> "Star"
        Beast -> "Beast"


card : Card -> String
card a =
    case a of
        Quick  -> "Quick"
        Arts   -> "Arts"
        Buster -> "Buster"
        Extra  -> "Extra"


class : Class -> String
class a =
    case a of
        Shielder   -> "Shielder"
        Saber      -> "Saber"
        Archer     -> "Archer"
        Lancer     -> "Lancer"
        Rider      -> "Rider"
        Caster     -> "Caster"
        Assassin   -> "Assassin"
        Berserker  -> "Berserker"
        Ruler      -> "Ruler"
        Avenger    -> "Avenger"
        AlterEgo   -> "Alter-Ego"
        MoonCancer -> "Moon Cancer"
        Foreigner  -> "Foreigner"
        Beast1     -> "Beast I"
        Beast2     -> "Beast II"
        Beast3L    -> "Beast III/L"
        Beast3R    -> "Beast III/R"


stat : Stat -> String
stat {atk, hp} =
    "ATK: "
        ++ String.fromInt atk
        ++ ", HP: "
        ++ String.fromInt hp


trait : Trait -> String
trait a =
    case a of
        Male -> "Male"
        Female -> "Female"
        Nonbinary -> "Nonbinary"
        Lawful   -> "Lawful"
        Neutral  -> "Neutral"
        Chaotic  -> "Chaotic"
        Good     -> "Good"
        Balanced -> "Balanced"
        Evil     -> "Evil"
        Mad      -> "Mad"
        Summer   -> "Summer"
        Bride    -> "Bride"
        Servant -> "Servant"
        Human -> "Human"
        DemonBeast -> "Demon Beast"
        DivineBeast -> "Divine Beast"
        Undead -> "Undead"
        Daemon -> "Daemon"
        ArtificialDemon -> "Artificial Demon"
        Oni -> "Oni"
        EnumaElish -> "Weak to Enuma Elish"
        EarthOrSky -> "Earth/Sky"
        PseudoServant -> "Pseudo-Servant"
        DemiServant -> "Demi-Servant"
        Humanoid -> "Humanoid"
        Dragon -> "Dragon"
        WildBeast -> "Wild Beast"
        Divine -> "Divine"
        Riding -> "Riding"
        Roman -> "Roman"
        Saberface -> "Saberface"
        Arthur -> "Arthur"
        LovedOne -> "Loved One"
        Demonic -> "Demonic"
        SuperGiant -> "Super Giant"
        King -> "King"
        GreekMythMale -> "Greek Myth Male"
        Mecha -> "Mecha"
        ThreatToHumanity -> "Threat to Humanity"
        Argonaut -> "Argonaut"
        Illya -> "Illya"
        Poisoned -> "Poisoned"
        BlessingOfKur -> "Blessing of Kur"


icon : Icon -> String
icon a =
    case a of
        Icon.AllUp -> "AllUp"
        Icon.ArtsCrit -> "ArtsCrit"
        Icon.ArtsQuickUp -> "ArtsQuickUp"
        Icon.ArtsUp -> "ArtsUp"
        Icon.Avenger -> "Avenger"
        Icon.BeamUp -> "BeamUp"
        Icon.BeamDown -> "BeamDown"
        Icon.BlueStar -> "BlueStar"
        Icon.BoxLarge -> "BoxLarge"
        Icon.BoxSmall -> "BoxSmall"
        Icon.Bubbles -> "Bubbles"
        Icon.Bullseye -> "Bullseye"
        Icon.BusterArtsUp -> "BusterArtsUp"
        Icon.BusterStar -> "BusterStar"
        Icon.BusterUp -> "BusterUp"
        Icon.Cards -> "Cards"
        Icon.Circuits -> "Circuits"
        Icon.ClockSkull -> "ClockSkull"
        Icon.ClockUp -> "ClockUp"
        Icon.CrosshairUp -> "CrosshairUp"
        Icon.Crystal -> "Crystal"
        Icon.DamageUp -> "DamageUp"
        Icon.Dash -> "Dash"
        Icon.Diamonds -> "Diamonds"
        Icon.Dodge -> "Dodge"
        Icon.Eclipse -> "Eclipse"
        Icon.ExclamationUp -> "ExclamationUp"
        Icon.ExclamationDown -> "ExclamationDown"
        Icon.Face -> "Face"
        Icon.Fire -> "Fire"
        Icon.FireDown -> "FireDown"
        Icon.FireUp -> "FireUp"
        Icon.Flex -> "Flex"
        Icon.Flower -> "Flower"
        Icon.Goddess -> "Goddess"
        Icon.Heal -> "Heal"
        Icon.HealTurn -> "HealTurn"
        Icon.HealUp -> "HealUp"
        Icon.Heart -> "Heart"
        Icon.HoodUp -> "HoodUp"
        Icon.HoodDown -> "HoodDown"
        Icon.HoodX -> "HoodX"
        Icon.Horse -> "Horse"
        Icon.HPUp -> "HPUp"
        Icon.Kneel -> "Kneel"
        Icon.Leap -> "Leap"
        Icon.MagicCircle -> "MagicCircle"
        Icon.MagicDark -> "MagicDark"
        Icon.MagicLight -> "MagicLight"
        Icon.Mask -> "Mask"
        Icon.Moon -> "Moon"
        Icon.Missing -> "Missing"
        Icon.Mystic -> "Mystic"
        Icon.Niffin -> "Niffin"
        Icon.Noble -> "Noble"
        Icon.NobleRedUp -> "NobleRedUp"
        Icon.NobleTurn -> "NobleTurn"
        Icon.NobleUp -> "NobleUp"
        Icon.Ocean -> "Ocean"
        Icon.Poison -> "Poison"
        Icon.PoisonUp -> "PoisonUp"
        Icon.Potion -> "Potion"
        Icon.QuickBusterUp -> "QuickBusterUp"
        Icon.QuickUp -> "QuickUp"
        Icon.Rainbow -> "Rainbow"
        Icon.ReaperUp -> "ReaperUp"
        Icon.Road -> "Road"
        Icon.Scar -> "Scar"
        Icon.Shield -> "Shield"
        Icon.ShieldBreak -> "ShieldBreak"
        Icon.ShieldDown -> "ShieldDown"
        Icon.ShieldUp -> "ShieldUp"
        Icon.Spotlight -> "Spotlight"
        Icon.StaffUp -> "StaffUp"
        Icon.Star -> "Star"
        Icon.StarDown -> "StarDown"
        Icon.StarHaloUp -> "StarHaloUp"
        Icon.StarTurn -> "StarTurn"
        Icon.StarUp -> "StarUp"
        Icon.Stun -> "Stun"
        Icon.SwordDown -> "SwordDown"
        Icon.SwordPlus -> "SwordPlus"
        Icon.SwordUp -> "SwordUp"
        Icon.SwordShieldUp -> "SwordShieldUp"
        Icon.SwordsBlue -> "SwordsBlue"
        Icon.SwordsRed -> "SwordsRed"
        Icon.Sun -> "Sun"
        Icon.SunUp -> "SunUp"
        Icon.Teeth -> "Teeth"
        Icon.Wave -> "Wave"
        Icon.YinYang -> "YinYang"


material : Material -> String
material a =
    case a of
        CrystallizedLore -> "Crystallized Lore"
        Piece c -> class c ++ " Piece"
        Monument c -> class c ++ " Monument"
        GemOf c -> "Gem of " ++ class c
        MagicGemOf c -> "Magic Gem of " ++ class c
        SecretGemOf c -> "Secret Gem of " ++ class c
        QP -> "QP"
        BlackBeastGrease -> "Black Beast Grease"
        ClawOfChaos -> "Claw of Chaos"
        CursedBeastGallstone -> "Cursed Beast Gallstone"
        DeadlyPoisonousNeedle -> "Deadly Poisonous Needle"
        DragonFang -> "Dragon Fang"
        DragonsReverseScale -> "Dragon's Reverse Scale"
        EternalGear -> "Eternal Gear"
        EternalIce -> "Eternal Ice"
        EvilBone -> "Evil Bone"
        FoolsChain -> "Fool's Chain"
        ForbiddenPage -> "Forbidden Page"
        GhostLantern -> "Ghost Lantern"
        GreatKnightMedal -> "Great Knight Medal"
        HeartOfTheForeignGod -> "Heart of the Foreign God"
        HomunculusBaby -> "Homunculus Baby"
        LampOfEvilSealing -> "Lamp of Evil-Sealing"
        MeteorHorseshoe -> "Meteor Horseshoe"
        MysteriousDivineWine -> "Mysterious Divine Wine"
        MysticGunpowder -> "Mystic Gunpowder"
        MysticSpinalFluid -> "Mystic Spinal Fluid"
        OctupletCrystals -> "Octuplet Crystals"
        PhoenixFeather -> "Phoenix Feather"
        PrimordialLanugo -> "Primordial Lanugo"
        ProofOfHero -> "Proof of Hero"
        RefinedMagatama -> "Refined Magatama"
        ScarabOfWisdom -> "Scarab of Wisdom"
        SeedOfYggdrasil -> "Seed of Yggdrasil"
        SerpentJewel -> "Serpent Jewel"
        ShellOfReminiscence -> "Shell of Reminiscence"
        SpiritRoot -> "Spirit Root"
        StakeOfWailingNight -> "Stake of Wailing Night"
        TearstoneOfBlood -> "Tearstone of Blood"
        VoidsDust -> "Void's Dust"
        WarhorsesYoungHorn -> "Warhorse's Young Horn"


----------
-- SERVANT
----------


servant : Bool -> Database.Servant.Servant -> String
servant hide x =
    if hide then
        case x.spoiler of
            Just y  -> class x.class ++ " of " ++ y
            Nothing -> x.name
    else
        x.name


deck : Deck -> String
deck (Deck a b c d e) =
    [a, b, c, d, e]
        |> List.map (card >> String.left 1)
        >> String.concat


phantasmType : PhantasmType -> String
phantasmType a =
    case a of
        SingleTarget -> "Single-Target"
        MultiTarget  -> "Multi-Target"
        Support      -> "Support"


--------
-- SKILL
--------


buffCategory : BuffCategory -> String
buffCategory a =
    case a of
        BuffOffensive  -> "Offensive"
        BuffDefensive  -> "Defensive"
        BuffSupport    -> "Support"
        BuffUtility    -> "Utility"
        BuffSpecialist -> "Specialist"


amount : Amount -> String
amount a =
    case a of
        Placeholder -> "X"
        Full        -> ""
        Flat x      -> String.fromFloat x
        Range x y   -> String.fromFloat x ++ "~" ++ String.fromFloat y


rank : Rank -> String
rank a =
    case a of
        Unknown       -> ""
        EX            -> " EX"
        APlusPlusPlus -> " A+++"
        APlusPlus     -> " A++"
        APlus         -> " A+"
        A             -> " A"
        AMinus        -> " A-"
        BPlusPlusPlus -> " A+++"
        BPlusPlus     -> " B++"
        BPlus         -> " B+"
        B             -> " B"
        BMinus        -> " B-"
        CPlusPlusPlus -> " C+++"
        CPlusPlus     -> " C++"
        CPlus         -> " C+"
        C             -> " C"
        CMinus        -> " C-"
        DPlusPlusPlus -> " D+++"
        DPlus         -> " D+"
        D             -> " D"
        EPlus         -> " E+"
        E             -> " E"
        EMinus        -> " E-"


rangeInfo : RangeInfo -> String
rangeInfo r =
    places 2 r.min
        ++ "% ~ "
        ++ places 2 r.max
        ++ if r.percent then "" else "%"


special : Special -> String
special a =
    (\s -> "[" ++ s ++ "]") <|
    case a of
        VsAttribute x -> attribute x
        VsClass x     -> class x
        VsTrait x     -> trait x


bonusEffect : BonusType -> Amount -> BonusEffect -> String
bonusEffect isPerc amt a =
    let
        n =
            case isPerc of
                Percent -> amount amt ++ "%"
                Units   -> amount amt

        gain x =
            "Increase " ++ x ++ " gained by " ++ n
    in
    case a of
        Bond         -> gain "Bond Points"
        EXP          -> gain "Master EXP"
        FriendPoints -> "Friend Points obtained from support becomes +" ++ n
        MysticCode   -> gain "Mystic Code EXP"
        QPDrop       -> "Increase QP from completing quests by " ++ n
        QPQuest      -> "Increase QP from enemy drops by " ++ n


instantEffect : Target -> Amount -> InstantEffect -> String
instantEffect target amt a =
    let
        n =
            amount amt

        {p, s} =
            possessiveAndSubject target

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
            "Apply [" ++ trait t ++ "]" ++ to
                ++ (if full then "" else " for " ++ n ++ " turns")

        Avenge ->
            "At the end of the next turn, deal "
                ++ n ++ "% of damage taken during that turn" ++ to

        BecomeHyde ->
            "Transform into Hyde. Class: [Berserker]. Star Weight: 9. Star Rate: 5%. NP/Hit: 1.02%. NP/Defend: 5%. Alignment: Chaotic Evil. Lose ["
                ++ trait LovedOne
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
            "Remove" ++ p ++ " " ++ unCamel (nameBuffEffect ef) ++ " buffs"

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
            "Deal " ++ n ++ "% extra damage to " ++ special x


debuffEffect : Target -> Amount -> DebuffEffect -> String
debuffEffect target amt a =
    let
        n =
            amount amt

        {p, s} =
            possessiveAndSubject target

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
        CardVuln c   -> reduce <| "defense against " ++ card c ++ " cards"
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


nameDebuffEffect : DebuffEffect -> String
nameDebuffEffect a =
    case a of
        AttackDown   -> "AttackDown"
        BuffBlock    -> "BuffBlock"
        AttackBuffDown     -> "AttackBuffDown"
        Burn         -> "Burn"
        CardVuln c   -> "CardVuln " ++ card c
        Charm        -> "Charm"
        CharmVuln    -> nameDebuffEffect DebuffVuln
        Confusion    -> "Confusion"
        CritChance   -> "CritChance"
        CritDown     -> "CritDown"
        Curse        -> "Curse"
        DamageVuln   -> "DamageVuln"
        DeathVuln    -> "DeathVuln"
        DebuffDown   -> "DebuffDown"
        DebuffVuln   -> "DebuffVuln"
        DefenseDown  -> "DefenseDown"
        Fear         -> "Fear"
        HPDown       -> "HPDown"
        HealDown     -> "HealDown"
        HealthLoss   -> "HealthLoss"
        MentalVuln   -> nameDebuffEffect DebuffVuln
        NPDown       -> "NPDown"
        Pig          -> "Pig"
        Poison       -> "Poison"
        PoisonVuln   -> "PoisonVuln"
        SealNP       -> "SealNP"
        SealSkills   -> "SealSkills"
        StarDown     -> "StarDown"
        Stun         -> "Stun"


buffEffect : Target -> Amount -> BuffEffect -> String
buffEffect target amt a =
    let
        n =
            amount amt

        {p, s} =
            possessiveAndSubject target

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
        CardGather c     -> increase <| card c ++ " C. Star absorption"
        CardUp c         -> increase <| card c ++ " performance"
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
        NoAffinity c     -> "Negate [" ++ class c ++ "] class affinity"
        NoDisadvantage   -> "Ignore class disadvantage when taking damage"
        NPUp             -> increase "NP Damage"
        NPFromDamage     -> increase "NP generation rate when taking damage"
        NPGen            -> increase "NP generation rate"
        OffensiveResist  -> resist "offensive debuffs"
        Overcharge       -> "Overcharge" ++ p ++ " NP by " ++ n ++ " stages"
        Resist debuff    -> resist <| nameDebuffEffect debuff
        Special ef x     -> buffEffect target amt ef ++  " against " ++ special x
        StarUp           -> increase "C. Star drop rate"
        Success debuff   -> success <| nameDebuffEffect debuff
        SureHit          -> grant "Sure Hit"
        Taunt            -> "Draw attention of all enemies" ++ to
        StarsPerTurn     -> "Gain " ++ n ++ " stars every turn"


nameBuffEffect : BuffEffect -> String
nameBuffEffect a =
    case a of
        AttackUp         -> "AttackUp"
        BuffRemoveResist -> "BuffRemoveResist"
        BuffUp           -> "BuffUp"
        CardGather c     -> "CardGather " ++ card c
        CardUp c         -> "CardUp " ++ card c
        CharmResist      -> "CharmResist"
        CritPerHealth    -> nameBuffEffect CritUp
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
        GutsPercent      -> nameBuffEffect Guts
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
        MentalResist     -> nameBuffEffect DebuffResist
        MentalSuccess    -> nameBuffEffect DebuffUp
        NoAffinity _     -> "NoAffinity"
        NoDisadvantage   -> "NoDisadvantage"
        NPUp             -> "NPUp"
        NPFromDamage     -> "NPFromDamage"
        NPGen            -> "NPGen"
        OffensiveResist  -> nameBuffEffect DebuffResist
        Overcharge       -> "Overcharge"
        Resist _         -> nameBuffEffect DebuffResist
        Special ef _     -> nameBuffEffect ef
        StarUp           -> "StarUp"
        Success _        -> nameBuffEffect DebuffUp
        SureHit          -> "SureHit"
        Taunt            -> "Taunt"
        StarsPerTurn     -> "StarsPerTurn"


skillEffect : SkillEffect -> String
skillEffect =
    let
        uncap s =
            case String.uncons s of
                Just (head, tail) ->
                    String.toLower (String.fromChar head) ++ tail

                Nothing ->
                    s

        addPeriod s =
            if String.endsWith ":" s then
                s
            else
                s ++ "."

        go a =
            case a of
                Grant t dur buff amt ->
                    buffEffect t amt buff ++ turns dur

                Debuff t dur deb amt ->
                    debuffEffect t amt deb ++ turns dur

                To t instant amt ->
                    instantEffect t amt instant

                Bonus bonus perc amt ->
                    bonusEffect perc amt bonus

                Chance 0 ef ->
                    "Chance to " ++ uncap (go ef)

                Chance per ef ->
                    String.fromInt per ++ "% chance to " ++ uncap (go ef)

                Chances x y ef ->
                    String.fromInt x ++ "~" ++ String.fromInt y
                        ++ "% chance to " ++ uncap (go ef)

                When cond ef ->
                    if String.startsWith "attacking" cond then
                        go ef ++ " when " ++ cond
                    else
                        "If " ++ cond ++ ": " ++ uncap (go ef)

                Times 1 ef ->
                    go ef ++ " (1 time)"

                Times times ef ->
                    go ef ++ " (" ++ String.fromInt times ++ " times)"

                ToMax amt ef ->
                    go ef ++ " every turn (max " ++ amount amt ++ ")"

                After 1 ef ->
                    "After 1 turn: " ++ go ef

                After amt ef ->
                    "After " ++ String.fromInt amt ++ " turns: " ++ go ef

        turns a =
            case a of
                0 -> ""
                1 -> " for 1 turn"
                _ -> " for " ++ String.fromInt a ++ " turns"
    in
    go
        >> addPeriod


possessiveAndSubject : Target -> { p : String, s : String }
possessiveAndSubject a =
    case a of
        Someone ->
            { p = ""
            , s = ""
            }

        Self ->
            { p = " own"
            , s = " self"
            }

        Ally ->
            { p = " one ally's"
            , s = " one ally"
            }

        Party ->
            { p = " party's"
            , s = " party"
            }

        Enemy ->
            { p = " one enemy's"
            , s = " one enemy"
            }

        Enemies ->
            { p = " all enemy"
            , s = " all enemies"
            }

        Others ->
            { p = " allies' (excluding self)"
            , s = " allies (excluding self)"
            }

        AlliesType t ->
            { p = " [" ++ trait t ++ "] allies'"
            , s = " [" ++ trait t ++ "] allies"
            }

        EnemyType t ->
            { p = " one [" ++ trait t ++ "] enemy's"
            , s = " one [" ++ trait t ++ "] enemy"
            }

        EnemiesType t ->
            { p = " all [" ++ trait t ++ "] enemy"
            , s = " all [" ++ trait t ++ "] enemies"
            }
        Killer ->
            { p = " killer's"
            , s = " killer"
            }

        Target ->
            { p = " target's"
            , s = " target"
            }


--------------
-- PREFERENCES
--------------


preference : Preference -> String
preference a =
    case a of
        AddExtra     -> "Sort with Extra card in deck"
        AddSkills    -> "Add skills to NP"
        Artorify     -> "Artorify"
        ExcludeSelf  -> "Exclude self-applied effects"
        HideClasses  -> "Hide (Class) in names"
        HideSpoilers -> "Hide Servant name spoilers"
        MaxAscension -> "Show all at max ascension"
        NightMode    -> "Night Mode"
        ShowTables   -> "Show skill and NP tables"
        Thumbnails   -> "Thumbnails"


----------
-- Base
----------


section : Section -> String
section a =
    case a of
        SectionBrowse   -> "Browse"
        SectionSettings -> "Settings"
        SectionSortBy   -> "Sort By"
        SectionInclude  -> "Include"
        SectionFilter   -> "Filter"


filterTab : FilterTab -> String
filterTab a =
    case a of
        FilterAction       -> "Action"
        FilterAlignment    -> "Alignment"
        FilterAttribute    -> "Attribute"
        FilterAvailability -> "Availability"
        FilterBonus        -> "Bonus"
        FilterBuff c       -> "Buff (" ++ buffCategory c ++ ")"
        FilterCard         -> "NP Card"
        FilterClass        -> "Class"
        FilterDamage       -> "Damage"
        FilterDebuff       -> "Debuff"
        FilterDeck         -> "Deck"
        FilterEventBonus   -> "Event Bonus"
        FilterGender       -> "Gender"
        FilterMaterial     -> "Material"
        FilterPassiveSkill -> "Passive Skill"
        FilterPhantasm     -> "NP Type"
        FilterRarity       -> "Rarity"
        FilterSource       -> "Source"
        FilterTrait        -> "Trait"


----------
-- SORTING
----------


sortBy : SortBy -> String
sortBy a =
    case a of
        ATK          -> "ATK"
        HP           -> "HP"
        ID           -> "ID"
        NPArts       -> "NP Gain per Arts card"
        NPDeck       -> "NP Gain per full deck"
        NPDmg        -> "NP Damage"
        NPDmgOver    -> "NP Damage + Overcharge"
        NPRefund     -> "NP Refund"
        NPRefundOver -> "NP Refund + Overcharge"
        NPSpec       -> "NP Special Damage"
        NPSpecOver   -> "NP Special + Overcharge"
        Rarity       -> "Rarity"
        StarDeck     -> "Stars per full deck"
        StarQuick    -> "Stars per Quick card"
        StarWeight   -> "Star Weight"
