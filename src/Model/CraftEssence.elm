module Model.CraftEssence exposing (CraftEssence)

import Model.Skill.SkillEffect exposing (SkillEffect)
import Model.Icon exposing (Icon)
import Model.Stat exposing (Stat)


type alias CraftEssence =
    { name  : String
    , id  : Int
    , rarity  : Int
    , icon  : Icon
    , stats  : { base : Stat, max : Stat }
    , effect : List SkillEffect
    , bond : Maybe String
    , limited : Bool
    }
