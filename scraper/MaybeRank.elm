module MaybeRank exposing (MaybeRank(..), show)

import Database.Servant exposing (..)
import Database.Skill   exposing (..)
import Class.Show as Show

type MaybeRank
    = Unranked
    | Pure     Rank
    | Upgrade  Rank
    | Unique   Servant Rank

show : MaybeRank -> String
show a =
    case a of
        Unranked ->
            "--"
        Pure x ->
            "Rank" ++ Show.rank x

        Upgrade Unknown ->
            "NP"

        Upgrade x ->
            "Rank '" ++ String.trim (Show.rank x) ++ "'"

        Unique s Unknown ->
            s.name

        Unique s x ->
            case s.name of
                "Mash Kyrielight" ->
                    "Lord Camelot"

                "Frankenstein" ->
                    "D~" ++ Show.rank x

                "EMIYA" ->
                    "E~" ++ Show.rank x

                "EMIYA (Alter)" ->
                    "E~" ++ Show.rank x

                "Henry Jekyll & Hyde" ->
                    "Rank" ++ Show.rank x ++ " (Hyde)"

                _ ->
                    s.name
