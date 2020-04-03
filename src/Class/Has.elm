module Class.Has exposing (..)

import Maybe.Extra as Maybe
import List.Extra as List

import Model.Attribute as Attribute exposing (Attribute)
import Model.Card as Card exposing (Card)
import Model.Class as Class exposing (Class)
import Model.Deck as Deck exposing (Deck)
import Model.Material as Material exposing (Material)
import Model.PhantasmType as PhantasmType exposing (PhantasmType)
import Model.Trait as Trait exposing (Trait)
import Model.Skill.Amount exposing (Amount(..))
import Model.Skill exposing (Skill)
import Model.Skill.BonusEffect as BonusEffect exposing (BonusEffect, BonusType(..))
import Model.Skill.BuffEffect as BuffEffect exposing (BuffEffect)
import Model.Skill.DebuffEffect as DebuffEffect exposing (DebuffEffect)
import Model.Skill.InstantEffect as InstantEffect exposing (InstantEffect(..))
import Model.Skill.SkillEffect as SkillEffect exposing (SkillEffect(..))
import Model.Skill.Target exposing (Target(..))
import Model.Servant as Servant exposing (Servant)


type alias Has a b =
    { show : b -> String
    , has  : Bool -> a -> List b
    }


material : Has Servant Material
material =
    Has Material.show << always <| \s ->
    Servant.getAscensions s ++ Servant.getReinforcements s
        |> List.concat
        >> List.map Tuple.first
        >> List.uniqueBy Material.show
        >> List.filter (not << Material.ignore)


alignment : Has Servant Trait
alignment =
    Has Trait.show << always <|
    .align

gender : Has Servant Trait
gender =
    Has Trait.show << always <|
    .gender
        >> List.singleton

trait : Has Servant Trait
trait =
    Has Trait.show << always <|
    .traits


phantasmType : Has Servant PhantasmType
phantasmType =
    Has PhantasmType.show << always <|
    .phantasm
        >> Servant.phantasmType
        >> List.singleton


class : Has Servant Class
class =
    Has Class.show << always <|
    .class
        >> List.singleton


attribute : Has Servant Attribute
attribute =
    Has Attribute.show << always <|
    .attr
        >> List.singleton


deck : Has Servant Deck
deck =
    Has Deck.show << always <|
    .deck
        >> List.singleton


card : Has Servant Card
card =
    Has Card.show << always <|
    .phantasm
        >> .card
        >> List.singleton


passive : Has Servant Skill
passive =
    Has .name << always <|
    .passives


servant : Servant -> List SkillEffect
servant s =
    s.phantasm.effect
    ++ s.phantasm.over
    ++ List.concatMap .effect s.skills


effect : (b -> String) -> (Bool -> SkillEffect -> Maybe b)
      -> (a -> List SkillEffect) -> Has a b
effect show match f =
    Has show <| \noSelf x ->
        f x
            |> List.map SkillEffect.simplify
            >> List.filter (not << SkillEffect.demerit)
            >> List.map (match noSelf)
            >> Maybe.values


buffEffect : (a -> List SkillEffect) -> Has a BuffEffect
buffEffect =
    effect (BuffEffect.show Someone Placeholder) <| \noSelf a ->
        case a of
            Grant t _ y _ ->
                if not noSelf || t /= Self then
                    Just y
                else
                    Nothing

            _ ->
                Nothing


debuffEffect : (a -> List SkillEffect) -> Has a DebuffEffect
debuffEffect =
    effect (DebuffEffect.show Someone Placeholder) <| \_ a ->
        case a of
            Debuff _ _ y _ ->
                Just y

            _ ->
                Nothing


instantEffect : (a -> List SkillEffect) -> Has a InstantEffect
instantEffect =
    effect (InstantEffect.show Someone Placeholder) <| \noSelf a ->
        case a of
            To _ ApplyAtRandom _ ->
                Nothing

            To _ BecomeHyde _ ->
                Nothing

            To _ GaugeSpend _ ->
                Nothing

            To t y _ ->
                if not noSelf || t /= Self then
                    Just y
                else
                    Nothing

            _ ->
                Nothing


bonusEffect : (a -> List SkillEffect) -> Has a BonusEffect
bonusEffect =
    effect (BonusEffect.show Units Placeholder) <| \_ a ->
        case a of
            Bonus y _ _ ->
                Just y

            _ ->
                Nothing
