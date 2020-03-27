module Wiki exposing
  ( Wiki, suite
  , match, matchList, matchOne, matchEffects
  , fromString
  , printBool
  )

import List.Extra  as List
import Maybe.Extra as Maybe
import Dict  exposing (Dict)
import Regex exposing (Match, Regex)
import Set exposing (Set)

import StandardLibrary exposing (..)
import MaybeRank       exposing (..)
import Printing        exposing (..)
import Test            exposing (Test(..), Outcome(..))
import Parse           exposing (..)

type alias Wiki =
    { fields : Dict String (List String)
    , lists  : Dict String (List (List String))
    }

suite : Dict String String
     -> ((MaybeRank -> Wiki) -> { a | name : String } -> List Test)
     -> { a | name : String }
     -> Test
suite pages test x = case Dict.get x.name pages of
      Nothing   -> Test x.name <| Failure "Page not found"
      Just page -> Suite x.name <| test (fromString page) x

match : Wiki -> String -> String -> Test
match wiki k obj =
  let
    cleanup = List.map <| filterOut "%,{}[]()'" >> trim0s
  in
    Test k <| case Maybe.map cleanup (Dict.get k wiki.fields) of
      Nothing -> Failure <| "Missing property"
      Just v  ->
          Test.assert (obj ++ " not in [" ++ String.join ", " v ++ "].") <|
          List.member obj v

matchList : Wiki -> String -> List (List String) -> Test
matchList mw k obj = case obj of
  [] -> Test k Success
  _ -> case Dict.get k mw.lists of
    Nothing -> Test k <| Failure <| "property missing in "++ Debug.toString mw.lists
    Just vs -> Suite k <|
      let
        lengthRange = List.range 0 <| List.length obj - 1
      in
        flip List.map lengthRange <| \i ->
            let
              label = "Level " ++ String.fromInt (i + 1)
            in
            case vs |> List.drop i >> List.head of
              Nothing ->
                  Test label <| Failure "missing from Wiki"
              Just vsAt ->
                let
                  obAt = obj |> List.drop i >> List.head >> Maybe.withDefault []
                in
                  shouldMatch label obAt vsAt


listDiff : List a -> List a -> List a
listDiff = List.foldr List.remove

forwardZeroes : Regex
forwardZeroes =
    Regex.fromString "0+(\\d[.0-9]*)"
        |> Maybe.withDefault Regex.never

backwardZeroes : Regex
backwardZeroes =
    Regex.fromString "(\\d+\\.\\d*)0+"
        |> Maybe.withDefault Regex.never

trailingZero : Regex
trailingZero =
    Regex.fromString "(\\d+)\\.0*"
        |> Maybe.withDefault Regex.never

replace : Regex -> String -> String
replace r s =
    let
        replacer m =
            if m.match == s then
                case m.submatches of
                    [Just sub] -> sub
                    _          -> s
            
            else
                m.match
    in
    Regex.replace r replacer s

digits : Set Char
digits =
    Set.fromList <| String.toList ".0123456789"

trim0s : String -> String
trim0s s =
    if True || String.all (\c -> Set.member c digits) s then
        let
            trimmed =
                s
                    |> replace forwardZeroes
                    >> replace backwardZeroes
                    >> replace trailingZero
            
            in
            if String.startsWith "." trimmed then
                "0" ++ trimmed
            else
                trimmed
    else
        s

{-
trim0s : String -> String
trim0s x =
  Just ('.', xs) -> "0." ++ xs
  Just ('0', "") -> x
  Just ('0', xs) -> trim0s xs
  _              -> x
-}

matchUnique : List String -> List String
matchUnique xs =
    List.unique <| case xs of
        [x] -> String.split ";" x
        _   -> xs

shouldMatch : String -> List String -> List String -> Test
shouldMatch label x y =
  let
    x_ = matchUnique x
    y_ = matchUnique y
    diffTest xs = case xs of
      [] -> Success
      _  -> Failure <| String.join ", " xs
  in
    Suite label
      [ Test "Missing from Wiki" << diffTest <| listDiff x_ y_
      , Test "Missing from Data" << diffTest <| listDiff y_ x_
      ]

matchOne : Wiki -> String -> Int -> String -> Test
matchOne wiki k i x =
  let
    y =
        Dict.get "skillname" wiki.fields
        |> Maybe.andThen (List.drop i >> List.head)
        >> Maybe.map (String.replace " - " "—")

    x_ =
        if String.isEmpty x then
            Nothing
        else
            Just x
  in
    if x_ == y || Maybe.map translate x_ == y then
      Test k <| Success
    else
      Suite k
        [ Test "From Data" <| Failure x
        , Test "From Wiki" << Failure <| Maybe.withDefault "" y
        ]

matchEffects : Wiki -> String -> (Int, Int) -> List String -> Test
matchEffects wiki k span xs =
    shouldMatch k xs <| List.concatMap readEffect (range wiki k span)

printBool : Bool -> String
printBool a = if a then "Yes" else "No"

fromString : String -> MaybeRank -> Wiki
fromString text rank =
  let
    lists  = Dict.fromList <| parseLists text
    firstMatch =
        .submatches
        >> List.head
        >> Maybe.join
        >> Maybe.withDefault ""
    fields =
        rankedSection rank text
        |> Regex.replace wikiLink firstMatch
        >> String.split "|"
        >> List.map parseFields
        >> Maybe.values
        >> List.reverse
        >> Dict.fromList
  in
    Wiki fields lists


