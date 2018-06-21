module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
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
    -- div [ class "vh-100 w-100" ]
    --     [ div [ class "fl w-100 bg-green" ] [ text "HEADER" ]
    --     , div [ class "" ]
    --         [ div [ class "flex flex-column fl w-40" ]
    --             [ div [ class "outline bg-blue fl w-100 " ] [ text "STATISTIQUES" ]
    --             , div [ class "outline bg-pink fl w-100  " ] [ text "LISTE DES CONV" ]
    --             ]
    --         ]
    --     , div [ class "fl w-60 bg-yellow " ] [ text "CONVERSATIONS" ]
    --     ]
    --
    div []
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
            [ fl
            , w_100
            , bg_green
            ]
        ]
        [ text "HEADER" ]


displayLeftPanel : Html Msg
displayLeftPanel =
    div []
        [ div
            [ classes
                [ flex
                , flex_column
                , fl
                , w_40
                , h_100
                ]
            ]
            [ displayStatistics
            , displayList
            ]
        ]


displayStatistics : Html Msg
displayStatistics =
    div
        [ classes
            [ outline
            , bg_blue
            , h_25
            , w_100
            ]
        ]
        [ text "STATISTIQUES" ]


displayList : Html Msg
displayList =
    div
        [ classes
            [ outline
            , bg_pink
            , h_75
            , w_100
            ]
        ]
        [ text " LISTE DES CONV" ]


displayConversation : Html Msg
displayConversation =
    div
        [ classes
            [ fl
            , w_60
            , bg_yellow
            , h_100
            ]
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
