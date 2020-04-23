module Site.Algebra exposing
  ( Component
  , SiteMsg(..)
  , SiteModel
  , FilterList
  , init
  )

import Browser.Navigation as Navigation
import Date exposing (Date)
import Html exposing (Html)

import Database.Calculator as C exposing (Sources)
import Model.Skill.SkillEffect exposing (SkillEffect(..))
import Persist.Preference exposing (Preference)
import Persist.Preferences exposing (Preferences)
import Persist.Flags exposing (Flags)
import Site.FilterTab exposing (FilterTab)
import Site.Section exposing (Section)
import Site.Filter exposing (Filter)
import Site.SortBy exposing (SortBy(..))


type alias Component model msg =
    { init   : Flags -> Navigation.Key -> model
    , view   : Preferences -> model -> Html msg
    , update : Preferences -> msg -> model -> (model, Cmd msg)
    }


type SiteMsg filt focus
    = ToSection (Maybe Section)
    | Focus (Maybe focus)
    | ClearAll
    | Check FilterTab Bool
    | FilterBy (List (Filter filt))
    | Toggle (Filter filt)
    | MatchAny Bool
    | SetSort SortBy
    | EffectSort SkillEffect
    | EffectDialog Bool
    | SetSources Sources
    | SetPref Preference Bool
    | Ascend focus Int
    | OnMine Bool focus
    | OnTeam Int Int
    | Export
    | Import
    | Entry String
    | ReceiveCompress String
    | ReceiveDecompress String
    | DoNothing


type alias SiteModel filt focus extra =
    { today      : Date
    , navKey     : Navigation.Key
    , root       : String
    , allFilters : FilterList filt
    , section    : Maybe Section
    , filters    : List (Filter filt)
    , exclude    : List (Filter filt)
    , matchAny   : Bool
    , focus      : Maybe focus
    , sortBy     : SortBy
    , dialog     : Bool
    , sources    : Sources
    , sorted     : List (String, focus)
    , listing    : List (String, focus)
    , extra      : extra
    }


init : (Date -> FilterList filt) -> Flags -> Navigation.Key -> extra
    -> SiteModel filt focus extra
init getFilters flags navKey extra =
    { today      = flags.today
    , navKey     = navKey
    , root       = ""
    , allFilters = getFilters flags.today
    , section    = Nothing
    , filters    = []
    , exclude    = []
    , matchAny   = True
    , focus      = Nothing
    , sortBy     = Rarity
    , sources    = C.selfish + C.special + C.skills + C.np
    , dialog     = False
    , sorted     = []
    , listing    = []
    , extra      = extra
    }


type alias FilterList a =
    List { tab : FilterTab, filters : List (Filter a) }
