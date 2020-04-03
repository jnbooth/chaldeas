port module Main exposing (main)

import Json.Encode exposing (Value)

import Site.Application as Site
import Ports exposing (Ports)


{-| Updates the analytics webtracker with a new pageview on URL change. -}
port analytics : String -> Cmd msg


{-| Exports data to a global JavaScript object. -}
port export : (String, Value) -> Cmd msg


{-| Sets the page title. -}
port title : String -> Cmd msg


{-| Saves data to LocalStorage. -}
port store : (String, Value) -> Cmd msg


port sendCompress : String -> Cmd msg


port receiveCompress : (String -> msg) -> Sub msg


port sendDecompress : String -> Cmd msg


port receiveDecompress : (String -> msg) -> Sub msg


ports : Ports msg
ports =
    { analytics = analytics
    , export = \x y -> export (x, y)
    , store = \x y -> store (x, y)
    , title = title
    , sendCompress = sendCompress
    , receiveCompress = receiveCompress
    , sendDecompress = sendDecompress
    , receiveDecompress = receiveDecompress
    }


{-| Runs the website interface. -}
main =
    Site.app ports
