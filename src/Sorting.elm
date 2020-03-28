module Sorting exposing
  ( SortBy(..), enumSortBy, OrdSortBy, ordSortBy
  , formatSort
  , addToSort
  )

import StandardLibrary     exposing (..)
import Printing            exposing (..)
import Persist.Preferences exposing (..)


type SortBy
    = Rarity
    | ID
    | ATK
    | HP
    | StarWeight
    | NPArts
    | NPDeck
    | StarQuick
    | StarDeck
    | NPDmg
    | NPDmgOver
    | NPSpec
    | NPSpecOver
    | NPRefund
    | NPRefundOver
    | NPInstant
    -- | NPTurn


enumSortBy : List SortBy
enumSortBy =
    [ Rarity
    , ID
    , ATK
    , HP
    , StarWeight
    , NPArts
    , NPDeck
    , StarQuick
    , StarDeck
    , NPDmg
    , NPDmgOver
    , NPSpec
    , NPSpecOver
    , NPRefund
    , NPRefundOver
    , NPInstant
    -- , NPTurn
    ]


type alias OrdSortBy = Int


ordSortBy : SortBy -> OrdSortBy
ordSortBy =
    enumToOrd enumSortBy


formatSort : SortBy -> Float -> String
formatSort a =
    case a of
        ATK          -> commas
        HP           -> commas
        NPDmg        -> commas
        NPDmgOver    -> commas
        NPSpec       -> commas
        NPSpecOver   -> commas
        NPArts       -> places 2 >> flip (++) "%"
        NPDeck       -> places 2 >> flip (++) "%"
        NPInstant    -> places 0 >> flip (++) "%"
        NPRefund     -> places 2 >> flip (++) "%"
        -- NPTurn       -> places 2 >> flip (++) "%"
        NPRefundOver -> places 2 >> flip (++) "%"
        StarQuick    -> places 2
        StarDeck     -> places 2
        _            -> places 0


addToSort : Preferences -> SortBy -> Bool
addToSort prefs sort =
    case sort of
        NPDeck    -> prefer prefs AddExtra
        StarDeck  -> prefer prefs AddExtra
        NPInstant -> prefer prefs ExcludeSelf
        -- NPTurn    -> prefer prefs ExcludeSelf
        _         -> prefer prefs AddSkills
