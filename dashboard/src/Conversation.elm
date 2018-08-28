module Conversation exposing (..)

import Http
import Model exposing (Conversation, MsgType(..), Status(..), Filter(..), Handler(..), ConversationWithMessages, Message, UserTalking(..), MsgContent(..), MsgState(..), ApplicationConversation(..), WebSocketEvent(..), Msg(..))
import Json.Decode as Decode
import Json.Decode.Pipeline as DecodePipeline
import Json.Encode
import Date
import Task
import Time


--
-- postMessage : String -> Message -> Http.Request Message
-- postMessage convId message =
--     Http.post ("http://localhost:3001/api/conversations/" ++ convId) Http.emptyBody message


getConversationsRequest : Http.Request (List Conversation)
getConversationsRequest =
    Http.get "http://localhost:3001/api/conversations" getConversationsListDecoder


getConversationWithMessagesRequest : Conversation -> Http.Request ConversationWithMessages
getConversationWithMessagesRequest conversation =
    Http.get ("http://localhost:3001/api/conversations/" ++ conversation.id)
        (getConversationMessagesDecoder
            |> Decode.map (\messages -> ConversationWithMessages conversation messages)
        )


getConversationsListDecoder : Decode.Decoder (List Conversation)
getConversationsListDecoder =
    Decode.list
        (decodeConversation)


dateDecoder : Decode.Decoder Date.Date
dateDecoder =
    let
        convert : String -> Decode.Decoder Date.Date
        convert raw =
            case Date.fromString raw of
                Ok date ->
                    Decode.succeed date

                Err error ->
                    Decode.fail error
    in
        Decode.string |> Decode.andThen convert


statusDecoder : Decode.Decoder Status
statusDecoder =
    Decode.int
        |> Decode.andThen
            (\msg_status ->
                if (msg_status <= 9) && (0 <= msg_status) then
                    Decode.succeed (defineStatus msg_status)
                else
                    Decode.fail "The msg_status has an incorrect value"
            )


defineStatus : Int -> Status
defineStatus msg_status =
    if msg_status <= 3 then
        Good
    else if msg_status <= 6 then
        Warning
    else
        Alert


handoverDecoder : Decode.Decoder Handler
handoverDecoder =
    Decode.maybe Decode.string
        |> Decode.map
            (\handoverMaybe ->
                case handoverMaybe of
                    Nothing ->
                        BotHandler

                    Just idAgent ->
                        (IdAgent idAgent)
            )


webSocketEventDecoder : Decode.Decoder WebSocketEvent
webSocketEventDecoder =
    Decode.oneOf [ newMessageDecoder, handoverUpdateDecoder ]


newMessageDecoder : Decode.Decoder WebSocketEvent
newMessageDecoder =
    Decode.map2
        NewMessage
        (Decode.at [ "message", "payload", "conv_id" ] Decode.string)
        (Decode.at [ "message", "payload" ] decodeMessage)


handoverUpdateDecoder : Decode.Decoder WebSocketEvent
handoverUpdateDecoder =
    Decode.map
        HandoverUpdate
        (Decode.at [ "message", "payload" ] decodeConversation)


userTalkingDecoder : Decode.Decoder UserTalking
userTalkingDecoder =
    Decode.string
        |> Decode.andThen
            (\userTalking ->
                case userTalking of
                    "BOT" ->
                        Decode.succeed Bot

                    "USER" ->
                        Decode.succeed User

                    "AGENT" ->
                        Decode.succeed Agent

                    _ ->
                        Decode.fail "Unknown User Talking"
            )


msgContentDecoder : Decode.Decoder MsgContent
msgContentDecoder =
    Decode.map2
        (\msgType content ->
            case msgType of
                StartConvType ->
                    StartConv

                EndConvType ->
                    EndConv

                SwitchLockType ->
                    SwitchLock

                MsgTxtType ->
                    MsgTxt content
        )
        (Decode.field "msg_type" msgTypeDecoder)
        (Decode.field "msg_content" Decode.string)


