module StandardLibrary exposing
  ( compareThen, alwaysEq
  , dict
  , duplicates
  , enumToOrd
  , flip
  , maybeDo
  , pure
  , removeWith
  , stripPrefix, stripSuffix
  , suite
  )

{-| A "classy prelude" that fills in holes in `Basic`,
including several functions that were removed in Elm 0.19. -}

import Dict exposing (Dict)
import List.Extra as List


{-| Creates a comparable projection function for enumerated types. -}
enumToOrd : List a -> (a -> Int)
enumToOrd xs x =
    List.findIndex ((==) x) xs
        |> Maybe.withDefault (-1)


compareThen : (a -> comparable) -> (a -> a -> Order) -> (a -> a -> Order)
compareThen first next x y =
    case compare (first x) (first y) of
        EQ    -> next x y
        order -> order


alwaysEq : a -> a -> Order
alwaysEq =
    EQ
        |> always
        >> always


{-| Creates a `Dict` using a function that generates (key, value) pairs. -}
dict : List a -> (a -> (comparable, b)) -> Dict comparable b
dict xs =
    flip List.map xs
        >> Dict.fromList


{-| Returns all elements of a List that it contains more than once. -}
duplicates : List comparable -> List comparable
duplicates xs =
    xs
        |> List.unique
        >> List.filter (\x -> List.member x <| List.remove x xs)


{-| Flips the arguments of a function. -}
flip : (a -> b -> c) -> b -> a -> c
flip f b a =
    f a b


{-| Performs a transformation only if it returns a `Just` value. -}
maybeDo : (a -> Maybe a) -> a -> a
maybeDo f x =
    f x
        |> Maybe.withDefault x


{-| `(_, Cmd.none)` -}
pure : a -> (a, Cmd b)
pure x =
    (x, Cmd.none)


{-| Removes an element from a list using the supplied equality function. -}
removeWith : (a -> a -> Bool) -> a -> List a -> List a
removeWith eq x xs =
    case xs of
        y :: ys ->
            if eq x y then
                ys
            else
                y :: removeWith eq x ys

        [] ->
            []

{-| Removes a string from the beginning of another string. -}
stripPrefix : String -> String -> String
stripPrefix pattern s =
    if String.startsWith pattern s then
        String.dropLeft (String.length pattern) s
    else
        s


{-| Removes a string from the end of another string. -}
stripSuffix : String -> String -> String
stripSuffix pattern s =
    if String.endsWith pattern s then
      String.dropRight (String.length pattern) s
    else
      s

{-| Labels a suite of errors if any exist. -}
suite : String -> List String -> List String
suite label xs =
    case xs of
        [] -> []
        _  -> [label ++ ": " ++ String.join ", " xs]
