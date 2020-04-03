module Database exposing
    ( genericGetAll
    , ranges
    )

{-| Packages together all information from the Database folder, including
a collection of all Servants in the [Database.Servant](./Servant/) folder. -}

import List.Extra as List

import Class.Has exposing (Has)
import Model.Attribute exposing (Attribute(..))
import Model.Skill.Amount exposing (Amount(..))
import Model.Skill.RangeInfo exposing (RangeInfo)
import Model.Skill.SkillEffect as SkillEffect exposing (SkillEffect(..))


{-| Retrieves all values of a `Has <a>` Enum
that at least one `<a>` in the database `has`. -}
genericGetAll : List a -> Has a b -> List b
genericGetAll xs {show, has} =
    xs
        |> List.concatMap (has False)
        >> List.sortBy show
        >> List.uniqueBy show


ranges : List SkillEffect -> List RangeInfo
ranges =
    let
        toInfo ef =
            List.map (info <| isPercent ef) <| acc ef

        isPercent =
            SkillEffect.show >> String.contains "%"

        info isPerc {from, to} =
            RangeInfo isPerc from to

        acc a =
            case a of
                Grant _ _ _ x  -> go x
                Debuff _ _ _ x -> go x
                To _ _ x       -> go x
                Bonus _ _ x    -> go x
                Chance _ ef    -> acc ef
                When _ ef      -> acc ef
                Times _ ef     -> acc ef
                ToMax _ ef     -> acc ef
                After _ ef     -> acc ef

                Chances x y ef ->
                    {from = Basics.toFloat x, to = Basics.toFloat y} :: acc ef

        go a =
            case a of
                Range x y -> [{from = x, to = y}]
                _         -> []
    in
    List.concatMap toInfo

