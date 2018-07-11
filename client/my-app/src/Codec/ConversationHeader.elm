module Codec.ConversationHeader exposing (ConversationHeader, decodeConversationHeader, Status(..))

-- import Json.Encode

import Json.Decode


-- elm-package install -- yes noredink/elm-decode-pipeline

import Json.Decode.Pipeline exposing (decode, required, resolve)


type alias ConversationHeader =
    { id : String
    , last_msg_date : String
    , user_id : String
    , user_name : String
    , msg_status : Status
    , handover : Maybe String
    }


type Status
    = Ok
    | Warning
    | Alert


defineStatus : Int -> Status
defineStatus msg_status =
    if msg_status <= 3 then
        Ok
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
    let
        toDecoder : String -> String -> String -> String -> Int -> Maybe String -> Json.Decode.Decoder ConversationHeader
        toDecoder id last_msg_date user_id user_name msg_status handover =
            if (msg_status <= 9) && (0 <= msg_status) then
                Json.Decode.succeed (ConversationHeader id last_msg_date user_id user_name (defineStatus msg_status) handover)
            else
                Json.Decode.fail "The msg_status has an incorrect value"
    in
        decode toDecoder
            |> required "id" (Json.Decode.string)
            |> required "last_msg_date" (Json.Decode.string)
            |> required "user_id" (Json.Decode.string)
            |> required "user_name" (Json.Decode.string)
            |> required "msg_status" (Json.Decode.int)
            |> required "handover" (Json.Decode.maybe Json.Decode.string)
            |> resolve



--
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
