module Panels.Chat exposing (..)

import Conversation exposing (toConversationWithMessages)
import Model exposing (Model, Msg(..), ApplicationConversation(..), Conversation, ConversationWithMessages, Message, MsgContent(..))
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
        )
import Html.Events exposing (onClick, onDoubleClick)
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
        , displayFieldAndButtons
        ]


displayTabs : Model -> Html Msg
displayTabs model =
    div
        [ class "tabs-main" ]
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
    div
        [ classes
            [ fl
            , flex
            , mb0
            ]
        ]
        [ input [ id ("tab" ++ conversation.id), name "tabs", type_ "radio", onClick (FocusConversation conversation) ]
            []
        , div [ onClick (CloseConversation conversation) ] [ text "X" ]
        , label [ for ("tab" ++ conversation.id) ] [ text ("User " ++ conversation.id) ]
        ]


displayConversation : Model -> Html Msg
displayConversation model =
    let
        maybeConversationWithMessages =
            (getFocusedConversation model.conversations)
    in
        case maybeConversationWithMessages of
            Nothing ->
                div [] [ text "No messages displayed" ]

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
                [ text "11:00" ]
            ]
        ]


displayFieldAndButtons : Html Msg
displayFieldAndButtons =
    div [ classes [ w_100 ], class "discussion_field_and_buttons" ]
        [ input [ classes [ w_75, f6, br3, ph3, pv2, dib, black, bg_white ], placeholder "Type Here", class "input_chat" ] []
        , a [ classes [ br3, pv2, dib, dim, ml2 ], class "buttons", href "#" ] [ img [ src "./Assets/img/lock.png", class "img_lock" ] [] ]
        ]
