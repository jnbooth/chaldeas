module Test exposing (main)

import Set

import Platform exposing (worker)

import StandardLibrary exposing (pure, suite)
import Database.CraftEssences as CraftEssences
import Database.Servants as Servants
import Model.CraftEssence exposing (CraftEssence)
import Model.Servant exposing (Servant)
import Model.Skill.Amount exposing (Amount(..))
import Model.Skill.SkillEffect as SkillEffect exposing (SkillEffect(..))
import Model.Skill.Rank as Rank exposing (Rank(..))

import Site.CraftEssence.Filters as CraftEssencesFilters
import Site.Servant.Filters as ServantsFilters

invalidBond : CraftEssence -> Bool
invalidBond ce =
    case ce.bond of
        Just s  ->
            Servants.db
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
        CraftEssences.db
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
    case SkillEffect.simplify a of
        Grant _ _ _ Placeholder -> True
        Debuff _ _ _ Placeholder -> True
        To _ _ Placeholder -> True
        Bonus _ _ Placeholder -> True
        _ -> False


placeholders : List String
placeholders =
    Servants.db
        |> List.concatMap .passives
        >> List.filter (.effect >> List.any isPlaceholder)
        >> List.map (\x -> x.name ++ Rank.show x.rank)


errors : List String
errors =
  let
    missingBonds =
        Servants.db
            |> List.filter missingBond
            >> List.map .name

    invalidBonds =
        CraftEssences.db
            |> List.filter invalidBond
            >> List.map .name
  in
    suite "Missing CE Bond" missingBonds
        ++ suite "Invalid CE Bond" invalidBonds
        ++ suite "CE ID Conflicts" (idConflicts CraftEssences.db)
        ++ suite "Servant ID Conflicts" (idConflicts Servants.db)
        ++ suite "CE Invalid Rarities" (invalidRarities CraftEssences.db)
        ++ suite "Servant Invalid Rarities" (invalidRarities Servants.db)
        ++ suite "Missing Passives" placeholders
        ++ CraftEssencesFilters.errors
        ++ ServantsFilters.errors


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
