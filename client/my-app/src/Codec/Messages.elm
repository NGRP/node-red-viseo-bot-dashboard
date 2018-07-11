module Codec.Messages exposing (init, Model, update, Msg, Tab)

import Result exposing (Result)
import Json.Decode as Decode
import Codec.ConversationMsg as ConversationMsg exposing (ConversationMsg, decodeConversationMsg)
import Http
import Dict exposing (Dict, get)


type alias Model =
    { tabs : Dict String Tab }


type alias Tab =
    { conv_id : String
    , conversationMsgs : List ConversationMsg
    }


type Msg
    = OnTabsFetched (Result Http.Error (List Tab))


getTabsRequest =
    Http.get "http://localhost:3001/api/conversations" getTabsDecoder


getConversationMessagesDecoder : Decode.Decoder (List ConversationMsg)
getConversationMessagesDecoder =
    Decode.list
        (ConversationMsg.decodeConversationMsg)


getTabDecoder : Decode.Decoder Tab
getTabDecoder =
    Decode.map2 Tab
        (Decode.field "id" Decode.string)
        (Decode.field "messages"
            getConversationMessagesDecoder
        )


getTabsDecoder : Decode.Decoder (List Tab)
getTabsDecoder =
    Decode.list (getTabDecoder)


init : ( Model, Cmd Msg )
init =
    ( Model Dict.empty, Http.send OnTabsFetched getTabsRequest )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "debug msg" msg of
        OnTabsFetched (Err error) ->
            ( Model Dict.empty, Cmd.none )

        OnTabsFetched (Ok tabs) ->
            ( Model (Dict.fromList (List.map (\n -> ( n.conv_id, n )) tabs)), Cmd.none )
