module Model.Skill.BuffCategory exposing
  ( BuffCategory(..)
  , enum
  , show
  )

type BuffCategory
    = Offensive
    | Defensive
    | Support
    | Utility
    | Specialist


enum : List BuffCategory
enum =
    [ Offensive
    , Defensive
    , Support
    , Utility
    , Specialist
    ]


show : BuffCategory -> String
show a =
    case a of
        Offensive  -> "Offensive"
        Defensive  -> "Defensive"
        Support    -> "Support"
        Utility    -> "Utility"
        Specialist -> "Specialist"

