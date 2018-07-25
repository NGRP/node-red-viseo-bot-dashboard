module Header exposing (..)

import Html exposing (Html, text, div, h1, img, a)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( flex
        , w_100
        , f6
        , link
        , dim
        , ph1
        , pv2
        , dib
        , dark_blue
        , ba
        , absolute
        , w_10
        , center
        , f4
        , dib
        , ph3
        , mw4
        , tc
        )


view : Html Msg
view =
    div
        [ classes
            [ flex
            , w_100
            ]
        , class "header_header"
        ]
        [ div
            [ classes
                []
            ]
            [ div
                [ classes
                    [ dib
                    , absolute
                    ]
                , href "#"
                , class "header_float_l"
                ]
                [ img [ src "./Assets/img/logo_viseo.png", class "img_logo" ] [] ]
            , a
                [ classes
                    [ f6
                    , link
                    , dim
                    , ph1
                    , pv2
                    , dib
                    , dark_blue
                    , ba
                    , absolute
                    , tc
                    ]
                , class "header_float_r"
                , href "#"
                ]
                [ text "LOG OUT" ]
            ]
        ]
