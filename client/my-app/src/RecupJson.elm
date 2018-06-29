module RecupJson exposing (init, Model, update, Msg)

import Result exposing (Result)
import Json.Decode as Decode
import Date
import ISO8601


type alias Model =
    { conversations : List Conversation }


type alias Conversation =
    { id : String
    , last_msg_date : String
    , user_id : String
    , user_name : String
    , msg_status : Int
    , handover : String
    , messages : List Message
    }


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
    = OnConversationsFetched (Result Http.Error (List Conversation))


getConversationsRequest =
    Http.get "../../server/mocks/conversations.mocks.json" getConversationsListDecoder


getConversationsListDecoder : Decode.Decoder (List Conversation)
getConversationsListDecoder =
    Decode.list
        (getConversationDecoder)


getConversationDecoder =
    (Decode.map7
        Conversation
        (Decode.field "id" Decode.string)
        (Decode.field "last_msg_date" Decode.string)
        (Decode.field "user_id" Decode.string)
        (Decode.field "user_name" Decode.string)
        (Decode.field "msg_status" Decode.int)
        (Decode.field "handover" Decode.string)
        (Decode.field "messages" (Decode.list getMessageDecoder))
    )


getMessageDecoder =
    (Decode.map8
        Message
        (Decode.field "date" Decode.string)
        (Decode.field "conv_id" Decode.string)
        (Decode.field "user_id" Decode.string)
        (Decode.field "user_name" Decode.string)
        (Decode.field "msg_status" Decode.int)
        (Decode.field "user_talking" Decode.string)
        (Decode.field "msg_type" Decode.string)
        (Decode.field "msg_content" Decode.string)
    )


init : ( Model, Cmd Msg )
init =
    ( Model [], Http.send OnConversationsFetched getConversationsRequest )



--updated


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnConversationsFetched (Err error) ->
            ( Model [], Cmd.none )

        OnConversationsFetched (Ok conversations) ->
            ( Model conversations, Cmd.none )



-- view


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = always Sub.none
        }
