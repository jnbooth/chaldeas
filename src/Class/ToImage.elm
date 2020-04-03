module Class.ToImage exposing (..)

{-| Links to the `/img` folder.

# Usage
@docs ImagePath, ToImage, image, thumbnail, link
# `Model`
@docs card, class, icon, material
# `Database.CraftEssence`
@docs craftEssence
# `Database.Servant`
@docs servant
# `Model.Skill`
@docs buffEffect, debuffEffect
# `MyServant`
@docs myServant
-}

import Html as H exposing (Html)
import Html.Attributes as P

import Print
import Model.Card as Card exposing (Card)
import Model.Class as Class exposing (Class)
import Model.Material as Material exposing (Material)
import Model.CraftEssence exposing (CraftEssence)
import Model.Icon as Icon exposing (Icon)
import Model.Servant exposing (Servant)
import Model.Skill.BuffEffect as BuffEffect exposing (BuffEffect(..))
import Model.Skill.DebuffEffect as DebuffEffect exposing (DebuffEffect(..))


type alias ImagePath =
    { dir  : String
    , file : String
    }


type alias ToImage a =
    a -> ImagePath


src : ImagePath -> H.Attribute a
src {dir, file} =
    P.src <| "/img/" ++ dir ++ "/" ++ Print.file file ++ ".png"


image : ImagePath -> Html a
image path = H.img [src path] []


card : ToImage Card
card =
    ImagePath "Card" <<
    Card.show


class : ToImage Class
class =
    ImagePath "Class" <<
    Class.show


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
    Icon.show


material : ToImage Material
material =
    ImagePath "Material" <<
    Material.show


buffEffect : ToImage BuffEffect
buffEffect a =
    case a of
        Resist _     -> buffEffect DebuffResist
        Special ef _ -> buffEffect ef
        Success _    -> buffEffect DebuffUp
        _            -> ImagePath "Effect" <| BuffEffect.name a


debuffEffect : ToImage DebuffEffect
debuffEffect =
    ImagePath "Effect" <<
    DebuffEffect.name


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
