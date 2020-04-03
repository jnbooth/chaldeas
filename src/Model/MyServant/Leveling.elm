module Model.MyServant.Leveling exposing
  ( maxLevel
  , ascendCost, skillCost
  , ascendWishlist, skillWishlist
  )

{-| Fixed rates for leveling `Servant`s based on their rarity. -}

import Array
import List.Extra as List

import StandardLibrary exposing (flip)
import Model.Material as Material exposing (Material)
import Model.Servant as Servant exposing (Servant)
import Model.MyServant exposing (MyServant)
import Persist.Preference exposing (Preference(..))
import Persist.Preferences exposing (Preferences, prefers)


maxLevel : Servant -> Int
maxLevel x =
    case x.rarity of
        1 -> 60
        3 -> 70
        4 -> 80
        5 -> 90
        _ -> 65


ascendCost : Servant -> Int -> Int
ascendCost x =
    let
        costs =
            Array.fromList <| case x.rarity of
                1 -> [ 10,  30,   90,  300]
                3 -> [ 30, 100,  300,  900]
                4 -> [ 50, 150,  500, 1500]
                5 -> [100, 300, 1000, 3000]
                _ -> [ 15,  45,  150,  450]
    in
    if String.startsWith "Mash Kyrielight" x.name then
        always 0
    else
        flip Array.get costs
        >> Maybe.withDefault 0
        >> (*) 1000


atAscension : MyServant -> Int
atAscension x =
    let
        tier =
            (-) x.level <| case x.base.rarity of
                5 -> 50
                4 -> 40
                3 -> 30
                1 -> 20
                _ -> 25

        ascension =
            tier // 10
    in
    min 4 << max 0 <|
    if remainderBy 10 tier == 0 && x.ascent > ascension then
        ascension + 1
    else
        ascension


reduceMats : List (List (Material, Int)) -> List (Material, Int)
reduceMats =
    let
        reduce ((x, y), xs) =
            (x, List.sum <| y :: List.map Tuple.second xs)

        eqFirst (x, _) (y, _) =
            x == y
    in
    List.concat
        >> List.sortBy (Tuple.first >> Material.ord)
        >> List.groupWhile eqFirst
        >> List.map reduce


skillWishlist : Preferences -> List MyServant -> List (Material, Int)
skillWishlist prefs xs =
    let
        bind = flip List.concatMap
        mxs =
            if prefers prefs MaxReinforce then
                List.filter (\ms -> ms.level >= maxLevel ms.servant) xs
            else
                xs
    in
    reduceMats <<
    {- poor man's do-notation, i.e. do
           ms <- xs
           let reinforce = getReinforcements ms.base
           skillLvl <- ms.skills
           drop (skillLvl - 1) reinforce -}
    bind mxs <| \ms ->
    let reinforce = Servant.getReinforcements ms.base in
    bind ms.skills <| \skillLvl ->
    List.drop (skillLvl - 1) reinforce


ascendWishlist : List MyServant -> List (Material, Int)
ascendWishlist xs =
    reduceMats <<
    flip List.concatMap xs <| \ms ->
        List.drop (atAscension ms) <|
        Servant.getAscensions ms.base


skillCost : Servant -> Int -> Int
skillCost x =
    let
        costs = Array.fromList <| case x.rarity of
            1 -> [ 10,  20,   60,   80,  200,  250,   500,   600,  1000]
            3 -> [ 50, 100,  300,  400, 1000, 1250,  2500,  3000,  5000]
            4 -> [100, 200,  600,  800, 2000, 2500,  5000,  6000, 10000]
            5 -> [200, 400, 1200, 1600, 4000, 5000, 10000, 12000, 20000]
            _ -> [ 20,  40,  120,  160,  400,  500,  1000,  1200,  2000]
    in
    flip Array.get costs
        >> Maybe.withDefault 0
        >> (*) 1000
