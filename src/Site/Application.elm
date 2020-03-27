module Site.Application exposing (app)

import Html            as H
import Html.Attributes as P

import List.Extra         as List
import Browser.Dom        as Dom
import Browser.Navigation as Navigation
import Json.Decode        as Json

import Browser exposing (Document, UrlRequest)
import Date
import Dict
import Url     exposing (Url)
import Task
import Time

import StandardLibrary     exposing (..)
import Persist.Flags       exposing (..)
import Persist.Preferences exposing (..)
import Printing            exposing (..)
import Site.Algebra        exposing (..)

import Site.CraftEssence.Component as CraftEssences
import Site.Servant.Component      as Servants
import Class.Show                  as Show


{-| The page currently being shown. -}
type Viewing
    = CraftEssences
    | Servants


showViewing : Viewing -> String
showViewing a =
    case a of
        CraftEssences -> "CraftEssences"
        Servants      -> "Servants"


type alias Model =
    { error   : Maybe String
    , navKey  : Navigation.Key
    , onTeam  : Maybe (Int, Int)
    , viewing : Viewing
    , prefs   : Preferences
    , ceModel : CraftEssences.Model
    , sModel  : Servants.Model
    }


type Msg
    = RequestUrl       UrlRequest
    | ChangeUrl        Url
    | CraftEssencesMsg CraftEssences.Msg
    | ServantsMsg      Servants.Msg
    | OnError          (Result Dom.Error ())


printError : Dom.Error -> String
printError (Dom.NotFound id) =
    "Element #" ++ id ++ " not found!"


{-| If loaded with a url for a particular Servant or Craft Essence,
the corresponding Servant/CE is displayed. -}
focusFromPath : (b -> Bool) -> SiteModel a b c -> SiteModel a b c
focusFromPath pred st =
    case Maybe.map pred st.focus of
        Just True ->
            st

        _ ->
            { st | focus = st.listing
                               |> List.map Tuple.second
                               >> List.find pred
            }


stateFromPath : String -> Model -> (Model, String)
stateFromPath fullPath st =
    let
        (main, sub) =
            case String.split "/" <| String.dropLeft 1 fullPath of
                x :: y :: _ -> (x, y)
                x :: _      -> (x, "")
                []          -> ("", "")
    in
    case main of
        "CraftEssences" ->
            let
                ceModel =
                    focusFromPath (.name >> urlName >> (==) sub) st.ceModel
            in
            ( { st
              | viewing = CraftEssences
              , ceModel = ceModel
              }
            , Maybe.withDefault "Craft Essences" <|
              Maybe.map .name ceModel.focus
            )

        _ ->
            let
                show = Show.servant <| prefer st.prefs HideSpoilers

                match {base} =
                    case base.spoiler of
                        Just x ->
                            sub == urlName base.name
                                || sub == urlName
                                   (Show.class base.class ++ " of " ++ x)
                        Nothing ->
                            sub == urlName base.name

                sModel =
                    focusFromPath match st.sModel

                {extra}  =
                    sModel

                mineOnly =
                    main == "MyServants"
            in
                ( { st
                  | viewing = Servants
                  , sModel  = Servants.setRoot
                              { sModel
                              | extra =
                                  { extra
                                  | mineOnly = mineOnly
                                  , export = Nothing
                                  }
                              }
                  }
                , sModel.focus
                    |> Maybe.map (.base >> show)
                    >> Maybe.withDefault
                       (if mineOnly then "My Servants" else "Servants")
                )


resetPopup : Cmd Msg
resetPopup =
    Task.attempt OnError <| Dom.setViewportOf "focus" 0 0


app onInit analytics title store =
    let
        child constr unMsg =
            constr ((<<) (Cmd.map unMsg) << store)

        ceChild : Component CraftEssences.Model CraftEssences.Msg
        ceChild =
            child CraftEssences.component <| \a -> case a of
                CraftEssencesMsg x -> x
                _                  -> DoNothing

        sChild : Component Servants.Model Servants.Msg
        sChild =
            child Servants.component <| \a -> case a of
                ServantsMsg x -> x
                _             -> DoNothing

        init : Value -> Url -> Navigation.Key -> (Model, Cmd Msg)
        init val url key =
            let
                (error, flags) =
                    case Json.decodeValue decodeFlags val of
                        Ok ok ->
                            (Nothing, ok)

                        Err err ->
                            ( Just <| Json.errorToString err
                            , { today       = 0
                                                  |> Time.millisToPosix
                                                  >> Date.today
                              , preferences = noPreferences
                              , mine        = Dict.empty
                              , teams       = []
                              }
                            )
                (st, newTitle) =
                    stateFromPath url.path
                    { error   = error
                    , navKey  = key
                    , onTeam  = Nothing
                    , viewing = Servants
                    , prefs   = flags.preferences
                    , ceModel = ceChild.init flags key
                    , sModel  = sChild.init flags key
                    }
            in
            (st, Cmd.batch [onInit, title newTitle])

        view : Model -> Document Msg
        view st =
            let
                showError = case st.error of
                    Just err -> (::) <| H.div [P.id "error"] [H.text err]
                    Nothing  -> identity
            in
            Document "CHALDEAS" << showError << List.singleton <|
            case st.viewing of
                CraftEssences ->
                    H.map CraftEssencesMsg <| ceChild.view st.prefs st.ceModel

                Servants ->
                    H.map ServantsMsg <| sChild.view st.prefs st.sModel

        setPref : Model -> Preference -> Bool -> (Model, Cmd Msg)
        setPref st k v =
            let
                prefs =
                    setPreference k v st.prefs

                msg =
                    SetPref k v

                (ceModel, ceCmd) =
                    ceChild.update prefs msg st.ceModel

                (sModel, sCmd) =
                    sChild.update prefs msg st.sModel
            in
            ( { st
              | prefs   = prefs
              , ceModel = ceModel
              , sModel  = sModel
              }
            , Cmd.batch
              [ storePreferences store prefs
              , Cmd.map CraftEssencesMsg ceCmd
              , Cmd.map ServantsMsg sCmd
              ]
            )

        update : Msg -> Model -> (Model, Cmd Msg)
        update parentMsg st = case parentMsg of
            OnError (Ok _) ->
                pure st

            OnError (Err err) ->
                pure { st | error = Just <| printError err }

            RequestUrl urlRequest -> case urlRequest of
                Browser.Internal url  ->
                    if String.contains (showViewing st.viewing) url.path
                    && String.contains "/" (String.dropLeft 1 url.path) then
                        pure st
                    else
                        (st, Navigation.pushUrl st.navKey <| Url.toString url)

                Browser.External href ->
                    (st, Navigation.load href)

            ChangeUrl {path} ->
                let
                    (newSt, newTitle) =
                        stateFromPath path st
                in
                (newSt, Cmd.batch [analytics path, title newTitle, resetPopup])

            CraftEssencesMsg (SetPref k v) ->
                setPref st k v

            ServantsMsg (SetPref k v) ->
                setPref st k v

            CraftEssencesMsg msg ->
                let
                    (model, cmd) =
                        ceChild.update st.prefs msg st.ceModel
                in
                ({ st | ceModel = model }, Cmd.map CraftEssencesMsg cmd)

            ServantsMsg msg ->
                let
                    (model, cmd) =
                        sChild.update st.prefs msg st.sModel
                in
                ({ st | sModel = model }, Cmd.map ServantsMsg cmd)
    in
    { init          = init
    , view          = view
    , update        = update
    , subscriptions = always Sub.none
    , onUrlRequest  = RequestUrl
    , onUrlChange   = ChangeUrl
    }
