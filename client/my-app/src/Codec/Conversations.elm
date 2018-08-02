module Codec.Conversations exposing (init, Model, update, Msg, Filtre(..), filterList)

import Result exposing (Result)
import Json.Decode as Decode
import Codec.ConversationHeader exposing (ConversationHeader, decodeConversationHeader, Status(..))
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


type Filtre
    = All
    | Alerte
    | SansAlerte
    | Suspended


filterList : Filtre -> List ConversationHeader -> List ConversationHeader
filterList filtre convs =
    case filtre of
        All ->
            convs

        Alerte ->
            List.filter (\n -> n.msg_status == Alert) convs

        SansAlerte ->
            -- contraire
            List.filter (\n -> n.msg_status /= Alert) convs

        Suspended ->
            -- handover non null -> Agent
            List.filter
                (\n ->
                    case n.handover of
                        Nothing ->
                            False

                        Just handover ->
                            True
                )
                convs


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
