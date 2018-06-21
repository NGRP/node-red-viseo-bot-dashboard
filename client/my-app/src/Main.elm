module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (class, href, src, style)


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
    div []
        [ div [ class "fl w-100 pv3 bg-green fl" ] [ text "HEADER" ]
        , div [ class "" ]
            [ div [ class "flex flex-column fl w-40" ]
                [ div [ class "outline pv5 bg-blue fl w-100 " ] [ text "STATISTIQUES" ]
                , div [ class "outline pv6 bg-pink fl w-100  " ] [ text "LISTE DES CONV" ]
                ]
            ]
        , div [ class "fl w-60 pv7  bg-yellow " ] [ text "CONVERSATIONS" ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
