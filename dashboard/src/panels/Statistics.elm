module Panels.Statistics exposing (..)

import Html exposing (Html, text, div, h1, img, a)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( outline
        , bg_blue
        , w_100
        )


view : Html msg
view =
    div
        [ classes
            [ outline
            , w_100
            ]
        , class "statistics_stats"
        ]
        [ text "STATISTIQUES" ]
