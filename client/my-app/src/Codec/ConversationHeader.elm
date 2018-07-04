module Codec.ConversationHeader exposing (ConversationHeader, decodeConversationHeader)

import Json.Encode
import Json.Decode


-- elm-package install -- yes noredink/elm-decode-pipeline

import Json.Decode.Pipeline


type alias ConversationHeader =
    { id : String
    , last_msg_date : String
    , user_id : String
    , user_name : String
    , msg_status : Int
    , handover : Maybe String
    }


decodeConversationHeader : Json.Decode.Decoder ConversationHeader
decodeConversationHeader =
    Json.Decode.Pipeline.decode ConversationHeader
        |> Json.Decode.Pipeline.required "id" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "last_msg_date" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "user_id" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "user_name" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "msg_status" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "handover"
            (Json.Decode.maybe Json.Decode.string)



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
