module Model exposing (UserTalking(..), MsgType(..), Handler(..), Status(..), MsgContent(..), MsgState(..), Model, Msg(..), Conversation, Message, Filter(..), ConversationWithMessages, ApplicationConversation(..), WebSocketEvent(..))

import Date
import Http


-- DOM.scroll elm pour conversation en bas du chat


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
    | FocusConversation Conversation
    | CloseConversation Conversation
    | OnConversationsFetched (Result Http.Error (List Conversation))
    | OpenConversation Conversation
    | FilterConversation Filter
    | SwitchLockState Conversation
    | WebSocketMessage String
    | OnMessageSent Message


type WebSocketEvent
    = NewMessage String Message
    | HandoverUpdate Conversation


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


type alias Message =
    { date : Date.Date
    , userId : String
    , userName : String
    , msgStatus : Status
    , userTalking : UserTalking
    , msgContent : MsgContent
    , msgState : MsgState
    }
