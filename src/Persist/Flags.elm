module Persist.Flags exposing
  ( Team
  , Flags, decodeFlags
  , storePreferences, storeMine, storeTeams
  , encodeMine, decodeMine
  )

import Json.Decode as D
import Json.Encode as E
import List.Extra  as List
import Maybe.Extra as Maybe
import Set         as Set
import Date exposing (Date)
import Dict exposing (Dict)
import Time

import StandardLibrary       exposing (..)
import Database              exposing (..)
import Database.Base         exposing (..)
import Database.CraftEssence exposing (..)
import Database.Servant      exposing (..)
import MyServant             exposing (..)
import Persist.Preferences   exposing (..)

import Class.Show as Show


type alias Team =
    { name    : String
    , members : List (Maybe Servant, Maybe CraftEssence)
    }


type alias Flags =
    { today       : Date
    , preferences : Preferences
    , mine        : Dict OrdServant MyServant
    , teams       : List Team
    }


encodeMaybe : (a -> Value) -> Maybe a -> Value
encodeMaybe f a =
    case a of
        Just x  -> f x
        Nothing -> E.null


decodeFlags : D.Decoder Flags
decodeFlags =
    D.map4 Flags
    (D.field "today" decodeDate)
    (D.field "preferences" decodePreferences)
    (D.field "team" decodeMine)
    (D.field "teams" <| D.list decodeTeam)


decodeDate : D.Decoder Date
decodeDate =
    D.int
        |> D.andThen (Time.millisToPosix >> Date.today >> D.succeed)


encodePreferences : Preferences -> Value
encodePreferences =
    let
        encodePref x =
            List.find (ordPreference >> (==) x) enumPreference
    in
    Set.toList
        >> List.map encodePref
        >> Maybe.values
        >> List.map Show.preference
        >> E.list E.string


decodePreferences : D.Decoder Preferences
decodePreferences =
    let
        fromList a =
            D.succeed <| case a of
                Just prefs ->
                    let
                        acc pref =
                            setPreference pref <|
                            List.member (Show.preference pref) prefs
                    in
                    List.foldr acc Set.empty enumPreference

                Nothing ->
                    noPreferences
    in
    D.list D.string
        |> D.nullable
        >> D.andThen fromList


encodeStat : Stat -> Value
encodeStat stat =
    E.object
    [ ("atk", E.int stat.atk)
    , ("hp",  E.int stat.hp)
    ]


decodeStat : D.Decoder Stat
decodeStat =
    D.map2 Stat
    (D.field "atk" D.int)
    (D.field "hp"  D.int)


encodeCraftEssence : CraftEssence -> Value
encodeCraftEssence =
    .id >> E.int


decodeCraftEssence : D.Decoder CraftEssence
decodeCraftEssence =
    let
        fromId id =
            case List.find (.id >> (==) id) craftEssences of
                Just s ->
                    D.succeed s

                Nothing ->
                    D.fail <| "Unknown Craft Essence #" ++ String.fromInt id
    in
    D.int |> D.andThen fromId


encodeServant : Servant -> Value
encodeServant =
    .id >> E.int


decodeServant : D.Decoder Servant
decodeServant =
    let
        fromId id =
            case List.find (.id >> (==) id) servants of
                Just s ->
                    D.succeed s

                Nothing ->
                    D.fail <| "Unknown Servant #" ++ String.fromInt id

    -- Backward compatibility
        fromName name =
            case List.find (.name >> (==) name) servants of
                Just s ->
                    D.succeed s

                Nothing ->
                    D.fail <| "Unknown Servant " ++ name
    in
    D.oneOf
    [ D.int    |> D.andThen fromId
    , D.string |> D.andThen fromName
    ]


encodeMyServant : MyServant -> Value
encodeMyServant ms =
    E.object
    [ ("level",   E.int ms.level)
    , ("fou",     encodeStat ms.fou)
    , ("skills",  E.list E.int ms.skills)
    , ("npLvl",   E.int ms.npLvl)
    , ("ascent",  E.int ms.ascent)
    , ("servant", encodeServant ms.servant)
    ]


decodeMyServant : D.Decoder MyServant
decodeMyServant =
    D.map8 MyServant
    (D.field "level" D.int)
    (D.field "fou" decodeStat)
    (D.field "skills" <| D.list D.int)
    (D.field "npLvl" D.int)
    (D.field "ascent" D.int)
    (D.field "servant" decodeServant)
    (D.field "servant" decodeServant)
    (D.succeed Dict.empty)


decodeMine : D.Decoder (Dict OrdServant MyServant)
decodeMine =
    let
        keyPair ms = (ordServant ms.base, recalc ms)
    in
    D.list decodeMyServant
        |> D.andThen (List.map keyPair >> Dict.fromList >> D.succeed)


encodeMine : Dict OrdServant MyServant -> E.Value
encodeMine =
    Dict.toList
        >> List.map Tuple.second
        >> E.list encodeMyServant


decodeTeamMember : D.Decoder (Maybe Servant, Maybe CraftEssence)
decodeTeamMember =
    D.map2 Tuple.pair
    (D.field "s" <| D.nullable decodeServant)
    (D.field "ce" <| D.nullable decodeCraftEssence)


encodeTeamMember : (Maybe Servant, Maybe CraftEssence) -> Value
encodeTeamMember (s, ce) =
    E.object
    [ ("s", encodeMaybe encodeServant s)
    , ("ce", encodeMaybe encodeCraftEssence ce)
    ]


decodeTeam : D.Decoder Team
decodeTeam =
    D.map2 Team
    (D.field "name" D.string)
    (D.field "members" <| D.list decodeTeamMember)


encodeTeam : Team -> Value
encodeTeam x =
    E.object
    [ ("name",    E.string x.name)
    , ("members", E.list encodeTeamMember x.members)
    ]


storePreferences : (String -> Value -> Cmd msg) -> Preferences -> Cmd msg
storePreferences store =
    encodePreferences
        >> store "preferences"


storeMine : (String -> Value -> Cmd msg) -> Dict OrdServant MyServant -> Cmd msg
storeMine store =
    encodeMine
        >> store "team"


storeTeams : (String -> Value -> Cmd msg) -> List Team -> Cmd msg
storeTeams store =
    E.list encodeTeam
        >> store "teams"
