module Database.Passives exposing (..)

{- This module defines passive skills. Unlike active skills, passives with
the same name and rank will always have identical effects. In other words,
a `Passive` is a function of type `Rank -> Skill`: it accepts a Rank
(such as `EX` or `APlus`) and returns a 'Skill'.
Passive effects use the `BuffEffects` defined in `Model.Skill`. -}

-- The easiest way to define a `Passive` is to use the `passive` helper
-- function, which accepts a name, an icon, and a mapping of `Skill` effects
-- to `Rank`s. As usual, mapping is represented in `Tuple` pairs.
-- For example, since
-- Avenger A provides 10% Debuff Resistance to the rest of the party,
-- Avenger B provides 8% Debuff Resistance, and Avenger C provides 6%,
-- the `avenger` function specifies this mapping as
-- `[A: 10.0, B: 8.0, C: 6.0]`.

import List.Extra as List

import Model.Card exposing (Card(..))
import Model.Class exposing (Class(..))
import Model.Trait exposing (Trait(..))
import Model.Skill exposing (Skill)
import Model.Skill.Amount exposing (Amount(..))
import Model.Skill.BuffEffect exposing (BuffEffect(..))
import Model.Skill.DebuffEffect exposing (DebuffEffect(..))
import Model.Skill.InstantEffect exposing (InstantEffect(..))
import Model.Skill.Rank exposing (Rank(..))
import Model.Skill.SkillEffect exposing (SkillEffect(..))
import Model.Skill.Special exposing (Special(..))
import Model.Skill.Target exposing (Target(..))


import Model.Icon as Icon exposing (Icon)


altreactor =
    passive "Altreactor" Icon.HoodUp
    [ Give Self DebuffResist [ (A, 20) ] ]


avenger =
    passive "Avenger" Icon.Avenger
    [ Give Others DebuffResist [ (A, 10), (B, 8), (C, 6) ]
    , Give Self NPFromDamage   [ (A, 20), (B, 18), (C, 16) ]
    ]


authorityOfBeasts =
    passive "Authority of Beasts" Icon.ExclamationUp
    [ Give Self CritUp [ (D, 8) ] ]


beastification =
    passive "Beastification" Icon.Teeth
    [ Give Self (CardUp Buster) [ (B, 8) ]
    , Give Self StarUp [ (B, 8) ]
    ]


civilizationEncroachment =
    passive "Civilization Encroachment" Icon.ExclamationUp
    [ Give Self CritUp [ (EX, 10) ] ]


connectionRoot =
    passive "Connection to the Root" Icon.DamageUp
    [ Give Self (CardUp Quick)  [ (A, 6), (C, 4) ]
    , Give Self (CardUp Arts)   [ (A, 6), (C, 4) ]
    , Give Self (CardUp Buster) [ (A, 6), (C, 4) ]
    ]


coreOfGoddess =
    passive "Core of the Goddess" Icon.Goddess
    [ Give Self DamageUp     [ (EX, 300), (A, 250), (B, 225), (C, 200) ]
    , Give Self DebuffResist [ (EX, 30),  (A, 25),  (B, 22.5),  (C, 20) ]
    ]


cosmoReactor =
    passive "Cosmo Reactor" Icon.StarHaloUp
    [ Give Self StarUp [ (A, 10), (B, 8) ] ]


divinity =
    passive "Divine" Icon.Sun
    [ Give Self DamageUp
        [ (APlusPlus, 230), (A, 200), (BPlus, 185), (B, 175), (BMinus, 170)
        , (C, 150), (D, 125), (E, 100), (EMinus, 95)
        ]
    ]


doubleClass =
    passive "Double Class" Icon.Missing
    []


entityOfTheOuterRealms =
    passive "Entity of the Outer Realms" Icon.Spotlight
    [ Give Self StarsPerTurn [ (EX, 2) ]
    , Give Self DebuffResist [ (EX, 12) ]
    ]


fairyContract =
    passive "Fairy Contract" Icon.HoodUp
    [ Give Self DebuffResist [ (A, 10) ]
    , Give Self DebuffUp [ (A, 10) ]
    ]


highServant =
    passive "High Servant" Icon.Missing
    []


homunculus =
    passive "Homunculus" Icon.ArtsUp
    [ Give Self (CardUp Arts) [ (CPlus, 6.5) ]
    , Give Self DebuffResist [ (CPlus, 6.5) ]
    ]


independentAction =
    passive "Independent Action" Icon.Dash
    [ Give Self CritUp [ (EX, 12), (APlus, 11), (A, 10), (B, 8), (C, 6) ] ]


independentManifestation =
    passive "Independent Manifestation" Icon.Dash
    [ Give Self CritUp       [ (C, 6), (E, 2) ]
    , Give Self MentalResist [ (C, 6), (E, 2) ]
    , Give Self DeathResist   [ (C, 6), (E, 2) ]
    ]


insanity =
    passive "Insanity" Icon.BusterUp
    [ Give Self (CardUp Buster) [ (B, 8) ] ]


