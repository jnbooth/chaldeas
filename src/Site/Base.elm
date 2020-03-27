module Site.Base exposing
  ( Section(..), enumSection
  , FilterTab(..), enumFilterTab, ordFilterTab
  , exclusive
  )

import StandardLibrary exposing (..)
import Database.Skill  exposing (..)


{-| The site's layout is broken up into `Section`s.
On mobile, instead of showing `Section`s in sidebars,
each is a separate page. -}
type Section
    =  SectionBrowse
    | SectionSettings
    | SectionSortBy
    | SectionInclude
    | SectionFilter


enumSection : List Section
enumSection =
    [ SectionBrowse
    , SectionSettings
    , SectionSortBy
    , SectionInclude
    , SectionFilter
    ]


{-| The right sidebar is broken up into categories of `Filter`s. -}
type FilterTab
    = FilterEventBonus
    | FilterAvailability
    | FilterGender
    | FilterAlignment
    | FilterPassiveSkill
    | FilterMaterial
    | FilterBonus | FilterAction | FilterDebuff
    | FilterBuff BuffCategory
    | FilterDamage
    -- Exclusive
    | FilterSource
    | FilterPhantasm | FilterCard
    | FilterClass
    | FilterDeck
    | FilterAttribute
    | FilterTrait
    | FilterRarity


enumFilterTab : List FilterTab
enumFilterTab =
    [ FilterEventBonus
    , FilterAvailability
    , FilterAlignment
    , FilterTrait
    , FilterPassiveSkill
    , FilterMaterial
    , FilterBonus,  FilterAction,  FilterDebuff
    ] ++ List.map FilterBuff enumBuffCategory ++
    [ FilterDamage
    -- Exclusive
    , FilterSource
    , FilterPhantasm,  FilterCard
    , FilterClass
    , FilterDeck
    , FilterAttribute
    , FilterGender
    , FilterRarity
    ]


type alias OrdFilterTab = Int


ordFilterTab : FilterTab -> OrdFilterTab
ordFilterTab =
    enumToOrd enumFilterTab


{-| Exclusive `FilterTab`s are shown on the left sidebar instead of right
and have select all/none buttons. -}
exclusive : FilterTab -> Bool
exclusive x =
    ordFilterTab FilterSource <= ordFilterTab x
