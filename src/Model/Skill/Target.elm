module Model.Skill.Target exposing
  ( Target(..)
  , allied, isSpecial
  , possessiveAndSubject
  )


import Model.Trait as Trait exposing (Trait)


type Target
    = Someone
    | Self | Ally | Party | Enemy | Enemies | Others
    | AlliesType Trait | EnemyType Trait | EnemiesType Trait
    | Killer | Target


allied : Target -> Bool
allied a =
    case a of
        Self         -> True
        Ally         -> True
        Party        -> True
        Others       -> True
        AlliesType _ -> True
        _            -> False


isSpecial : Target -> Bool
isSpecial a =
    case a of
        AlliesType _  -> True
        EnemyType _   -> True
        EnemiesType _ -> True
        _             -> False


possessiveAndSubject : Target -> { p : String, s : String }
possessiveAndSubject a =
    case a of
        Someone ->
            { p = ""
            , s = ""
            }

        Self ->
            { p = " own"
            , s = " self"
            }

        Ally ->
            { p = " one ally's"
            , s = " one ally"
            }

        Party ->
            { p = " party's"
            , s = " party"
            }

        Enemy ->
            { p = " one enemy's"
            , s = " one enemy"
            }

        Enemies ->
            { p = " all enemy"
            , s = " all enemies"
            }

        Others ->
            { p = " allies' (excluding self)"
            , s = " allies (excluding self)"
            }

        AlliesType t ->
            { p = " [" ++ Trait.show t ++ "] allies'"
            , s = " [" ++ Trait.show t ++ "] allies"
            }

        EnemyType t ->
            { p = " one [" ++ Trait.show t ++ "] enemy's"
            , s = " one [" ++ Trait.show t ++ "] enemy"
            }

        EnemiesType t ->
            { p = " all [" ++ Trait.show t ++ "] enemy"
            , s = " all [" ++ Trait.show t ++ "] enemies"
            }
        Killer ->
            { p = " killer's"
            , s = " killer"
            }

        Target ->
            { p = " target's"
            , s = " target"
            }