-----------
-- INTERNAL
-----------

range : Wiki -> String -> (Int, Int) -> List String
range wiki k (from, to) =
    flip List.concatMap (List.range from to) <|
    String.fromInt
    >> (++) k
    >> flip Dict.get wiki.fields
    >> Maybe.withDefault []
    >> List.map (filterOut "%,{}[]()'")

wikiLink : Regex
wikiLink =
    Regex.fromString "\\[\\[[^\\|\\]]+\\|([^\\]]+)\\]\\]"
    |> Maybe.withDefault Regex.never

wikiTag : Regex
wikiTag =
    Regex.fromString "<[^\\s>]+>"
    |> Maybe.withDefault Regex.never

splitLines : String -> List String
splitLines = splitAll ["<br/>","<br>","<Br>","<Br/>","<br />","\n"]

unSpace : String -> String
unSpace = String.replace " *" "*" >> String.replace "* " "*"

splitAll : (List String) -> String -> List String
splitAll delims x = List.foldr (List.concatMap << String.split) [x] delims

splitAround : String -> String -> Maybe (String, String)
splitAround needle haystack = case String.split needle haystack of
  []      -> Nothing
  [_]     -> Nothing
  x :: xs -> Just (x, String.join needle xs)

maybeSplit : String -> String -> (String, String)
maybeSplit needle haystack =
    splitAround needle haystack
    |> Maybe.withDefault (haystack, "")

oneOf : List (Maybe a) -> Maybe a
oneOf a = case a of
  []           -> Nothing
  Just x :: _  -> Just x
  _      :: xs -> oneOf xs

splitAny : List String -> String -> Maybe (String, String)
splitAny needles haystack =
    oneOf <| List.map (flip splitAround haystack) needles

-- Notation 2: Monadic Booga-Do
bind : Maybe a -> (a -> Maybe b) -> Maybe b
bind = flip Maybe.andThen

guard : Bool -> (() -> Maybe a) -> Maybe a
guard continue = if continue then ((|>) ()) else always Nothing

parseCol : Int -> Int -> List String -> Maybe (List String)
parseCol row col lines =
    let search = "|" ++ String.fromInt row ++ String.fromInt col in
    bind (List.find (String.left 3 >> (==) search) lines) <| \entry ->
    bind (splitAround "=" entry) <| \(_, after) ->
    let val = after |> String.filter ((/=) '}') >> String.trim >> unSpace in
    parseCol row (col + 1) lines
    |> Maybe.map ((::) val)
    >> Maybe.withDefault [val]
    >> Just

parseRow : Int -> List String -> Maybe (List (List String))
parseRow row lines =
    bind (parseCol row 1 lines) <| \cols ->
    parseRow (row + 1) lines
    |> Maybe.map ((::) cols)
    >> Maybe.withDefault [cols]
    >> Just

parseRows : String -> List (List String)
parseRows =
    splitLines
    >> parseRow 1
    >> Maybe.withDefault []

parseLists : String -> List (String, List (List String))
parseLists text =
    Maybe.withDefault [] <<
    bind (splitAround "==" text)        <| \(_,            headerStart) ->
    bind (splitAround "==" headerStart) <| \(beforeHeader, afterHeader) ->
    let header = String.trim beforeHeader
        (beforeSection, afterSection) = maybeSplit "==" afterHeader in
    Just <|
    (header, parseRows beforeSection) :: parseLists ("==" ++ afterSection)


validDigits : Set Char
validDigits =
    Set.fromList ['.', '%', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9']


removeZeroes : String -> String
removeZeroes s =
    if
        True || (
        (String.endsWith "0" s || String.endsWith "0%" s)
            && String.all (\c -> Set.member c validDigits) s
            && String.length (String.filter ((==) '.') s) == 1
        )
    then
        let
            (isPercent, chars) =
                case s |> String.reverse >> String.toList of
                    '%' :: xs -> (True, xs)
                    xs        -> (False, xs)

            stripped =
                case List.dropWhile ((==) '0') chars of
                    '.' :: xs -> xs
                    _         -> chars
            
            percented =
                if isPercent then
                    '%' :: stripped
                else
                    stripped
        in
        percented
            |> String.fromList
            >> String.reverse
    
    else
        s


parseFields : String -> Maybe (String, List String)
parseFields text =
    bind (List.head <| String.indices "=" text) <| \assignment ->
    bind (splitAround "=" text) <| \(before, after)  ->
    let afterLines = splitLines after in
    guard (not <| String.isEmpty before) <| \_ ->
    Just <<
    (\x -> (String.trim <| String.toLower before, x)) <<
    List.filter (not << String.isEmpty) <<
    flip List.map afterLines <|
    stripPrefix "="
    >> maybeDo (splitAny ["}}"," /","/4", "% (0"] >> Maybe.map Tuple.first)
    >> maybeDo (splitAny ["EN:","tip-text:"] >> Maybe.map Tuple.second)
    >> Regex.replace wikiTag (always " ")
    >> String.trim
    -- >> removeZeroes

rankedSection : MaybeRank -> String -> String
rankedSection rank text =
    Maybe.withDefault text <<
    bind (splitAny [MaybeRank.show rank ++ "="] text) <|
    Tuple.second >> splitAny ["|-|", "/onlyinclude"] >> Maybe.map Tuple.first
