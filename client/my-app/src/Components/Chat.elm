module Components.Chat exposing (init, Model, update, view, Msg)

import Html exposing (Html, text, div, h1, img, a, input, label, section, p, span)
import Html.Attributes exposing (class, href, src, style, placeholder, attribute, id, name, type_, for)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( fl
        , w_60
        , bg_light_blue
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
        , ml1
        , bg_green
        , bg_blue
        , white_60
        , overflow_auto
        )


---- MODEL ----


type alias Model =
    {}


init : Model
init =
    ({})



---- UPDATE ----


type Msg
    = ChatMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


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
        [ displayTabs
        , displayConversation
        , displayFieldAndButtons
        ]


displayTabs : Html Msg
displayTabs =
    div
        [ class "tabs-main" ]
        [ input [ attribute "checked" "", id "tab1", name "tabs", type_ "radio" ]
            []
        , label [ for "tab1" ]
            [ text "Client 1" ]
        , input [ id "tab2", name "tabs", type_ "radio" ]
            []
        , label [ for "tab2" ]
            [ text "Client 2" ]
        , input [ id "tab3", name "tabs", type_ "radio" ]
            []
        , label [ for "tab3" ]
            [ text "Client 3" ]
        , input [ id "tab4", name "tabs", type_ "radio" ]
            []
        , label [ for "tab4" ]
            [ text "Client 4" ]
        ]


displayConversation : Html Msg
displayConversation =
    div
        [ classes
            [ fl
            , w_100
            , outline
            , overflow_auto
            ]
        , class "chat_panel"
        , id "style-7"
        ]
        [ --  section [ id "content1" ]
          --     [ p []
          --         [ text "1" ]
          --     ]
          -- , section [ id "content2" ]
          --     [ p []
          --         [ text "2" ]
          --     ]
          -- , section [ id "content3" ]
          --     [ p []
          --         [ text "3" ]
          --     ]
          -- , section [ id "content4" ]
          --     [ p []
          --         [ text "4" ]
          --     ]
          div
            [ classes [ br3, bg_green, white ], class "container l_msg_margin" ]
            [ p []
                [ text "Hello. How are you today?" ]
            , span [ classes [ white_60 ], class "time-left" ]
                [ text "11:00" ]
            ]
        , div [ classes [ br3, bg_blue, white ], class "container r_msg_margin" ]
            [ p [ class "text-right" ]
                [ text "Hey! I'm fine. Thanks for asking!" ]
            , span [ classes [ white_60 ], class "time-right" ]
                [ text "11:01" ]
            ]
        , div
            [ classes [ br3, bg_green, white ], class "container l_msg_margin" ]
            [ p []
                [ text "Want to see the Elm presentation today ?" ]
            , span [ classes [ white_60 ], class "time-left" ]
                [ text "11:02" ]
            ]
        , div
            [ classes [ br3, bg_green, white ], class "container l_msg_margin" ]
            [ p []
                [ text "At 4:00 PM ?" ]
            , span [ classes [ white_60 ], class "time-left" ]
                [ text "11:02" ]
            ]
        , div
            [ classes [ br3, bg_blue, white ], class "container r_msg_margin" ]
            [ p [ class "text-right" ]
                [ text "Sure, I love Elm !" ]
            , span [ classes [ white_60 ], class "time-right" ]
                [ text "11:04" ]
            ]
        , div
            [ classes [ br3, bg_blue, white ], class "container r_msg_margin" ]
            [ p [ class "text-right" ]
                [ text "VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ..." ]
            , span [ classes [ white_60 ], class "time-right" ]
                [ text "11:10" ]
            ]
        , div
            [ classes [ br3, bg_blue, white ], class "container r_msg_margin" ]
            [ p [ class "text-right" ]
                [ text "VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ...VERY LONG MESSAGE ..." ]
            , span [ classes [ white_60 ], class "time-right" ]
                [ text "11:10" ]
            ]
        ]


displayFieldAndButtons : Html Msg
displayFieldAndButtons =
    div [ classes [ w_100 ], class "discussion_field_and_buttons" ]
        [ input [ classes [ w_75, f6, br3, ph3, pv2, dib, black, bg_white, ml5 ], placeholder "Type Here", class "input_chat" ] []
        , a [ classes [ f6, link, br3, pv2, dib, dim, ml1 ], class "buttons", href "#" ] [ img [ src "Assets/img/lock.png", class "img_lock" ] [] ]
        ]



---- PROGRAM ----
