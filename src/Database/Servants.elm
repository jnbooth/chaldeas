module Database.Servants exposing
  ( db
  , getAll
  )

{-| Packages together all information from the Database folder, including
a collection of all Servants in the [Database.Servant](./Servant/) folder. -}

import List.Extra as List

import Class.Has exposing (Has)
import Model.Attribute exposing (Attribute(..))
import Model.Trait as Trait exposing (Trait(..))
import Model.Servant exposing (Servant)
import Model.Skill.Amount exposing (Amount(..))
import Model.Skill.SkillEffect exposing (SkillEffect(..))

import Database
import Database.Servant.Archer exposing (archers)
import Database.Servant.Assassin exposing (assassins)
import Database.Servant.Berserker exposing (berserkers)
import Database.Servant.Caster exposing (casters)
import Database.Servant.Extra exposing (extras)
import Database.Servant.Lancer exposing (lancers)
import Database.Servant.Rider exposing (riders)
import Database.Servant.Saber exposing (sabers)


{-| All Servants available in EN. Collects the database in
[Database/Servant](./Servant/). -}
-- Note: Names _must_ be true to their EN localization.
-- GrandOrder.Wiki is only trustworthy for Servants that have been in the game
-- for a while, especially for skills.
-- Servants introduced during events and the like should be checked against
-- the official announcement.
db : List Servant
db =
    let
        addEarthOrSky s =
            case s.attr of
                Earth -> { s | traits = EarthOrSky :: s.traits }
                Sky   -> { s | traits = EarthOrSky :: s.traits }
                _     -> s

        addUniversal s =
            { s
            | traits   = List.sortBy Trait.show <| Trait.Servant :: s.traits
            , passives = List.sortBy .name s.passives
            }
    in
    [ archers
    , assassins
    , berserkers
    , casters
    , extras
    , lancers
    , riders
    , sabers
    ]
        |> List.concat
        >> List.map (addEarthOrSky >> addUniversal)


getAll : Has Servant a -> List a
getAll =
    Database.genericGetAll db
