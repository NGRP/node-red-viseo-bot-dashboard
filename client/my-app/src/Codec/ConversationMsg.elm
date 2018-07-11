module Codec.ConversationMsg exposing (ConversationMsg, decodeConversationMsg, getConversationMessagesDecoder)

import Json.Encode
import Json.Decode


-- elm-package install -- yes noredink/elm-decode-pipeline

import Json.Decode.Pipeline


type alias ConversationMsg =
    { date : String
    , conv_id : String
    , user_id : String
    , user_name : String
    , msg_status : Int
    , user_talking : String
    , msg_type : String
    , msg_content : String
    }


getConversationMessagesDecoder : Json.Decode.Decoder (List ConversationMsg)
getConversationMessagesDecoder =
    Json.Decode.list
        (decodeConversationMsg)


decodeConversationMsg : Json.Decode.Decoder ConversationMsg
decodeConversationMsg =
    Json.Decode.Pipeline.decode ConversationMsg
        |> Json.Decode.Pipeline.required "date" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "conv_id" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "user_id" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "user_name" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "msg_status" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "user_talking" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "msg_type" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "msg_content" (Json.Decode.string)


encodeConversationMsg : ConversationMsg -> Json.Encode.Value
encodeConversationMsg record =
    Json.Encode.object
        [ ( "date", Json.Encode.string <| record.date )
        , ( "conv_id", Json.Encode.string <| record.conv_id )
        , ( "user_id", Json.Encode.string <| record.user_id )
        , ( "user_name", Json.Encode.string <| record.user_name )
        , ( "msg_status", Json.Encode.int <| record.msg_status )
        , ( "user_talking", Json.Encode.string <| record.user_talking )
        , ( "msg_type", Json.Encode.string <| record.msg_type )
        , ( "msg_content", Json.Encode.string <| record.msg_content )
        ]
