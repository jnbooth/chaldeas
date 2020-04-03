module Model.Class exposing
  ( Class(..)
  , enum, enumNpc
  , show
  )


{-| Determines the "class attack bonus" and "triangle modifier"
in `Database.Calculator`.-}
-- Note: MoonCancer and AlterEgo are not represented as they are JP-only.
type Class
    = Shielder
    | Saber | Archer | Lancer | Rider | Caster | Assassin
    | Berserker | Ruler | Avenger | AlterEgo | MoonCancer | Foreigner
    | Beast1 | Beast2 | Beast3L | Beast3R


enum : List Class
enum =
    [ Shielder
    , Saber , Archer , Lancer , Rider , Caster , Assassin
    , Berserker , Ruler , Avenger , AlterEgo , MoonCancer , Foreigner
    ]


enumNpc : List Class
enumNpc =
    enum ++
    [ Beast1 , Beast2 , Beast3L, Beast3R ]


show : Class -> String
show a =
    case a of
        Shielder   -> "Shielder"
        Saber      -> "Saber"
        Archer     -> "Archer"
        Lancer     -> "Lancer"
        Rider      -> "Rider"
        Caster     -> "Caster"
        Assassin   -> "Assassin"
        Berserker  -> "Berserker"
        Ruler      -> "Ruler"
        Avenger    -> "Avenger"
        AlterEgo   -> "Alter-Ego"
        MoonCancer -> "Moon Cancer"
        Foreigner  -> "Foreigner"
        Beast1     -> "Beast I"
        Beast2     -> "Beast II"
        Beast3L    -> "Beast III/L"
        Beast3R    -> "Beast III/R"

