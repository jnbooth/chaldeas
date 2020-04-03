module Model.Material exposing
  ( Material(..)
  , enum
  , show
  , Ord, ord
  , ignore
  , pairWith
  )

import StandardLibrary exposing (enumToOrd)
import Model.Class as Class exposing (Class)


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


enum : List Material
enum =
    CrystallizedLore
    :: List.map Piece Class.enum
    ++ List.map Monument Class.enum
    ++ List.map GemOf Class.enum
    ++ List.map MagicGemOf Class.enum
    ++ List.map SecretGemOf Class.enum ++
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


show : Material -> String
show a =
    case a of
        CrystallizedLore -> "Crystallized Lore"
        Piece c -> Class.show c ++ " Piece"
        Monument c -> Class.show c ++ " Monument"
        GemOf c -> "Gem of " ++ Class.show c
        MagicGemOf c -> "Magic Gem of " ++ Class.show c
        SecretGemOf c -> "Secret Gem of " ++ Class.show c
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


type alias Ord =
    Int


ord : Material -> Ord
ord =
    enumToOrd enum


{-| Blacklisted `Material`s -}
ignore : Material -> Bool
ignore a =
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
