module Test exposing (..)

import Maybe.Extra as Maybe

import StandardLibrary exposing (flip)


type Outcome
    = Success
    | Failure String


type Test
    = Test String Outcome
    | Suite String (List Test)


score : List Test -> (Int, Int)
score =
  let
    tupleSum (x1, x2) (y1, y2) = (x1 + y1, x2 + y2)
    scoreOne x = case x of
      Test _ Success     -> (1, 1)
      Test _ (Failure _) -> (0, 1)
      Suite _ xs         -> score xs
  in
    List.foldr tupleSum (0, 0) << List.map scoreOne


discardSuccesses : List Test -> List Test
discardSuccesses xs =
    Maybe.values <<
    flip List.map xs <| \x -> case x of
      Test _ (Failure _) -> Just x
      Test _ Success     -> Nothing
      Suite name tests   ->
        case discardSuccesses tests of
          []       -> Nothing
          newTests -> Just <| Suite name newTests


assert : String -> Bool -> Outcome
assert label succeeded = if succeeded then Success else Failure label
