module LZW exposing
  ( compress
  , decompress
  )

import StandardLibrary exposing (flip)
import List.Extra as List


elemIndex : a -> List a -> Int
elemIndex w =
    List.elemIndex w
        >> Maybe.withDefault (-1)


foldl : (a -> b -> a) -> a -> List b -> a
foldl f x xs =
    List.foldl (flip f) x xs


get : a -> List a -> Int -> a
get x xs i =
    xs
        |> List.getAt i
        >> Maybe.withDefault x


liftA2 : (b -> c -> d) -> (List a -> b) -> (List a -> c) -> List a -> d
liftA2 f g h xs =
    f (g xs) (h xs)


take2 : List a -> List (List a)
take2 =
    List.tails
        >> List.map (List.take 2)
        >> List.filter (List.length >> (==) 2)


alphabet : List (List Char)
alphabet =
    List.range 32 126
        |> List.map (Char.fromCode >> List.singleton)


base64 : List Char
base64 =
    String.toList
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"


pairs64 : Int -> (Int, Int)
pairs64 x =
    (x // 64, remainderBy 64 x)


encode64 : Int -> List Char
encode64 x =
    let
        (a, b) =
            pairs64 x
    in
    List.map (get '?' base64) [a, b]


decode64 : List Char -> Int
decode64 x =
    case x of
        [a, b] ->
            elemIndex b base64 + 64 * elemIndex a base64

        _ ->
            -1


lzw : List (List a) -> List a -> List a -> List Int
lzw a w arr =
    case arr of
        (x::xs) ->
            let
                w_ = w ++ [x]
            in
            if List.member w_ a then
                lzw a w_ xs
            else
                elemIndex w a :: lzw (a ++ [w_]) [x] xs

        [] ->
            [elemIndex w a]


compress : String -> String
compress a =
    String.fromList << List.concatMap encode64 <|
    case String.toList a of
        (x::xs) -> lzw alphabet [x] xs
        []      -> []


decompress : String -> String
decompress s =
    case s of
        "" -> ""
        _ ->
            let
                cs =
                    String.toList s
                        |> List.groupsOf 2
                        >> List.map decode64

                f xs =
                    case (xs, List.reverse xs) of
                        (first::_, (last::_)::_) ->
                            first ++ [last]

                        _ ->
                            List.concat xs
            in
            String.fromList <<
            (flip List.concatMap cs << get []) <<
            foldl
                ( liftA2 (<<) (++)
                ((<<) (List.singleton << f) << List.map << get [])
                )
            alphabet <| take2 cs