msgTypeDecoder : Decode.Decoder MsgType
msgTypeDecoder =
    Decode.string
        |> Decode.andThen
            (\msgType ->
                case msgType of
                    "START_CONV" ->
                        Decode.succeed StartConvType

                    "END_CONV" ->
                        Decode.succeed EndConvType

                    "MSG_TEXT" ->
                        Decode.succeed MsgTxtType

                    "MSG_QUICK" ->
                        Decode.succeed MsgTxtType

                    "MSG_HANDLER_STATE" ->
                        Decode.succeed SwitchLockType

                    _ ->
                        Decode.fail "Unknown message type"
            )


decodeConversation : Decode.Decoder Conversation
decodeConversation =
    DecodePipeline.decode Conversation
        |> DecodePipeline.required "id" (Decode.string)
        |> DecodePipeline.required "last_msg_date" dateDecoder
        |> DecodePipeline.required "user_id" (Decode.string)
        |> DecodePipeline.required "user_name" (Decode.string)
        |> DecodePipeline.required "msg_status" statusDecoder
        |> DecodePipeline.required "handover" handoverDecoder


getConversationMessagesDecoder : Decode.Decoder (List Message)
getConversationMessagesDecoder =
    Decode.field "messages" (Decode.list decodeMessage)


decodeMessage : Decode.Decoder Message
decodeMessage =
    DecodePipeline.decode Message
        |> DecodePipeline.required "date" dateDecoder
        |> DecodePipeline.required "user_id" (Decode.string)
        |> DecodePipeline.required "user_name" (Decode.string)
        |> DecodePipeline.required "msg_status" statusDecoder
        |> DecodePipeline.required "user_talking" userTalkingDecoder
        |> DecodePipeline.custom msgContentDecoder
        |> DecodePipeline.hardcoded Received


encodeMessage : Message -> String -> Json.Encode.Value
encodeMessage record convId =
    Json.Encode.object
        [ ( "date", Json.Encode.string <| encodeDate )
        , ( "conv_id", Json.Encode.string <| convId )
        , ( "user_id", Json.Encode.string <| record.userId )
        , ( "user_name", Json.Encode.string <| record.userName )
        , ( "msg_status", Json.Encode.int <| 0 )
        , ( "user_talking", Json.Encode.string <| "AGENT" )
        , ( "msg_type", Json.Encode.string <| "MSG_TEXT" )
        , ( "msg_content", Json.Encode.string <| encodeMsgContent record.msgContent )
        ]



-- pas de paramètres à encodeDate puisqu'il ressort la date du moment présent


encodeDate =
    Time.now
        |> Task.perform OnTime


encodeMsgContent : MsgContent -> String
encodeMsgContent msgContent =
    case msgContent of
        StartConv ->
            ""

        EndConv ->
            ""

        SwitchLock ->
            ""

        MsgTxt string ->
            string


encodeConversation : Message -> String -> Json.Encode.Value
encodeConversation record convId =
    Json.Encode.object
        [ ( "id", Json.Encode.string <| record.userId )
        , ( "last_msg_date", Json.Encode.string <| encodeDate )
        , ( "user_name", Json.Encode.string <| record.userName )
        , ( "msg_status", Json.Encode.int <| 0 )
        , ( "user_talking", Json.Encode.string <| "AGENT" )
        , ( "msg_type", Json.Encode.string <| "MSG_TEXT" )
        , ( "msg_content", Json.Encode.string <| encodeMsgContent record.msgContent )
        ]


toConversationWithMessages : ApplicationConversation -> ConversationWithMessages
toConversationWithMessages appConversation =
    case appConversation of
        Focus conversationWithMessages ->
            conversationWithMessages

        Open conversationWithMessages ->
            conversationWithMessages

        Close conversation ->
            ConversationWithMessages conversation []


toConversation : ApplicationConversation -> Conversation
toConversation appConversation =
    case appConversation of
        Focus conversationWithMessages ->
            conversationWithMessages.conversation

        Open conversationWithMessages ->
            conversationWithMessages.conversation

        Close conversation ->
            conversation
