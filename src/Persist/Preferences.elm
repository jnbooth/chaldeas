module Persist.Preferences exposing
  ( Preferences, empty
  , prefers
  , set
  , unfold
  )

import Set exposing (Set)

import StandardLibrary exposing (flip)
import Persist.Preference as Preference exposing (Preference)


type alias Preferences =
    Set String


empty : Preferences
empty =
    let
        acc pref = set pref <| Preference.default pref
    in
    List.foldr acc Set.empty Preference.enum


prefers : Preferences -> Preference -> Bool
prefers prefs =
    Preference.show
        >> flip Set.member prefs


set : Preference -> Bool -> Preferences -> Preferences
set pref a =
    Preference.show pref |>
        if a then
            Set.insert
        else
            Set.remove


unfold : Preferences -> List (Preference, Bool)
unfold prefs =
    let
        un x =
            (x, prefers prefs x)
    in
    List.map un Preference.enum
