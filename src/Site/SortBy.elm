module Site.SortBy exposing
  ( SortBy(..)
  , Ord, ord
  , enum
  , show
  , format
  , addToSort
  )

import StandardLibrary exposing (flip)
import Print
import Persist.Preferences exposing (Preferences, prefers)
import Persist.Preference exposing (Preference(..))


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


enum : List SortBy
enum =
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


show : SortBy -> String
show a =
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
        NPInstant    -> "NP Gauge increase"
        -- NPTurn       -> "Average Gauge per turn"
        Rarity       -> "Rarity"
        StarDeck     -> "Stars per full deck"
        StarQuick    -> "Stars per Quick card"
        StarWeight   -> "Star Weight"


type alias Ord =
    String


ord : SortBy -> Ord
ord =
    show


format : SortBy -> Float -> String
format a =
    case a of
        ATK          -> Print.commas
        HP           -> Print.commas
        NPDmg        -> Print.commas
        NPDmgOver    -> Print.commas
        NPSpec       -> Print.commas
        NPSpecOver   -> Print.commas
        NPArts       -> Print.places 2 >> flip (++) "%"
        NPDeck       -> Print.places 2 >> flip (++) "%"
        NPInstant    -> Print.places 0 >> flip (++) "%"
        NPRefund     -> Print.places 2 >> flip (++) "%"
        -- NPTurn       -> Print.places 2 >> flip (++) "%"
        NPRefundOver -> Print.places 2 >> flip (++) "%"
        StarQuick    -> Print.places 2
        StarDeck     -> Print.places 2
        _            -> Print.places 0


addToSort : Preferences -> SortBy -> Bool
addToSort prefs sort =
    case sort of
        NPDeck    -> prefers prefs AddExtra
        StarDeck  -> prefers prefs AddExtra
        NPInstant -> prefers prefs ExcludeSelf
        -- NPTurn    -> prefers prefs ExcludeSelf
        _         -> prefers prefs AddSkills
