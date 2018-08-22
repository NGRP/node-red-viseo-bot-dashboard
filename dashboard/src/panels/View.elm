module Panels.View exposing (..)

import Panels.Statistics as Statistics
import Panels.Chat as Chat


-- import Panels.ConversationList as ConversationList

import Panels.Header as Header
import Panels.ConversationsList as ConversationsList
import Model exposing (Msg, Model, Message)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( dt
        , fl
        , flex
        , flex_column
        , h_100
        , min_vh_100
        , vh_100
        , w_100
        , w_40
        , debug_grid
        , debug
        )


view : Model -> Html Msg
view model =
    div
        [ classes
            [ vh_100
            , dt
            , min_vh_100
            , flex
            , debug
            , debug_grid
            ]
        ]
        [ tachyons.css
        , div
            [ classes
                [ w_100
                , h_100
                ]
            ]
            [ Header.view
            , displayLeftPanel model
            , Chat.view model
            ]
        ]


displayLeftPanel : Model -> Html Msg
displayLeftPanel model =
    div
        [ classes
            [ flex
            , flex_column
            , fl
            , w_40
            ]
        , class "main_leftPanel"
        ]
        [ Statistics.view
        , ConversationsList.view model
        ]
