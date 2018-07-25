module Model exposing (..)

import Date


type UserTalking
    = Bot
    | User
    | Agent


type Handler
    = Bot
    | IdAgent String


type Status
    = Good
    | Warning
    | Alert


type MsgContent
    = StartConv
    | EndConv
    | MsgTxt String
    | MsgQuick String


type MsgState
    = Sending
    | Sent
    | Received
    | TransmissionFailed


type ApplicationConversation
    = Open Conversation
    | Close Conversation
    | Focus Conversation


type alias Conversation =
    { id : String
    , lastMsgDate : Date.Date
    , userId : String
    , userName : String
    , msgStatus : Status
    , handover : Handler
    , messages : List Message
    , tabStatus : ApplicationConversation
    }



-- TODO : Vérifier avec Ari les msg_status (par conv ou par message ?) afficher la status du dernier msg ou de la conv via une moyenne ?
-- TODO : id du bot ? Plusieurs bot différents ?
-- ws dans le Main
-- conversationSelected dans le main ou module conversation
-- garder la position du filtre dans le panel (ListConversation)
-- MSG QUICK


type alias Message =
    { date : Date.Date
    , userId : String
    , userName : String
    , msgStatus : Status
    , userTalking : UserTalking
    , msgContent : MsgContent
    , msgState : MsgState
    }
