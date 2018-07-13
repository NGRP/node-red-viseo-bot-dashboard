module Codec.Conversations exposing (init, Model, update, Msg)

import Result exposing (Result)
import Json.Decode as Decode
import Codec.ConversationHeader exposing (ConversationHeader, decodeConversationHeader)
import Http


type alias Model =
    { conversations : List ConversationHeader }



-- type User_talking
--     = BOT
--     | USER
--     | AGENT
--
--
-- type Msg_type
--     = START_CONV
--     | END_CONV
--     | MSG_TEXT
--     | MSG_QUICK


type Msg
    = OnConversationsFetched (Result Http.Error (List ConversationHeader))


getConversationsRequest : Http.Request (List ConversationHeader)
getConversationsRequest =
    Http.get "http://localhost:3001/api/conversations" getConversationsListDecoder


getConversationsListDecoder : Decode.Decoder (List ConversationHeader)
getConversationsListDecoder =
    Decode.list
        (decodeConversationHeader)


init : ( Model, Cmd Msg )
init =
    ( Model [], Http.send OnConversationsFetched getConversationsRequest )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnConversationsFetched (Err error) ->
            ( Model [], Cmd.none )

        OnConversationsFetched (Ok conversations) ->
            ( Model conversations, Cmd.none )
