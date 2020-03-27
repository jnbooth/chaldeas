module Database.Base exposing
  ( Attribute(..), enumAttribute
  , Card(..)
  , Class(..), enumClass, enumClassNpc
  , Stat, addStats
  , Trait(..), enumTrait, alignments, genders
  , Material(..), OrdMaterial, enumMaterial, ordMaterial, ignoreMat
  , pairWith
  )

{-| Basic Enum datatypes to represent game information. -}

import StandardLibrary exposing (..)


{-| Determines the "attribute modifier" in `Database.Calculator`.
Currently used only for filters. -}
-- Note: There is a fifth category in the game, "Beast",
-- which is not represented here because only enemies can have it.
type Attribute
    = Man
    | Sky
    | Earth
    | Star
    | Beast


enumAttribute : List Attribute
enumAttribute =
    [ Man
    , Sky
    , Earth
    , Star
    , Beast
    ]


{-| The building blocks of a Servant's Deck and NP type. -}
-- Note: "Extra" cards, also known as EX, are not represented as they only
-- occur at the end of a Brave Combo.
type Card
    = Quick
    | Arts
    | Buster
    | Extra


{-| Determines the "class attack bonus" and "triangle modifier"
in `Database.Calculator`.-}
-- Note: MoonCancer and AlterEgo are not represented as they are JP-only.
type Class
    = Shielder
    | Saber | Archer | Lancer | Rider | Caster | Assassin
    | Berserker | Ruler | Avenger | AlterEgo | MoonCancer | Foreigner
    | Beast1 | Beast2 | Beast3L | Beast3R


enumClass : List Class
enumClass =
    [ Shielder
    , Saber , Archer , Lancer , Rider , Caster , Assassin
    , Berserker , Ruler , Avenger , AlterEgo , MoonCancer , Foreigner
    ]


enumClassNpc : List Class
enumClassNpc =
    enumClass ++
    [ Beast1 , Beast2 , Beast3L, Beast3R ]


{-| Craft Essences have minimum and maximum Stats.
Servants have minimum, maximum, and grail Stats. -}
type alias Stat =
    { atk : Int, hp  : Int }


{-| Used for Fou +ATK and +DEF bonuses. -}
addStats : Stat -> Stat -> Stat
addStats x y =
    { atk = x.atk + y.atk, hp = x.hp + y.hp }


{-| Traits are miscellaneous flags attached to Servants. -}
-- Note:  Since many traits are unlabeled,
-- it can be difficult to figure out which are JP-only and which
-- translations are accurate to EN.

type Trait
    -- alignment
    = Lawful | Neutral | Chaotic
    | Good | Balanced | Evil
    | Mad | Summer | Bride
    -- gender
    | Male | Female | Nonbinary
    -- category
    | Servant
    | Human
    | DemonBeast
    | DivineBeast
    | Undead
    | Daemon
    | ArtificialDemon
    -- special
    | Oni
    | EnumaElish
    | EarthOrSky
    | PseudoServant
    | DemiServant
    | Humanoid
    | Dragon
    | WildBeast
    | Divine
    | Riding
    | Roman
    | Saberface
    | Arthur
    | LovedOne
    | Demonic
    | SuperGiant
    | King
    | GreekMythMale
    | Mecha
    | ThreatToHumanity
    | Argonaut
    | Illya
    -- fake
    | Poisoned
    | BlessingOfKur

enumTrait : List Trait
enumTrait =
    -- alignment
    [ Lawful , Neutral , Chaotic
    , Good , Balanced , Evil
    , Mad , Summer , Bride
    -- gender
    , Male , Female , Nonbinary
    -- category
    , Servant
    , Human
    , DemonBeast
    , DivineBeast
    , Undead
    , Daemon
    , ArtificialDemon
    -- special
    , Oni
    , EnumaElish
    , EarthOrSky
    , PseudoServant
    , DemiServant
    , Humanoid
    , Dragon
    , WildBeast
    , Divine
    , Riding
    , Roman
    , Saberface
    , Arthur
    , LovedOne
    , Demonic
    , SuperGiant
    , King
    , GreekMythMale
    , Mecha
    , ThreatToHumanity
    , Argonaut
    , Illya
    -- fake
    , Poisoned
    , BlessingOfKur
    ]

alignments : List Trait
alignments =
    [ Lawful , Neutral , Chaotic
    , Good , Balanced , Evil
    , Mad , Summer , Bride
    ]


genders : List Trait
genders =
    [ Male , Female , Nonbinary ]

{-| Items for Ascension and Skill Reinforcement. -}
type Material
    = CrystallizedLore
    | Piece Class
    | Monument Class
    | GemOf Class
    | MagicGemOf Class
    | SecretGemOf Class
    | QP
    | BlackBeastGrease
    | ClawOfChaos
    | CursedBeastGallstone
    | DeadlyPoisonousNeedle
    | DragonFang
    | DragonsReverseScale
    | EternalGear
    | EternalIce
    | EvilBone
    | FoolsChain
    | ForbiddenPage
    | GhostLantern
    | GreatKnightMedal
    | HeartOfTheForeignGod
    | HomunculusBaby
    | LampOfEvilSealing
    | MeteorHorseshoe
    | MysteriousDivineWine
    | MysticGunpowder
    | MysticSpinalFluid
    | OctupletCrystals
    | PhoenixFeather
    | PrimordialLanugo
    | ProofOfHero
    | RefinedMagatama
    | ScarabOfWisdom
    | SeedOfYggdrasil
    | SerpentJewel
    | ShellOfReminiscence
    | SpiritRoot
    | StakeOfWailingNight
    | TearstoneOfBlood
    | VoidsDust
    | WarhorsesYoungHorn


enumMaterial : List Material
enumMaterial =
    CrystallizedLore
    :: List.map Piece enumClass
    ++ List.map Monument enumClass
    ++ List.map GemOf enumClass
    ++ List.map MagicGemOf enumClass
    ++ List.map SecretGemOf enumClass ++
    [ QP
    , BlackBeastGrease
    , ClawOfChaos
    , CursedBeastGallstone
    , DragonFang
    , DragonsReverseScale
    , EternalGear
    , EternalIce
    , EvilBone
    , FoolsChain
    , ForbiddenPage
    , GhostLantern
    , GreatKnightMedal
    , HeartOfTheForeignGod
    , HomunculusBaby
    , LampOfEvilSealing
    , MeteorHorseshoe
    , MysticGunpowder
    , OctupletCrystals
    , PhoenixFeather
    , PrimordialLanugo
    , ProofOfHero
    , ScarabOfWisdom
    , SeedOfYggdrasil
    , SerpentJewel
    , ShellOfReminiscence
    , SpiritRoot
    , StakeOfWailingNight
    , DeadlyPoisonousNeedle
    , TearstoneOfBlood
    , VoidsDust
    , WarhorsesYoungHorn
    ]


type alias OrdMaterial =
    Int


ordMaterial : Material -> OrdMaterial
ordMaterial =
    enumToOrd enumMaterial


{-| Blacklisted `Material`s -}
ignoreMat : Material -> Bool
ignoreMat a =
    case a of
        CrystallizedLore -> True
        Piece _          -> True
        Monument _       -> True
        GemOf _          -> True
        MagicGemOf _     -> True
        SecretGemOf _    -> True
        QP               -> True
        _                -> False


{-| Tuple builder from a constructor -}
pairWith : a -> (b -> c) -> List b -> List (c, a)
pairWith val construc =
    List.map <|
    construc
        >> \x -> (x, val)
