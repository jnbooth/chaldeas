module Site.FilterTab exposing
  ( FilterTab(..)
  , enum
  , show
  , Ord, ord
  , exclusive
  )

import List.Extra as List

import StandardLibrary exposing (enumToOrd)
import Model.Skill.BuffCategory as BuffCategory exposing (BuffCategory)


{-| The right sidebar is broken up into categories of `Filter`s. -}
type FilterTab
    = EventBonus
    | Availability
    | Gender
    | Alignment
    | PassiveSkill
    | Material
    | Bonus | Action | Debuff
    | Buff BuffCategory
    | Damage
    -- Exclusive
    | Source
    | Phantasm | Card
    | Class
    | Deck
    | Attribute
    | Trait
    | Rarity


enum : List FilterTab
enum =
    [ EventBonus
    , Availability
    , Alignment
    , Trait
    , PassiveSkill
    , Material
    , Bonus,  Action,  Debuff
    ] ++ List.map Buff BuffCategory.enum ++
    [ Damage
    -- Exclusive
    , Source
    , Phantasm,  Card
    , Class
    , Deck
    , Attribute
    , Gender
    , Rarity
    ]


type alias Ord =
    Int


ord : FilterTab -> Ord
ord =
    enumToOrd enum


exclusives : List FilterTab
exclusives =
    List.dropWhile ((/=) Source) enum


{-| Exclusive `FilterTab`s are shown on the left sidebar instead of right
and have select all/none buttons. -}
exclusive : FilterTab -> Bool
exclusive x =
    List.member x exclusives


show : FilterTab -> String
show a =
    case a of
        Action       -> "Action"
        Alignment    -> "Alignment"
        Attribute    -> "Attribute"
        Availability -> "Availability"
        Bonus        -> "Bonus"
        Buff c       -> "Buff (" ++ BuffCategory.show c ++ ")"
        Card         -> "NP Card"
        Class        -> "Class"
        Damage       -> "Damage"
        Debuff       -> "Debuff"
        Deck         -> "Deck"
        EventBonus   -> "Event Bonus"
        Gender       -> "Gender"
        Material     -> "Material"
        PassiveSkill -> "Passive Skill"
        Phantasm     -> "NP Type"
        Rarity       -> "Rarity"
        Source       -> "Source"
        Trait        -> "Trait"

