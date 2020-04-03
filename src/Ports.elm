module Ports exposing
  ( Ports
  , map
  )

import Json.Encode exposing (Value)


type alias Ports msg =
    { analytics : String -> Cmd msg
    , export : String -> Value -> Cmd msg
    , store : String -> Value -> Cmd msg
    , title : String -> Cmd msg
    , sendCompress : String -> Cmd msg
    , receiveCompress : (String -> msg) -> Sub msg
    , sendDecompress : String -> Cmd msg
    , receiveDecompress : (String -> msg) -> Sub msg
    }


map : Ports a -> (b -> a) -> (a -> b) -> Ports b
map x from to =
    { analytics = x.analytics >> Cmd.map to
    , export = x.export >> (<<) (Cmd.map to)
    , store = x.store >> (<<) (Cmd.map to)
    , title = x.title >> Cmd.map to
    , sendCompress = x.sendCompress >> Cmd.map to
    , receiveCompress = mapSub from to x.receiveCompress
    , sendDecompress = x.sendDecompress >> Cmd.map to
    , receiveDecompress = mapSub from to x.receiveDecompress
    }


mapSub : (b -> a) -> (a -> b) -> ((String -> a) -> Sub a) -> ((String -> b) -> Sub b)
mapSub from to sub cmd =
    Sub.map to <| sub (from << cmd)
