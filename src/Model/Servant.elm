module Model.Servant exposing
  ( Servant
  , show, eq
  , Ord, ord
  , Ratings
  , NoblePhantasm
  , Hits, hits
  , Gen
  , phantasmType
  , Ascension(..)
  , Reinforcement(..)
  , getAscensions, getReinforcements
  )

{-| This module defines the data structure of Servants. -}
-- It does not contain actual database information from the game; that can
-- be found in the [Database.Servant](./Servant) _folder_, which has a
-- separate file for each Class.

import List.Extra as List

import Model.Attribute exposing (Attribute)
import Model.Card exposing (Card(..))
import Model.Class as Class exposing (Class)
import Model.Deck exposing (Deck)
import Model.Material exposing (Material(..))
import Model.PhantasmType exposing (PhantasmType(..))
import Model.Stat exposing (Stat)
import Model.Trait exposing (Trait)
import Model.Skill exposing (Skill)
import Model.Skill.Rank exposing (Rank)
import Model.Skill.SkillEffect exposing (SkillEffect(..))
import Model.Skill.InstantEffect exposing (InstantEffect(..))
import Model.Skill.Target exposing (Target(..))


type alias Servant =
    { name     : String
    , spoiler  : Maybe String
    , id       : Int
    , rarity   : Int
    , class    : Class
    , stats    : { base : Stat, max : Stat, grail : Stat }
    , gen      : Gen
    , death    : Float
    , curve    : Int
    , attr     : Attribute
    , align    : List Trait
    , gender   : Trait
    , traits   : List Trait
    , deck     : Deck
    , hits     : Hits
    , skills   : List Skill
    , passives : List Skill
    , phantasm : NoblePhantasm
    , limited  : Bool
    , free     : Bool
    , ascendUp : Ascension
    , skillUp  : Reinforcement
    }


eq : Servant -> Servant -> Bool
eq x y =
    x.id == y.id


show : Bool -> Servant -> String
show hide x =
    if hide then
        case x.spoiler of
            Just y  -> Class.show x.class ++ " of " ++ y
            Nothing -> x.name
    else
        x.name


type alias Ord =
    Int


ord : Servant -> Int
ord =
    .id


type alias Ratings =
    { damage     : Int
    , np         : Int
    , critical   : Int
    , utility    : Int
    , support    : Int
    , durability : Int
    }


type alias NoblePhantasm =
    { name   : String
    , rank   : Rank
    , card   : Card
    , kind   : String
    , hits   : Int
    , effect : List SkillEffect
    , over   : List SkillEffect
    , first  : Bool
    }


type alias Hits =
    { arts   : Int
    , buster : Int
    , quick  : Int
    , ex     : Int
    }


type alias Gen =
    { starWeight : Int
    , starRate   : Float
    , npAtk      : Float
    , npDef      : Int
    }


type Ascension
    = Welfare String
    | Clear String String String String
    | Ascension
      (List (Material, Int)) -- 1
      (List (Material, Int)) -- 2
      (List (Material, Int)) -- 3
      (List (Material, Int)) -- 4


type Reinforcement
    = Reinforcement
      (List (Material, Int)) -- 1
      (List (Material, Int)) -- 2
      (List (Material, Int)) -- 3
      (List (Material, Int)) -- 4
      (List (Material, Int)) -- 5
      (List (Material, Int)) -- 6
      (List (Material, Int)) -- 7
      (List (Material, Int)) -- 8
      -- 9 is always [ (CrystallizedLore: 1) ]


hits : Card -> Servant -> Int
hits card s =
    case card of
        Arts   -> s.hits.arts
        Quick  -> s.hits.quick
        Buster -> s.hits.buster
        Extra  -> s.hits.ex


getAscensions : Servant -> List (List (Material, Int))
getAscensions {ascendUp} =
    case ascendUp of
        Ascension a b c d ->
            [a, b, c, d]

        _ ->
            []


getReinforcements : Servant -> List (List (Material, Int))
getReinforcements {skillUp} =
    let
        (Reinforcement a b c d e f g h) = skillUp
    in
    [a, b, c, d, e, f, g, h, [ (CrystallizedLore, 1) ]]


phantasmType : NoblePhantasm -> PhantasmType
phantasmType np =
    let
        match target a =
            case a of
                To x Damage _        -> x == target
                To x DamageThruDef _ -> x == target
                To x Avenge _        -> x == target
                _                    -> False

        effects =
            np.effect ++ np.over
    in
    if List.any (match Enemy) effects then
        SingleTarget
    else if List.any (match Enemies) effects then
        MultiTarget
    else
        Support
