port module Test exposing (main)

import Browser
import Set

import Maybe.Extra as Maybe
import Platform exposing (worker)

import StandardLibrary       exposing (..)
import Database              exposing (..)
import Database.CraftEssence exposing (..)
import Database.Servant      exposing (..)
import Database.Skill        exposing (..)

import Site.CraftEssence.Filters as CraftEssences
import Site.Servant.Filters as Servants
import Class.Show as Show

invalidBond : CraftEssence -> Bool
invalidBond ce =
    case ce.bond of
        Just s  ->
            servants
                |> List.map .name
                >> List.member s
                >> not

        Nothing ->
            False


missingBond : Servant -> Bool
missingBond s =
    if String.startsWith "Mash Kyrielight" s.name then
        False
    else
        craftEssences
            |> List.filterMap .bond
            >> List.member s.name
            >> not


idConflicts : List {a | id: Int} -> List String
idConflicts =
    let
        go {id} (acc, xs) =
            if Set.member id acc then
                (acc, id :: xs)
            else
                (Set.insert id acc, xs)
    in
    List.foldr go (Set.empty, [])
        >> Tuple.second
        >> List.map String.fromInt


invalidRarities : List {a | rarity: Int, name: String} -> List String
invalidRarities =
    let
        invalid {rarity} =
            rarity < 0 || rarity > 5
    in
        List.filter invalid
            >> List.map .name


isPlaceholder : SkillEffect -> Bool
isPlaceholder a =
    case simplify a of
        Grant _ _ _ Placeholder -> True
        Debuff _ _ _ Placeholder -> True
        To _ _ Placeholder -> True
        Bonus _ _ Placeholder -> True
        _ -> False


placeholders : List String
placeholders =
    servants
        |> List.concatMap .passives
        >> List.filter (.effect >> List.any isPlaceholder)
        >> List.map (\x -> x.name ++ Show.rank x.rank)


errors : List String
errors =
  let
    missingBonds =
        servants
            |> List.filter missingBond
            >> List.map .name

    invalidBonds =
        craftEssences
            |> List.filter invalidBond
            >> List.map .name
  in
    suite "Missing CE Bond" missingBonds
        ++ suite "Invalid CE Bond" invalidBonds
        ++ suite "CE ID Conflicts" (idConflicts craftEssences)
        ++ suite "Servant ID Conflicts" (idConflicts servants)
        ++ suite "CE Invalid Rarities" (invalidRarities craftEssences)
        ++ suite "Servant Invalid Rarities" (invalidRarities servants)
        ++ suite "Missing Passives" placeholders
        ++ CraftEssences.errors
        ++ Servants.errors


port print : String -> Cmd msg


output : ()
output = case errors of
  [] -> ()
  _  -> Debug.todo <| String.join "\n" errors


main : Program () () Never
main = worker
    { init = \_ -> pure output
    , update = \_ _ -> pure ()
    , subscriptions = \_ -> Sub.none
    }
