module Class.ToImage exposing (..)

{-| Links to the `/img` folder.

# Usage
@docs ImagePath, ToImage, image, thumbnail, link
# `Database.Base`
@docs card, class, icon, material
# `Database.CraftEssence`
@docs craftEssence
# `Database.Servant`
@docs servant
# `Database.Skill`
@docs buffEffect, debuffEffect
# `MyServant`
@docs myServant
-}

import Html            as H exposing (Html)
import Html.Attributes as P

import MyServant             exposing (..)
import Printing              exposing (..)
import Database.Base         exposing (..)
import Database.CraftEssence exposing (..)
import Database.Icon         exposing (Icon)
import Database.Servant      exposing (..)
import Database.Skill        exposing (..)

import Class.Show as Show


type alias ImagePath =
    { dir  : String
    , file : String
    }


type alias ToImage a =
    a -> ImagePath


src : ImagePath -> H.Attribute a
src {dir, file} =
    P.src <| "/img/" ++ dir ++ "/" ++ fileName file ++ ".png"


image : ImagePath -> Html a
image path = H.img [src path] []


card : ToImage Card
card =
    ImagePath "Card" <<
    Show.card


class : ToImage Class
class =
    ImagePath "Class" <<
    Show.class


servant : ToImage Servant
servant =
    ImagePath "Servant" <<
    .name


craftEssence : ToImage CraftEssence
craftEssence =
    ImagePath "CraftEssence" <<
    .name


icon : ToImage Icon
icon =
    ImagePath "Skill" <<
    Show.icon


material : ToImage Material
material =
    ImagePath "Material" <<
    Show.material


buffEffect : ToImage BuffEffect
buffEffect a =
    case a of
        Resist _     -> buffEffect DebuffResist
        Special ef _ -> buffEffect ef
        Success _    -> buffEffect DebuffUp
        _            -> ImagePath "Effect" <| Show.nameBuffEffect a


debuffEffect : ToImage DebuffEffect
debuffEffect =
    ImagePath "Effect" <<
    Show.nameDebuffEffect


ceThumb : CraftEssence -> Html a
ceThumb ce =
    H.img
    [ src << ImagePath "CraftEssenceThumbnail" <| String.fromInt ce.id
    , P.title ce.name
    ]
    []


servantThumb : String -> Servant -> Html a
servantThumb name s =
    H.img
    [ src << ImagePath "ServantThumbnail" <| String.fromInt s.id
    , P.title name
    ]
    []
