module Model exposing (UserTalking(..), MsgType(..), Handler(..), Status(..), MsgContent(..), MsgState(..), Model, Msg(..), Conversation, Message, Filter(..), ConversationWithMessages, ApplicationConversation(..))

import Date
import Http


type alias Model =
    { conversations : List ApplicationConversation
    , currentFilter : Filter
    }


type UserTalking
    = Bot
    | User
    | Agent


type Handler
    = BotHandler
    | IdAgent String


type Status
    = Good
    | Warning
    | Alert


type MsgContent
    = StartConv
    | EndConv
    | MsgTxt String



-- MsgTxt correspond à MSG_TEXT et MSG_QUICK


type MsgType
    = StartConvType
    | EndConvType
    | MsgTxtType


type MsgState
    = Sending
    | Sent
    | Received
    | TransmissionFailed


type ApplicationConversation
    = Open ConversationWithMessages
    | Close Conversation
    | Focus ConversationWithMessages


type Filter
    = All
    | Alerte
    | SansAlerte
    | Suspended


type Msg
    = OnMessagesFetched (Result Http.Error ConversationWithMessages)
    | FocusTab String
    | DeleteTab String
    | OnConversationsFetched (Result Http.Error (List Conversation))
    | OpenConversation Conversation
    | FilterConversation Filter
    | WebSocketTest String


type alias ConversationWithMessages =
    { conversation : Conversation
    , listMsg : List Message
    }


type alias Conversation =
    { id : String
    , lastMsgDate : Date.Date
    , userId : String
    , userName : String
    , msgStatus : Status
    , handover : Handler
    }



-- TODO : Vérifier avec Ari les msg_status (par conv ou par message ?) afficher le status du dernier msg ou de la conv via une moyenne ?
-- TODO : id du bot ? Plusieurs bot différents ? = 1 bot
-- TODO : MSG QUICK = msg + bouton
-- MSG STATUS de la conv = msg_status du dernier message, peut aller jusqu'à l'infini
-- ws dans le Main
-- conversationSelected dans le main ou module conversation
-- garder la position du filtre dans le panel (ListConversation)


type alias Message =
    { date : Date.Date
    , userId : String
    , userName : String
    , msgStatus : Status
    , userTalking : UserTalking
    , msgContent : MsgContent
    , msgState : MsgState
    }
