module Persist.Preference exposing
  ( Preference(..)
  , enum
  , show
  , Ord, ord
  , default
  )

import StandardLibrary exposing (enumToOrd)


type Preference
    = Artorify
    | HideSpoilers
    | NightMode
    | Thumbnails
    | ShowTables
    | ExcludeSelf
    | MaxAscension
    | AddSkills
    | AddExtra
    | HideClasses


enum : List Preference
enum =
    [ Artorify
    , HideSpoilers
    , NightMode
    , Thumbnails
    , ShowTables
    , ExcludeSelf
    , MaxAscension
    , AddSkills
    , AddExtra
    , HideClasses
    ]


type alias Ord =
    Int


ord : Preference -> Ord
ord =
    enumToOrd enum


default : Preference -> Bool
default a =
    case a of
        AddSkills    -> True
        Artorify     -> True
        HideSpoilers -> True
        ShowTables   -> True
        _            -> False



show : Preference -> String
show a =
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
