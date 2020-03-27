module Persist.Preferences exposing
  ( Preference(..), enumPreference, ordPreference
  , Preferences, noPreferences
  , prefer
  , setPreference
  , unfoldPreferences
  )

import Set exposing (Set)

import StandardLibrary exposing (..)


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


enumPreference : List Preference
enumPreference =
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


type alias OrdPreference = Int


ordPreference : Preference -> OrdPreference
ordPreference =
    enumToOrd enumPreference


prefDefault : Preference -> Bool
prefDefault a =
    case a of
        AddSkills    -> True
        Artorify     -> True
        HideSpoilers -> True
        ShowTables   -> True
        _            -> False


type alias Preferences =
    Set OrdPreference


noPreferences : Preferences
noPreferences =
    let
        acc pref = setPreference pref <| prefDefault pref
    in
    List.foldr acc Set.empty enumPreference


prefer : Preferences -> Preference -> Bool
prefer prefs =
    ordPreference
        >> flip Set.member prefs


setPreference : Preference -> Bool -> Preferences -> Preferences
setPreference pref a =
    ordPreference pref |>
        if a then
            Set.insert
        else
            Set.remove


unfoldPreferences : Preferences -> List (Preference, Bool)
unfoldPreferences prefs =
    let
        unfold x =
            (x, prefer prefs x)
    in
    List.map unfold enumPreference
