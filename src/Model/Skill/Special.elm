module Model.Skill.Special exposing
  ( Special(..)
  , show
  , Ord, ord
  , enum
  )
{-| There are three types of skill effects in the game:
buffs, or positive status effects with a duration;
debuffs, or negative status effects with a duration;
and instant actions like gaining stars or reducing an enemy's NP gauge.

In CHALDEAS, Buffs are represented by `BuffEffect`s,
debuffs by `DebuffEffect`s, and instant actions by `InstantEffect`s.
This system is also used by passive skills, Noble Phantasm effects,
and Craft Essences.

For Craft Essences only, there are also `BonusEffect`s that increase gains
of Quartz Points, Bond, and so on. -}

import Model.Attribute as Attribute exposing (Attribute)
import Model.Class as Class exposing (Class)
import Model.Trait as Trait exposing (Trait)


type Special
    = VsTrait Trait
    | VsClass Class
    | VsAttribute Attribute


type alias Ord = String


ord : Special -> Ord
ord = show


show : Special -> String
show a =
    (\s -> "[" ++ s ++ "]") <|
    case a of
        VsAttribute x -> Attribute.show x
        VsClass x     -> Class.show x
        VsTrait x     -> Trait.show x


enum : List Special
enum =
    List.map VsTrait Trait.enum
    ++ List.map VsClass Class.enumNpc
    ++ List.map VsAttribute Attribute.enum

