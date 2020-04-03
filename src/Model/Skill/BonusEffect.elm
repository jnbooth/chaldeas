module Model.Skill.BonusEffect exposing
  ( BonusEffect(..)
  , show
  , BonusType(..)
  )

import Model.Skill.Amount as Amount exposing (Amount)


type BonusEffect
    = Bond
    | EXP
    | FriendPoints
    | MysticCode
    | QPDrop
    | QPQuest


type BonusType
    = Units
    | Percent


show : BonusType -> Amount -> BonusEffect -> String
show isPerc amt a =
    let
        n =
            case isPerc of
                Percent -> Amount.show amt ++ "%"
                Units   -> Amount.show amt

        gain x =
            "Increase " ++ x ++ " gained by " ++ n
    in
    case a of
        Bond         -> gain "Bond Points"
        EXP          -> gain "Master EXP"
        FriendPoints -> "Friend Points obtained from support becomes +" ++ n
        MysticCode   -> gain "Mystic Code EXP"
        QPDrop       -> "Increase QP from completing quests by " ++ n
        QPQuest      -> "Increase QP from enemy drops by " ++ n
