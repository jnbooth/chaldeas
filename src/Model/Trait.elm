module Model.Trait exposing
  ( Trait(..)
  , enum
  , show
  , alignments, genders
  )


type Trait
    -- alignment
    = Lawful | Neutral | Chaotic
    | Good | Balanced | Evil
    | Mad | Summer | Bride
    -- gender
    | Male | Female | Nonbinary
    -- category
    | Servant
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


enum : List Trait
enum =
    -- alignment
    [ Lawful , Neutral , Chaotic
    , Good , Balanced , Evil
    , Mad , Summer , Bride
    -- gender
    , Male , Female , Nonbinary
    -- category
    , Servant
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

show : Trait -> String
show a =
    case a of
        Male -> "Male"
        Female -> "Female"
        Nonbinary -> "Nonbinary"
        Lawful -> "Lawful"
        Neutral -> "Neutral"
        Chaotic -> "Chaotic"
        Good -> "Good"
        Balanced -> "Balanced"
        Evil -> "Evil"
        Mad -> "Mad"
        Summer -> "Summer"
        Bride -> "Bride"
        Servant -> "Servant"
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


alignments : List Trait
alignments =
    [ Lawful , Neutral , Chaotic
    , Good , Balanced , Evil
    , Mad , Summer , Bride
    ]


genders : List Trait
genders =
    [ Male , Female , Nonbinary ]
