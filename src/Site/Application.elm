module Site.Application exposing (app)

import Browser exposing (Document, UrlRequest)
import Browser.Dom as Dom
import Browser.Navigation as Navigation
import Dict
import Html as H
import Html.Attributes as P
import Json.Decode as D
import Json.Encode as E exposing (Value)
import List.Extra as List
import Task
import Time
import Url exposing (Url)

import StandardLibrary exposing (pure)
import Class.ToJSON as Export
import Date
import Model.Class as Class
import Model.Servant as Servant
import Persist.Flags as Flags
import Persist.Preference exposing (Preference(..))
import Persist.Preferences as Preferences exposing (Preferences, prefers)
import Ports exposing (Ports)
import Print
import Site.Algebra exposing (Component, SiteModel, SiteMsg(..))

import Database.CraftEssences as CraftEssences
import Database.Servants as Servants

import Site.CraftEssence.Component as CraftEssences
import Site.Servant.Component as Servants


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
    = RequestUrl        UrlRequest
    | ChangeUrl         Url
    | CraftEssencesMsg  CraftEssences.Msg
    | ServantsMsg       Servants.Msg
    | OnError           (Result Dom.Error ())


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
                    focusFromPath (.name >> Print.url >> (==) sub) st.ceModel
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
                show = Servant.show <| prefers st.prefs HideSpoilers

                match {base} =
                    case base.spoiler of
                        Just x ->
                            sub == Print.url base.name
                                || sub == Print.url
                                   (Class.show base.class ++ " of " ++ x)
                        Nothing ->
                            sub == Print.url base.name

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


app : Ports Msg -> Program Value Model Msg
app ports =
    let
        ceChild : Component CraftEssences.Model CraftEssences.Msg
        ceChild =
            CraftEssences.component

        sChild : Component Servants.Model Servants.Msg
        sChild =
            Servants.component << Ports.map ports ServantsMsg <| \a ->
                 case a of
                    ServantsMsg x -> x
                    _             -> DoNothing

        init : Value -> Url -> Navigation.Key -> (Model, Cmd Msg)
        init val url key =
            let
                (error, flags) =
                    case D.decodeValue Flags.decode val of
                        Ok ok ->
                            (Nothing, ok)

                        Err err ->
                            ( Just <| D.errorToString err
                            , { today       = 0
                                                  |> Time.millisToPosix
                                                  >> Date.today
                              , preferences = Preferences.empty
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


                cmds =
                    [ ports.title newTitle
                    , ports.export "servants" <|
                      E.list Export.servant Servants.db
                    , ports.export "craftEssences" <|
                      E.list Export.craftEssence CraftEssences.db
                    ]
            in
            (st, Cmd.batch cmds)

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
                    Preferences.set k v st.prefs

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
              [ Flags.storePreferences ports.store prefs
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
                ( newSt
                , Cmd.batch
                  [ports.analytics path, ports.title newTitle, resetPopup]
                )

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
    Browser.application
    { init          = init
    , view          = view
    , update        = update
    , subscriptions = always <| Sub.batch
                      [ ports.receiveCompress <| ServantsMsg << ReceiveCompress
                      , ports.receiveDecompress <| ServantsMsg << ReceiveDecompress
                      ]
    , onUrlRequest  = RequestUrl
    , onUrlChange   = ChangeUrl
    }
