module MaybeRank exposing (MaybeRank(..), show)

import Model.Servant exposing (Servant)
import Model.Skill.Rank as Rank exposing (Rank(..))

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
            "Rank" ++ Rank.show x

        Upgrade Unknown ->
            "NP"

        Upgrade x ->
            "Rank '" ++ String.trim (Rank.show x) ++ "'"

        Unique s Unknown ->
            s.name

        Unique s x ->
            case s.name of
                "Mash Kyrielight" ->
                    "Lord Camelot"

                "Frankenstein" ->
                    "D~" ++ Rank.show x

                "EMIYA" ->
                    "E~" ++ Rank.show x

                "EMIYA (Alter)" ->
                    "E~" ++ Rank.show x

                "Henry Jekyll & Hyde" ->
                    "Rank" ++ Rank.show x ++ " (Hyde)"

                _ ->
                    s.name
