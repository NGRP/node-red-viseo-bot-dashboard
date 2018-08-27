module Panels.Chat exposing (..)

import Conversation exposing (toConversationWithMessages)
import Model exposing (Model, Msg(..), ApplicationConversation(..), Conversation, ConversationWithMessages, Message, MsgContent(..), Handler(..))
import Date
import Json.Decode as Decode
import Html exposing (Html, text, div, h1, img, a, input, label, section, p, span, ul, li)
import Html.Attributes exposing (class, href, src, style, placeholder, attribute, id, name, type_, for)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( fl
        , w_60
        , bg_light_blue
        , bg_mid_gray
        , outline
        , w_100
        , bg_white_80
        , w_70
        , f6
        , br3
        , ph3
        , pv2
        , dib
        , black
        , bg_white
        , f6
        , link
        , dim
        , white
        , bg_dark_blue
        , w_10
        , center
        , flex
        , flex_column
        , w_75
        , ml5
        , ml2
        , bg_green
        , bg_blue
        , white_60
        , overflow_auto
        , list
        , tj
        , f5
        , fl
        , mt2
        , mb1
        , pa2
        , input_reset
        , f7
        , mb0
        , mv1
        , ph3
        , mt2
        , mt1
        , b__dark_red
        , br4
        , ba
        , ml3
        , pv3
        , pointer
        , ph4
        , ph0
        , ml3
        , mt0
        , pt1
        )
import Html.Events exposing (onClick, onDoubleClick, onWithOptions)
import List.Extra


type FocusState
    = Focused
    | NotFocused


view : Model -> Html Msg
view model =
    div
        [ classes
            [ fl
            , w_60
            , outline
            , flex
            , flex_column
            ]
        , class "chat_conv"
        ]
        [ displayTabs model
        , displayConversation model
        , displayFieldAndButtons model
        ]


displayTabs : Model -> Html Msg
displayTabs model =
    ul
        [ classes
            [ fl
            , flex
            , mb0
            , list
            , ph0
            , mt0
            ]
        , class "tabs-main"
        ]
        (List.filterMap displayAppConversationTab model.conversations)


displayAppConversationTab : ApplicationConversation -> Maybe (Html Msg)
displayAppConversationTab appConversation =
    case appConversation of
        Close conversation ->
            Nothing

        Open conversationWithMessages ->
            displayTab conversationWithMessages.conversation NotFocused |> Just

        Focus conversationWithMessages ->
            displayTab conversationWithMessages.conversation Focused |> Just


displayTab : Conversation -> FocusState -> Html Msg
displayTab conversation focusState =
    let
        activeClass =
            if focusState == Focused then
                " active"
            else
                ""
    in
        li
            [ id ("tab" ++ conversation.id)
            , class ("tab" ++ activeClass)
            , onClick (FocusConversation conversation)
            , classes [ ph4, pt1 ]
            ]
            [ text ("User " ++ conversation.id)
            , span [ classes [ mv1, dim ], onClickStopPropagation (CloseConversation conversation) ] [ img [ src "./Assets/img/cancel.png", class "cross" ] [] ]
            ]


onClickStopPropagation : Msg -> Html.Attribute Msg
onClickStopPropagation msg =
    onWithOptions "click" { stopPropagation = True, preventDefault = True } (Decode.succeed msg)


displayConversation : Model -> Html Msg
displayConversation model =
    let
        maybeConversationWithMessages =
            getFocusedConversation model.conversations
    in
        case maybeConversationWithMessages of
            Nothing ->
                div [ class "chat_conv" ] [ text "No messages displayed" ]

            Just conversationWithMessages ->
                div
                    [ classes
                        [ fl
                        , w_100
                        , outline
                        , overflow_auto
                        ]
                    , class "chat_panel"
                    , class "style-7"
                    ]
                    [ displayMessages conversationWithMessages.listMsg ]


getFocusedConversation : List ApplicationConversation -> Maybe ConversationWithMessages
getFocusedConversation conversations =
    List.Extra.find
        (\conversation ->
            case conversation of
                Focus conversationWithMessages ->
                    True

                _ ->
                    False
        )
        conversations
        |> Maybe.map toConversationWithMessages


displayMessages : List Message -> Html Msg
displayMessages msgList =
    div []
        [ ul
            []
            (List.filterMap filterMessageType msgList
                |> List.map (\( message, content ) -> displayMessage message content)
            )
        ]


filterMessageType : Message -> Maybe ( Message, String )
filterMessageType message =
    case message.msgContent of
        StartConv ->
            Nothing

        EndConv ->
            Nothing

        SwitchLockState ->
            Nothing

        MsgTxt content ->
            Just ( message, content )


displayMessage : Message -> String -> Html Msg
displayMessage message content =
    li
        [ classes [ br3, list, flex, flex_column ] ]
        [ div [] [ span [ classes [ black, f6 ], class "nameUser" ] [ text message.userName ] ]
        , p [ classes [ br3, tj, f5, mt2, mb1, pa2 ], class "container l_msg_margin msg_user" ]
            [ text content ]
        , div []
            [ span [ classes [ black, f7, fl ], class "time-left" ]
                [ text (dateFormat message.date) ]
            ]
        ]


dateFormat : Date.Date -> String
dateFormat date =
    (toString (Date.hour date)) ++ ":" ++ (toString (Date.minute date))


displayFieldAndButtons : Model -> Html Msg
displayFieldAndButtons model =
    let
        maybeConversationWithMessages =
            (getFocusedConversation model.conversations)
    in
        case maybeConversationWithMessages of
            Nothing ->
                div [] []

            Just conversationWithMessages ->
                div [ classes [ w_100 ], class "discussion_field_and_buttons" ]
                    [ input [ classes [ f6, br3, ph3, pv2, dib, black ], placeholder "Type Here", class (classNameInput conversationWithMessages.conversation), Html.Attributes.disabled (setBool conversationWithMessages.conversation) ] []
                    , a [ classes [ br3, pv2, dib, dim, ml2, pointer, ml3 ], class "buttons" ] [ img [ src "./Assets/img/send-button.png", class "img_lock" ] [] ]
                    , displayImageLock (conversationWithMessages.conversation)
                    ]


classNameInput : Conversation -> String
classNameInput conversation =
    case conversation.handover of
        BotHandler ->
            "input_chat_lock"

        IdAgent string ->
            "input_chat_unlock"


setBool : Conversation -> Bool
setBool conversation =
    case conversation.handover of
        BotHandler ->
            True

        IdAgent string ->
            False


displayImageLock : Conversation -> Html Msg
displayImageLock conversation =
    case conversation.handover of
        BotHandler ->
            div []
                [ a [ classes [ br3, pv2, dib, dim, ml2, pointer, ml3 ], class "buttons", onClick (SwitchLockState conversation) ] [ img [ src "./Assets/img/lock.png", class "img_lock" ] [] ]
                ]

        IdAgent string ->
            a [ classes [ br3, pv2, dib, dim, ml2, pointer, ml3 ], class "buttons", onClick (SwitchLockState conversation) ] [ img [ src "./Assets/img/open-lock.png", class "img_lock" ] [] ]
