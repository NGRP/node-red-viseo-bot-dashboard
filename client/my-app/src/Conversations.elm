module Conversations exposing (init, Model, update, Msg)

import Result exposing (Result)
import Json.Decode as Decode
import Codec.ConversationHeader exposing (ConversationHeader, decodeConversationHeader)


-- import Date
-- import ISO8601

import Http


type alias Model =
    { conversations : List ConversationHeader }


type alias Message =
    { date : String
    , conv_id : String
    , user_id : String
    , user_name : String
    , msg_status : Int
    , user_talking : String
    , msg_type : String
    , msg_content : String
    }


type User_talking
    = BOT
    | USER
    | AGENT


type Msg_type
    = START_CONV
    | END_CONV
    | MSG_TEXT
    | MSG_QUICK


type Msg
    = OnConversationsFetched (Result Http.Error (List ConversationHeader))


getConversationsRequest : Http.Request (List ConversationHeader)
getConversationsRequest =
    Http.get "http://localhost:3001/api/conversations" getConversationsListDecoder



-- ./../../../server/mocks/conversations.mocks.json
--


getConversationsListDecoder : Decode.Decoder (List ConversationHeader)
getConversationsListDecoder =
    Decode.list
        (decodeConversationHeader)



-- getMessageDecoder : Decode.Decoder Message
-- getMessageDecoder =
--     (Decode.map8
--         Message
--         (Decode.field "date" Decode.string)
--         (Decode.field "conv_id" Decode.string)
--         (Decode.field "user_id" Decode.string)
--         (Decode.field "user_name" Decode.string)
--         (Decode.field "msg_status" Decode.int)
--         (Decode.field "user_talking" Decode.string)
--         (Decode.field "msg_type" Decode.string)
--         (Decode.field "msg_content" Decode.string)
--     )


init : ( Model, Cmd Msg )
init =
    ( Model [], Http.send OnConversationsFetched getConversationsRequest )



-- initialModel : Model
-- initialModel =
--     let
--         conversations =
--             OnConversationsFetched getConversationsRequest
--     in
--         (Model conversations)
--
--
-- init : Model
-- init =
--     initialModel
--updated
-- update : Msg -> Model
-- update msg =
--     case msg of
--         OnConversationsFetched (Err error) ->
--             Model []
--
--         OnConversationsFetched (Ok conversations) ->
--             Model conversations


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "debug msg" msg of
        OnConversationsFetched (Err error) ->
            ( Model [], Cmd.none )

        OnConversationsFetched (Ok conversations) ->
            ( Model conversations, Cmd.none )



-- view
