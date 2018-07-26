module Panels.ConversationsList exposing (..)

import Tachyons exposing (classes, tachyons)
import Date
import Html.Events exposing (onClick)
import Html.Events exposing (onDoubleClick)
import Html exposing (Html, a, div, h1, img, li, nav, text, ul)
import Html.Attributes exposing (class, href, src, style)
import Model exposing (Msg, Model, Message)
import String.Extra as Str
import Tachyons.Classes
    exposing
        ( b__dark_blue
        , ba
        , bb
        , bg_green
        , bg_near_black
        , br2
        , br_pill
        , center
        , dib
        , f4
        , f5
        , flex
        , flex_column
        , flex_nowrap
        , flex_row
        , fr
        , fw4
        , h_100
        , justify_between
        , justify_center
        , lh_title
        , link
        , list
        , mb2
        , mh3
        , mh4
        , mh5
        , ml0
        , mr3
        , mr4
        , mt0
        , mw6
        , no_underline
        , outline
        , overflow_auto
        , overflow_container
        , pa2
        , pa4
        , ph3
        , pl0
        , pt3
        , pv1
        , pv2
        , pv3
        , ph5
        , w_100
        , w_25
        , white
        )
import Model exposing (Status(..), Filter(..), Msg(..), Conversation, Handler(..))
import Conversation exposing (toConversation)


filterList : Filter -> List Conversation -> List Conversation
filterList filtre convs =
    case filtre of
        All ->
            convs

        Alerte ->
            List.filter (\n -> n.msgStatus == Alert) convs

        SansAlerte ->
            -- contraire
            List.filter (\n -> n.msgStatus /= Alert) convs

        Suspended ->
            -- handover non null -> Agent
            List.filter
                (\n ->
                    case n.handover of
                        BotHandler ->
                            False

                        IdAgent handover ->
                            True
                )
                convs


view : Model -> Html Msg
view model =
    div
        [ classes
            [ outline
            , w_100
            ]
        , class "listconv_list"
        ]
        [ displayNav model
        ]


displayNav : Model -> Html Msg
displayNav model =
    nav
        [ classes
            [ w_100
            ]
        ]
        [ displayWhiteSpace
        , displayList model
        ]


displayWhiteSpace : Html Msg
displayWhiteSpace =
    div
        [ classes
            []
        , class "listconv_whitespace"
        ]
        [ displayNavHeader
        , displayFilters
        ]


displayNavHeader : Html Msg
displayNavHeader =
    h1
        [ classes
            [ fw4
            , f4
            , mt0
            , pt3
            ]
        , class "conversation"
        ]
        [ text "CONVERSATIONS" ]


displayFiltersClass : String -> String -> Filter -> Html Msg
displayFiltersClass txt class_name filtre =
    a
        [ classes
            [ f5
            , link
            , br_pill
            , ph3
            , pv2
            , mb2
            , dib
            , white
            , mr3
            ]
        , href "#"
        , class class_name
        , onClick (FilterConversation filtre)
        ]
        [ text txt ]


displayFilters : Html Msg
displayFilters =
    div
        [ classes
            [ flex
            , ph5
            ]
        ]
        [ displayFiltersClass "Tous" "all_btn" All
        , displayFiltersClass "avec alerte" "push_btn" Alerte
        , displayFiltersClass "sans alerte" "push_btn" SansAlerte
        , displayFiltersClass "Suspendu" "suspended_btn" Suspended
        ]


displayList : Model -> Html Msg
displayList model =
    let
        conversations =
            (List.map toConversation model.conversations)
                |> List.map .conversation
                |> filterList model.currentFilter
                |> List.sortBy (\conversation -> Date.toTime conversation.lastMsgDate)
    in
        div
            [ classes
                [ flex_nowrap
                ]
            ]
            [ ul
                [ classes
                    [ list
                    , pl0
                    , center
                    , ba
                    , b__dark_blue
                    , br2
                    , overflow_auto
                    ]
                , class "listconv_listHeight"
                , class "style-7"
                ]
                (List.map displayLine conversations)
            ]


displayLine : Model.Conversation -> Html Msg
displayLine conversation =
    li
        [ classes
            [ bb
            ]
        , class "list-style"
        , onClick (OpenConversation conversation)
        ]
        [ a
            [ classes
                [ no_underline
                , link
                , flex
                , justify_between
                ]
            , class "link_list"
            , href "#"
            ]
            [ div
                [ class (colorStatusString conversation)
                ]
                []
            , div
                [ classes
                    [ pv3
                    ]
                , class "user_name"
                ]
                [ text conversation.userName ]
            , div
                [ classes
                    [ pv3 ]
                , class "date"
                ]
                [ text (Str.leftOfBack ":" (Str.rightOf "<" (toString conversation.lastMsgDate))) ]
            , div
                [ classes
                    [ w_25
                    ]
                ]
                [ displayHandover conversation.handover ]
            ]
        ]


displayHandover : Model.Handler -> Html Msg
displayHandover handoverMaybe =
    case handoverMaybe of
        BotHandler ->
            div
                [ classes
                    [ w_25
                    , pv1
                    , mr3
                    , fr
                    ]
                ]
                [ img [ src "./Assets/img/robot.png", class "img_bot" ] [] ]

        IdAgent handover ->
            div
                [ classes
                    [ pv1
                    , mr4
                    , fr
                    , pv3
                    ]
                ]
                [ text handover ]


colorStatusString : Model.Conversation -> String
colorStatusString conversation =
    case conversation.msgStatus of
        Good ->
            "lb"

        Warning ->
            "lp"

        Alert ->
            "lr"
