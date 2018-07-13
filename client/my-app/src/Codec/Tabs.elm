module Codec.Tabs exposing (init, Model, update, Msg, Tab)

import Result exposing (Result)
import Json.Decode as Decode
import Codec.ConversationMsg as ConversationMsg exposing (ConversationMsg, decodeConversationMsg, getConversationMessagesDecoder)
import Http
import Dict exposing (Dict, get, insert)


type alias Model =
    { tabs : Dict String Tab }


type alias Tab =
    { conv_id : String
    , conversationMsgs : List ConversationMsg.ConversationMsg
    }


type Msg
    = OnTabsFetched (Result Http.Error (List Tab))
    | OnTabFetched (Result Http.Error Tab)


getTabRequest string =
    Http.get ("http://localhost:3001/api/conversations/" ++ string) getTabDecoder


getTabDecoder : Decode.Decoder Tab
getTabDecoder =
    Decode.map2 Tab
        (Decode.field "id" Decode.string)
        (Decode.field "messages"
            ConversationMsg.getConversationMessagesDecoder
        )


init : ( Model, Cmd Msg )
init =
    ( Model Dict.empty, Http.send OnTabFetched (getTabRequest "54") )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "debug msg" msg of
        OnTabsFetched (Err error) ->
            ( Model Dict.empty, Cmd.none )

        OnTabsFetched (Ok tabs) ->
            ( Model (Dict.fromList (List.map (\n -> ( n.conv_id, n )) tabs)), Cmd.none )

        OnTabFetched (Err error) ->
            ( model, Cmd.none )

        OnTabFetched (Ok tab) ->
            let
                newTabs =
                    (Dict.insert tab.conv_id (Tab tab.conv_id tab.conversationMsgs) model.tabs)
            in
                ( Model newTabs, Cmd.none )
