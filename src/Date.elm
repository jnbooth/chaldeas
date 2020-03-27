module Date exposing (Date, compare, today)

import Time

import StandardLibrary exposing (..)


type alias Date =
    { year  : Int
    , month : Time.Month
    , day   : Int
    }


ordMonth : Time.Month -> Int
ordMonth a =
    case a of
        Time.Jan -> 0
        Time.Feb -> 1
        Time.Mar -> 2
        Time.Apr -> 3
        Time.May -> 4
        Time.Jun -> 5
        Time.Jul -> 6
        Time.Aug -> 7
        Time.Sep -> 8
        Time.Oct -> 9
        Time.Nov -> 10
        Time.Dec -> 11


compare : Date -> Date -> Order
compare =
    compareThen .year <<
    compareThen (.month >> ordMonth) <|
    compareThen .day
    alwaysEq


here : Time.Zone
here = Time.customZone (-4 * 60) []


today : Time.Posix -> Date
today now =
    let
        get f =
            f here now
    in
    Date (get Time.toYear) (get Time.toMonth) (get Time.toDay)
