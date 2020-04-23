module Model.Skill.SkillEffect exposing
  ( SkillEffect(..)
  , show
  , Ord, ord
  , demerit
  , simplify
  , mapAmount
  )

import Model.Skill.Amount as Amount exposing (Amount(..))
import Model.Skill.BonusEffect as BonusEffect exposing (BonusEffect(..), BonusType)
import Model.Skill.BuffCategory as BuffCategory
import Model.Skill.BuffEffect as BuffEffect exposing (BuffEffect(..))
import Model.Skill.DebuffEffect as DebuffEffect exposing (DebuffEffect(..))
import Model.Skill.InstantEffect as InstantEffect exposing (InstantEffect(..))
import Model.Skill.Target as Target exposing (Target)


{-| Int field is duration -}
type SkillEffect
    = Grant Target Int BuffEffect Amount
    | Debuff Target Int DebuffEffect Amount
    | To Target InstantEffect Amount
    | Bonus BonusEffect BonusType Amount
    | Chance Int SkillEffect
    | Chances Int Int SkillEffect
    | When String SkillEffect
    | Times Int SkillEffect
    | ToMax Amount SkillEffect
    | After Int SkillEffect


type alias Ord = String


ord : SkillEffect -> Ord
ord a =
    let
        pref =
            case a of
                To _ _ _ ->
                    "1"

                Debuff _ _ _ _ ->
                    "2"

                Grant _ _ f _ ->
                    f
                        |> BuffEffect.category
                        >> BuffCategory.show
                        >> String.cons '3'

                Bonus _ _ _ ->
                    "4"

                Chance _ _ ->
                    "5"

                Chances _ _ _ ->
                    "5"

                When _ _ ->
                    "6"

                Times _ _ ->
                    "7"

                ToMax _ _ ->
                    "8"

                After _ _ ->
                    "9"
    in
    pref ++ show a


show : SkillEffect -> String
show =
    let
        uncap s =
            case String.uncons s of
                Just (head, tail) ->
                    String.toLower (String.fromChar head) ++ tail

                Nothing ->
                    s

        addPeriod s =
            if String.endsWith ":" s then
                s
            else
                s ++ "."

        go a =
            case a of
                Grant t dur buff amt ->
                    BuffEffect.show t amt buff ++ turns dur

                Debuff t dur deb amt ->
                    DebuffEffect.show t amt deb ++ turns dur

                To t instant amt ->
                    InstantEffect.show t amt instant

                Bonus bonus perc amt ->
                    BonusEffect.show perc amt bonus

                Chance 0 ef ->
                    "Chance to " ++ uncap (go ef)

                Chance per ef ->
                    String.fromInt per ++ "% chance to " ++ uncap (go ef)

                Chances x y ef ->
                    String.fromInt x ++ "~" ++ String.fromInt y
                        ++ "% chance to " ++ uncap (go ef)

                When cond ef ->
                    if String.startsWith "attacking" cond then
                        go ef ++ " when " ++ cond
                    else
                        "If " ++ cond ++ ": " ++ uncap (go ef)

                Times 1 ef ->
                    go ef ++ " (1 time)"

                Times times ef ->
                    go ef ++ " (" ++ String.fromInt times ++ " times)"

                ToMax amt ef ->
                    go ef ++ " every turn (max " ++ Amount.show amt ++ ")"

                After 1 ef ->
                    "After 1 turn: " ++ go ef

                After amt ef ->
                    "After " ++ String.fromInt amt ++ " turns: " ++ go ef

        turns a =
            case a of
                0 -> ""
                1 -> " for 1 turn"
                _ -> " for " ++ String.fromInt a ++ " turns"
    in
    go
        >> addPeriod

mapAmount : (Float -> Float -> Amount) -> SkillEffect -> SkillEffect
mapAmount f eff =
  let
    f_ x =
        case x of
            Range a b -> f a b
            _         -> x

    go x =
        case x of
            Grant a b c d  -> Grant a b c <| f_ d
            Debuff a b c d -> Debuff a b c <| f_ d
            To a b c       -> To a b <| f_ c
            Bonus a b c    -> Bonus a b <| f_ c
            Chance a b     -> Chance a <| go b
            When a b       -> When a <| go b
            Times a b      -> Times a <| go b
            ToMax a b      -> ToMax (f_ a) <| go b
            After a b      -> After a <| go b
            Chances a b c  -> case f (toFloat a) (toFloat b) of
                Flat y      -> Chance (floor y) <| go c
                Range y z   -> Chances (floor y) (floor z) <| go c
                Placeholder -> go c
                Full        -> go c
    in
    go eff


simplify : SkillEffect -> SkillEffect
simplify a =
    case a of
        Chance _ ef    -> simplify ef
        Chances _ _ ef -> simplify ef
        When _ ef      -> simplify ef
        Times _ ef     -> simplify ef
        ToMax _ ef     -> simplify ef
        After _ ef     -> simplify ef
        _              -> a


demerit : SkillEffect -> Bool
demerit a =
    case a of
        Grant _ _ Taunt _      -> False
        Grant t _ _ _          -> not <| Target.allied t
        Debuff t _ _ _         -> Target.allied t
        To t Cure _            -> not <| Target.allied t
        To t Death _           -> Target.allied t
        To _ DemeritCharge _   -> True
        To _ DemeritDamage _   -> True
        To _ DemeritGauge _    -> True
        To _ DemeritHealth _   -> True
        To _ DemeritKill _     -> True
        To _ DemeritStars _    -> True
        To _ GaugeSpend _      -> True
        To _ HealthSpend _     -> True
        To t (Remove _) _      -> Target.allied t
        To t RemoveBuffs _     -> Target.allied t
        To t RemoveDebuffs _   -> not <| Target.allied t
        To t RemoveMental _    -> not <| Target.allied t
        To t Heal _            -> not <| Target.allied t
        To t OverChance _      -> not <| Target.allied t
        To t ReduceCooldowns _ -> not <| Target.allied t
        To _ _ _               -> False
        Bonus _ _ _            -> False
        Chance _ ef            -> demerit ef
        Chances _ _ ef         -> demerit ef
        When _ ef              -> demerit ef
        Times _ ef             -> demerit ef
        ToMax _ ef             -> demerit ef
        After _ ef             -> demerit ef
