module Print exposing
  ( stars
  , places, commas
  , filterOut
  , file, url
  , unCamel
  , pretty
  )

{-| Helper functions for outputting to `String`s. -}

import Regex exposing (Regex)
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (usLocale)

import StandardLibrary exposing (flip)


{-| Some number of `"★"`s. -}
stars : Bool -> Int -> String
stars padded rarity =
    if padded then
        List.repeat rarity "★"
            |> String.join "  "
    else
        List.repeat rarity '★'
            |> List.intersperse ' '
            >> String.fromList


{-| Formats a number with commas every 3 digits. -}
commas : Float -> String
commas x =
    if not <| isInfinite x then
        format { usLocale | decimals = 0 } x
    else if x < 0 then
        "-∞"
    else
        "∞"


{-| Formats a number to a specified decimal precision. -}
places : Int -> Float -> String
places decimals x =
    if not <| isInfinite x then
        format { usLocale | decimals = decimals, thousandSeparator = "" } x
    else if x < 0 then
        "-∞"
    else
        "∞"


{-| Removes specified characters from strings. -}
filterOut : String -> String -> String
filterOut pattern =
    String.filter <|
    not << flip List.member (String.toList pattern)


{-| Removes characters which are illegal for file names. -}
file : String -> String
file =
    filterOut "?:/"


{-| Removes spaces from names in order to use them in URLs. -}
url : String -> String
url =
    filterOut " -/\""


{-| Converts `NightMode` into "Night Mode" etc. -}
unCamel : String -> String
unCamel =
    let
        replacer {match, submatches} =
            case submatches of
                Just x :: Just y :: _ ->
                    x ++ " " ++ y

                _ ->
                    match
    in
    Regex.replace camel replacer
        >> String.replace " The " " the "
        >> String.replace " Of " " of "


camel : Regex
camel =
    Regex.fromString "([a-z])([A-Z])|([A-Z])([A-Z][a-z])"
        |> Maybe.withDefault Regex.never

{-| Adds in fancy diacritics to `Servant` and `CraftEssence` names. -}
pretty : String -> String
pretty a =
    case a of
        "Fergus mac Roich" ->
            "Fergus mac Róich"

        "Mugashiki—Shinkuu Myou" ->
            "Mugashiki—Shinkuu Myōu"

        "Heroic Portrait: Scathach" ->
            "Heroic Portrait: Scáthach"

        "Cu Chulainn" ->
            "Cú Chulainn"

        "Cu Chulainn (Prototype)" ->
            "Cú Chulainn (Prototype)"

        "Cu Chulainn (Alter)" ->
            "Cú Chulainn (Alter)"

        "Cu Chulainn (Caster)" ->
            "Cú Chulainn (Caster)"

        "Elisabeth Bathory" ->
            "Elisabeth Báthory"

        "Elisabeth Bathory (Brave)" ->
            "Elisabeth Báthory (Brave)"

        "Elisabeth Bathory (Halloween)" ->
            "Elisabeth Báthory (Halloween)"

        "Scathach" ->
            "Scáthach"

        "Scathach (Assassin)" ->
            "Scáthach (Assassin)"

        "Angra Mainyu" ->
            "Aŋra Mainiiu"

        "Edmond Dantes" ->
            "Edmond Dantès"

        "Leonardo da Vinci" ->
            "Leonardo Da Vinci"

        "Tauropolos Skia Thermokrasia" ->
            "Tauropolos Skia Thermokrasía"

        "Wisdom of Dun Scaith" ->
            "Wisdom of Dún Scáith"

        "Cafe Camelot" ->
            "Café Camelot"

        "Chateau d'If" ->
            "Château d'If"

        "Chrysaor" ->
            "Chrȳsāōr"

        "The Dantes Files: The Case of the Spring Jaunt" ->
            "The Dantès Files: The Case of the Spring Jaunt"

        "Nina" ->
            "Niña"

        "The Dantes Files: Undercover in a Foreign Land" ->
            "The Dantès Files: Undercover in a Foreign Land"

        _ ->
            a
