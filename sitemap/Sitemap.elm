port module Sitemap exposing (main)

import Platform exposing (worker)

import StandardLibrary exposing (pure)
import Print
import Database.CraftEssences as CraftEssences
import Database.Servants as Servants

output : String
output =
    String.join "\n" <<
    List.sort <<
    List.map ((++) "https://chaldeas.surge.sh/") <|
    ["Servants", "CraftEssences", "MyServants"]
    ++ List.map (.name >> Print.url >> (++) "Servants/") Servants.db
    ++ List.map (.name >> Print.url >> (++) "CraftEssences/") CraftEssences.db

port print : String -> Cmd msg

main : Program () () Never
main = worker
    { init = \_ -> ((), print output)
    , update = \_ _ -> pure ()
    , subscriptions = \_ -> Sub.none
    }
