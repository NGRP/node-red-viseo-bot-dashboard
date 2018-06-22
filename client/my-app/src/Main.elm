module Main exposing (..)

import Html exposing (Html, text, div, h1, img, a)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes exposing (..)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ classes
            [ vh_100
            , dt
            , w_100
            ]
        ]
        [ tachyons.css
        , div
            [ classes
                [ w_100
                , h_100
                ]
            ]
            [ displayHeader
            , displayLeftPanel
            , displayConversation
            ]
        ]


displayHeader : Html Msg
displayHeader =
    div
        [ classes
            [ flex
            , w_100
            ]
        , class "header"
        ]
        [ div
            [ classes
                [ fr ]
            ]
            [ a
                [ classes
                    [ f5
                    , link
                    , dim
                    , ph3
                    , pv2
                    , dib
                    , dark_blue
                    , ba
                    , absolute
                    ]
                , href "#"
                ]
                [ text "Log out" ]
            ]
        ]


displayLeftPanel : Html Msg
displayLeftPanel =
    div
        [ classes
            [ flex
            , flex_column
            , fl
            , w_40
            ]
        , class "leftPanel"
        ]
        [ displayStatistics
        , displayList
        ]


displayStatistics : Html Msg
displayStatistics =
    div
        [ classes
            [ outline
            , bg_blue
            , w_100
            ]
        , class "stat"
        ]
        [ text "STATISTIQUES" ]


displayList : Html Msg
displayList =
    div
        [ classes
            [ outline
            , bg_pink
            , w_100
            ]
        , class "liste"
        ]
        [ text " LISTE DES CONV" ]


displayConversation : Html Msg
displayConversation =
    div
        [ classes
            [ fl
            , w_60
            , bg_yellow
            , outline
            ]
        , class "conv"
        ]
        [ text "CONVERSATIONS" ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
