module Model exposing (..)

import Date


type alias Conversation =
    { id : String
    , last_msg_date : Date.Date
    , user_id : String
    , user_name : String
    , msg_status : Status
    , handover : Handler
    , messages : List Message
    }


type UserTalking
    = BOT
    | USER
    | AGENT


type Handler
    = Bot
    | IdAgent String


type Status
    = Good
    | Warning
    | Alert


type MsgContent
    = START_CONV
    | END_CONV
    | MSG_TEXT String
    | MSG_QUICK String


type MsgState
    = Sending
    | Sent
    | Received
    | TransmissionFailed



-- TODO : Vérifier avec Ari les msg_status (par conv ou par message ?) afficher la status du dernier msg ou de la conv via une moyenne ?
-- TODO : id du bot ? Plusieurs bot différents ?


type alias Message =
    { date : Date.Date
    , user_id : String
    , user_name : String
    , msg_status : Status
    , user_talking : UserTalking
    , msg_content : MsgContent
    , msg_state : MsgState
    }
