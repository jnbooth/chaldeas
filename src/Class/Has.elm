module Class.Has exposing (..)

import Maybe.Extra as Maybe

import Database.Base  exposing (..)
import Database.Skill exposing (..)
import Database.Servant as Servant exposing (Deck, PhantasmType, Servant, getMaterials)

import Class.Show as Show


type alias Has a b =
    { show : b -> String
    , has  : Bool -> a -> List b
    }


material : Has Servant Material
material =
    Has Show.material << always <|
    getMaterials
        >> List.filter (not << ignoreMat)


alignment : Has Servant Trait
alignment =
    Has Show.trait << always <|
    .align

gender : Has Servant Trait
gender =
    Has Show.trait << always <|
    .gender
        >> List.singleton

trait : Has Servant Trait
trait =
    Has Show.trait << always <|
    .traits


phantasmType : Has Servant PhantasmType
phantasmType =
    Has Show.phantasmType << always <|
    .phantasm
        >> Servant.phantasmType
        >> List.singleton


class : Has Servant Class
class =
    Has Show.class << always <|
    .class
        >> List.singleton


attribute : Has Servant Attribute
attribute =
    Has Show.attribute << always <|
    .attr
        >> List.singleton


deck : Has Servant Deck
deck =
    Has Show.deck << always <|
    .deck
        >> List.singleton


card : Has Servant Card
card =
    Has Show.card << always <|
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
            |> List.map simplify
            >> List.filter (not << demerit)
            >> List.map (match noSelf)
            >> Maybe.values


buffEffect : (a -> List SkillEffect) -> Has a BuffEffect
buffEffect =
    effect (Show.buffEffect Someone Placeholder) <| \noSelf a ->
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
    effect (Show.debuffEffect Someone Placeholder) <| \_ a ->
        case a of
            Debuff _ _ y _ ->
                Just y

            _ ->
                Nothing


instantEffect : (a -> List SkillEffect) -> Has a InstantEffect
instantEffect =
    effect (Show.instantEffect Someone Placeholder) <| \noSelf a ->
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
    effect (Show.bonusEffect Units Placeholder) <| \_ a ->
        case a of
            Bonus y _ _ ->
                Just y

            _ ->
                Nothing