itemConstruction =
    passive "Item Construction" Icon.Potion
    [ Give Self DebuffUp
        [ (EX, 12), (A, 10), (BPlus, 9), (B, 8), (C, 6), (D, 4) ]
    ]


itemConstructionFake =
    passive "Item Construction (Fake)" Icon.Potion
    [ Give Self DebuffUp [ (A, 10) ] ]


itemConstructionStrange =
    passive "Item Construction (Strange)" Icon.Potion
    [ Give Self HealingReceived [ (EX, 10) ] ]


logosEater =
    passive "Logos Eater" Icon.ShieldUp
    [ Give Self (Special DefenseUp <| VsTrait Humanoid) [ (C, 16) ] ]


madness =
    passive "Madness Enhancement" Icon.Teeth
    [ Give Self (CardUp Buster)
        [ (EX, 12), (APlus, 11), (A, 10), (B, 8), (C, 6), (DPlus, 5), (D, 4)
        , (EPlus, 3), (E, 2), (EMinus, 1)
        ]
    ]


magicResistance =
    passive "Magic Resistance" Icon.Diamonds
    [ Give Self DebuffResist
        [ (EX, 25), (APlus, 21), (A, 20), (BPlus, 18), (BPlus, 18), (B, 17.5)
        , (CPlus, 15.5), (C, 15), (DPlus, 13), (D, 12.5), (E, 10)
        ]
    ]


mixedBlood =
    passive "Mixed Blood" Icon.NobleTurn
    [ Give Self GaugePerTurn [ (EX, 5) ] ]


oblivionCorrection =
    passive "Oblivion Correction" Icon.Eclipse
    [ Give Self CritUp [ (A, 10), (B, 8), (C, 6) ] ]


negaSaver =
    passive "Nega Saver" Icon.DamageUp
    [ Give Self (Special AttackUp <| VsClass Ruler) [ (A, 50) ] ]


onTheBoundary =
    passive "On the Boundary" Icon.Fire
    [ Give Self DeathResist [ (A, 0) ]
    , Give Self CharmResist [ (A, 100) ]
    , Do (When "attacking" << To Enemy Death) [ (A, 5) ]
    ]


presenceConcealment =
    passive "Presence Concealment" Icon.Mask
    [ Give Self StarUp
        [ (APlus, 10.5), (A, 10), (B, 8), (CPlus, 6.5), (C, 6), (CMinus, 5.5)
        , (D, 4), (E, 2)
        ]
    ]


presenceConcealmentDark =
    passive "Presence Concealment (Dark)" Icon.Mask
    [ Give Self StarUp [(B, 8)]
    , Do (Debuff Self 0 DebuffVuln) [(B, 10)]
    ]


riding =
    passive "Riding" Icon.Horse
    [ Give Self (CardUp Quick)
        [ (EX, 12), (APlusPlus, 11.5), (APlus, 11), (A, 10), (B, 8), (CPlus, 7)
        , (C, 6), (E, 2)
        ]
    ]


ruffian =
    passive "Ruffian" Icon.ExclamationUp
    [ Give Self (CardUp Quick) [ (A, 5) ]
    , Give Self CritUp [ (A, 5) ]
    ]


selfRestoreMagic =
    passive "Self-Restoration (Magical Energy)" Icon.Niffin
    [ Give Self GaugePerTurn
        [ (APlus, 4), (A, 3.8), (B, 3.5), (C, 3.3), (D, 3), (D, 2), (E, 2) ]
    ]


surfing =
    passive "Surfing" Icon.ArtsUp
    [ Give Self (CardUp Arts) [ (A, 5) ]
    , Give Self StarUp [ (A, 5) ]
    ]


territoryCreation =
    passive "Territory Creation" Icon.MagicCircle
    [ Give Self (CardUp Arts)
        [ (EX, 12), (APlusPlus, 11.5), (APlus, 11), (A, 10), (B, 8), (CPlus, 7)
        , (C, 6), (D, 4)
        ]
    ]


unlimitedManaSupply =
    passive "Unlimited Mana Supply" Icon.NobleTurn
    [ Give Self GaugePerTurn [ (C, 3) ] ]


-----------
-- INTERNAL
-----------


type PassiveEffect
    = Give Target BuffEffect (List (Rank, Float))
    | Do (Amount -> SkillEffect) (List (Rank, Float))


lookup : a -> List (a, b) -> Maybe b
lookup a =
    List.find (Tuple.first >> (==) a)
        >> Maybe.map Tuple.second


passive : String -> Icon -> List PassiveEffect -> Rank -> Skill
passive name icon effects rank =
    let
        makeAmount x =
            if x < 0.001 then
                Full
            else
                Flat x

        skill a =
            case a of
                Give targ buff ranks ->
                    lookup rank ranks
                        |> Maybe.map makeAmount
                        >> Maybe.withDefault Placeholder
                        >> Grant targ 0 buff

                Do ef ranks ->
                    lookup rank ranks
                        |> Maybe.map makeAmount
                        >> Maybe.withDefault Placeholder
                        >> ef
    in
    { name   = name
    , rank   = rank
    , icon   = icon
    , cd     = 0
    , effect = List.map skill effects
    }
