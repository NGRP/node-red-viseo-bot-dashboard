module Codec.ConversationHeader exposing (ConversationHeader, decodeConversationHeader, Status(..))

-- import Json.Encode

import Json.Decode


-- import Date.Extra

import Date


-- elm-package install -- yes noredink/elm-decode-pipeline

import Json.Decode.Pipeline exposing (decode, required, resolve)


type alias ConversationHeader =
    { id : String
    , last_msg_date : Date.Date
    , user_id : String
    , user_name : String
    , msg_status : Status
    , handover : Maybe String
    }


type Status
    = Good
    | Warning
    | Alert


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



-- decodeConversationHeader : Json.Decode.Decoder ConversationHeader
-- decodeConversationHeader =
--     Json.Decode.Pipeline.decode ConversationHeader
--         |> Json.Decode.Pipeline.required "id" (Json.Decode.string)
--         |> Json.Decode.Pipeline.required "last_msg_date" (Json.Decode.string)
--         |> Json.Decode.Pipeline.required "user_id" (Json.Decode.string)
--         |> Json.Decode.Pipeline.required "user_name" (Json.Decode.string)
--         |> Json.Decode.Pipeline.required "msg_status" (Json.Decode.int)
--         |> Json.Decode.Pipeline.required "handover"
--             (Json.Decode.maybe Json.Decode.string)


decodeConversationHeader : Json.Decode.Decoder ConversationHeader
decodeConversationHeader =
    decode ConversationHeader
        |> required "id" (Json.Decode.string)
        |> required "last_msg_date" dateDecoder
        |> required "user_id" (Json.Decode.string)
        |> required "user_name" (Json.Decode.string)
        |> required "msg_status" statusDecoder
        |> required "handover" (Json.Decode.maybe Json.Decode.string)



-- encodeConversationHeader : ConversationHeader -> Json.Encode.Value
-- encodeConversationHeader record =
--     Json.Encode.object
--         [ ( "id", Json.Encode.string <| record.id )
--         , ( "last_msg_date", Json.Encode.string <| record.last_msg_date )
--         , ( "user_id", Json.Encode.string <| record.user_id )
--         , ( "user_name", Json.Encode.string <| record.user_name )
--         , ( "msg_status", Json.Encode.int <| record.msg_status )
--         , ( "handover", Json.Encode.maybe <| Json.Encode.string <| record.handover )
--         ]
--
--
