module Conversation exposing (..)

import Model


type alias Model =
    {}


getConversationsRequest : Http.Request (List Conversation)
getConversationsRequest =
    Http.get "http://localhost:3001/api/conversations" getConversationsListDecoder
getTabRequest string =
    Http.get ("http://localhost:3001/api/conversations/" ++ string) getTabDecoder

getConversationsListDecoder : Decode.Decoder (List Conversation)
getConversationsListDecoder =
    Decode.list
        (decodeConversation)


dateDecoder : Json.Decode.Decoder Date.Date
dateDecoder =
    let
        convert : String -> Json.Decode.Decoder Date.Date
        convert raw =
            case Date.fromString raw of
                Ok date ->
                    Json.Decode.succeed date

                Err error ->
                    Json.Decode.fail error
    in
        Json.Decode.string |> Json.Decode.andThen convert


statusDecoder : Json.Decode.Decoder Status
statusDecoder =
    Json.Decode.int
        |> Json.Decode.andThen
            (\msg_status ->
                if (msg_status <= 9) && (0 <= msg_status) then
                    Json.Decode.succeed (defineStatus msg_status)
                else
                    Json.Decode.fail "The msg_status has an incorrect value"
            )


defineStatus : Int -> Status
defineStatus msg_status =
    if msg_status <= 3 then
        Good
    else if msg_status <= 6 then
        Warning
    else
        Alert


handoverDecoder : Maybe String -> Handler
handoverDecoder handover =
    case handover of
        Nothing ->
            Bot

        Just idAgent ->
            IdAgent idAgent


userTalkingDecoder : String -> UserTalking
userTalkingDecoder userTalking =
    case userTalking of
        "BOT" ->
            Bot

        "USER" ->
            User

        "AGENT" ->
            Agent


msgContentDecoder : String -> MsgContent
msgContentDecoder msgContent =



decodeConversation : Json.Decode.Decoder Conversation
decodeConversation =
    decode ConversationHeader
        |> required "id" (Json.Decode.string)
        |> required "last_msg_date" dateDecoder
        |> required "user_id" (Json.Decode.string)
        |> required "user_name" (Json.Decode.string)
        |> required "msg_status" statusDecoder
        |> required "handover" handoverDecoder



getConversationMessagesDecoder : Json.Decode.Decoder (List ConversationMsg)
getConversationMessagesDecoder =
    Json.Decode.list
        (decodeConversationMsg)


decodeConversationMsg : Json.Decode.Decoder ConversationMsg
decodeConversationMsg =
    Json.Decode.Pipeline.decode ConversationMsg
        |> Json.Decode.Pipeline.required "date" dateDecoder
        |> Json.Decode.Pipeline.required "user_id" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "user_name" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "msg_status" statusDecoder
        |> Json.Decode.Pipeline.required "user_talking" userTalkingDecoder
        |> Json.Decode.Pipeline.required "msg_content" msgContentDecoder
