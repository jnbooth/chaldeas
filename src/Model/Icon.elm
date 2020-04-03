module Model.Icon exposing
  ( Icon(..)
  , show
  )

{-| Corresponding images are found in the [img/Skill](../../img/Skill/) folder.
Every Icon is the name of an image file prefixed with 'Icon'. For example,
`IconAllUp` corresponds to `AllUp.png`. -}
type Icon
    = AllUp
    | ArtsCrit
    | ArtsQuickUp
    | ArtsUp
    | Avenger
    | BeamUp
    | BeamDown
    | BlueStar
    | BoxLarge
    | BoxSmall
    | Bubbles
    | Bullseye
    | BusterArtsUp
    | BusterStar
    | BusterUp
    | Cards
    | Circuits
    | ClockSkull
    | ClockUp
    | CrosshairUp
    | Crystal
    | DamageUp
    | Dash
    | Diamonds
    | Dodge
    | Eclipse
    | ExclamationUp
    | ExclamationDown
    | Face
    | Fire
    | FireDown
    | FireUp
    | Flex
    | Flower
    | Goddess
    | Heal
    | HealTurn
    | HealUp
    | Heart
    | HoodUp
    | HoodDown
    | HoodX
    | Horse
    | HPUp
    | Kneel
    | Leap
    | MagicCircle
    | MagicDark
    | MagicLight
    | Mask
    | Missing
    | Moon
    | Mystic
    | Niffin
    | Noble
    | NobleRedUp
    | NobleTurn
    | NobleUp
    | Ocean
    | Poison
    | PoisonUp
    | Potion
    | QuickBusterUp
    | QuickUp
    | Rainbow
    | ReaperUp
    | Road
    | Scar
    | Shield
    | ShieldBreak
    | ShieldDown
    | ShieldUp
    | Spotlight
    | StaffUp
    | Star
    | StarDown
    | StarHaloUp
    | StarTurn
    | StarUp
    | Stun
    | SwordDown
    | SwordPlus
    | SwordUp
    | SwordShieldUp
    | SwordsBlue
    | SwordsRed
    | Sun
    | SunUp
    | Teeth
    | Wave
    | YinYang


show : Icon -> String
show a =
    case a of
        AllUp -> "AllUp"
        ArtsCrit -> "ArtsCrit"
        ArtsQuickUp -> "ArtsQuickUp"
        ArtsUp -> "ArtsUp"
        Avenger -> "Avenger"
        BeamUp -> "BeamUp"
        BeamDown -> "BeamDown"
        BlueStar -> "BlueStar"
        BoxLarge -> "BoxLarge"
        BoxSmall -> "BoxSmall"
        Bubbles -> "Bubbles"
        Bullseye -> "Bullseye"
        BusterArtsUp -> "BusterArtsUp"
        BusterStar -> "BusterStar"
        BusterUp -> "BusterUp"
        Cards -> "Cards"
        Circuits -> "Circuits"
        ClockSkull -> "ClockSkull"
        ClockUp -> "ClockUp"
        CrosshairUp -> "CrosshairUp"
        Crystal -> "Crystal"
        DamageUp -> "DamageUp"
        Dash -> "Dash"
        Diamonds -> "Diamonds"
        Dodge -> "Dodge"
        Eclipse -> "Eclipse"
        ExclamationUp -> "ExclamationUp"
        ExclamationDown -> "ExclamationDown"
        Face -> "Face"
        Fire -> "Fire"
        FireDown -> "FireDown"
        FireUp -> "FireUp"
        Flex -> "Flex"
        Flower -> "Flower"
        Goddess -> "Goddess"
        Heal -> "Heal"
        HealTurn -> "HealTurn"
        HealUp -> "HealUp"
        Heart -> "Heart"
        HoodUp -> "HoodUp"
        HoodDown -> "HoodDown"
        HoodX -> "HoodX"
        Horse -> "Horse"
        HPUp -> "HPUp"
        Kneel -> "Kneel"
        Leap -> "Leap"
        MagicCircle -> "MagicCircle"
        MagicDark -> "MagicDark"
        MagicLight -> "MagicLight"
        Mask -> "Mask"
        Moon -> "Moon"
        Missing -> "Missing"
        Mystic -> "Mystic"
        Niffin -> "Niffin"
        Noble -> "Noble"
        NobleRedUp -> "NobleRedUp"
        NobleTurn -> "NobleTurn"
        NobleUp -> "NobleUp"
        Ocean -> "Ocean"
        Poison -> "Poison"
        PoisonUp -> "PoisonUp"
        Potion -> "Potion"
        QuickBusterUp -> "QuickBusterUp"
        QuickUp -> "QuickUp"
        Rainbow -> "Rainbow"
        ReaperUp -> "ReaperUp"
        Road -> "Road"
        Scar -> "Scar"
        Shield -> "Shield"
        ShieldBreak -> "ShieldBreak"
        ShieldDown -> "ShieldDown"
        ShieldUp -> "ShieldUp"
        Spotlight -> "Spotlight"
        StaffUp -> "StaffUp"
        Star -> "Star"
        StarDown -> "StarDown"
        StarHaloUp -> "StarHaloUp"
        StarTurn -> "StarTurn"
        StarUp -> "StarUp"
        Stun -> "Stun"
        SwordDown -> "SwordDown"
        SwordPlus -> "SwordPlus"
        SwordUp -> "SwordUp"
        SwordShieldUp -> "SwordShieldUp"
        SwordsBlue -> "SwordsBlue"
        SwordsRed -> "SwordsRed"
        Sun -> "Sun"
        SunUp -> "SunUp"
        Teeth -> "Teeth"
        Wave -> "Wave"
        YinYang -> "YinYang"
