module Model.Skill exposing (Skill)

import Model.Icon exposing (Icon)
import Model.Skill.Rank exposing (Rank)
import Model.Skill.SkillEffect exposing (SkillEffect)


type alias Skill =
    { name   : String
    , rank   : Rank
    , icon   : Icon
    , cd     : Int
    , effect : List SkillEffect
    }
