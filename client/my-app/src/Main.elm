module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes exposing (avenir, center, debug, debug_grid, flex, flex_column, mw5, mw6, vh_100)


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
    --     [ div [ class "fl w-100 bg-green fl" ] [ text "HEADER" ]
    --     , div [ class "" ]
    --         [ div [ class "flex flex-column fl w-40" ]
    --             [ div [ class "outline bg-blue fl w-100 " ] [ text "STATISTIQUES" ]
    --             , div [ class "outline bg-pink fl w-100  " ] [ text "LISTE DES CONV" ]
    --             ]
    --         ]
    --     , div [ class "fl w-60 bg-yellow " ] [ text "CONVERSATIONS" ]
    --     ]
    div
        []
        --[ classes [ debug, debug_grid ]]
        [ tachyons.css
        , div
            [ classes
                [ flex
                , flex_column
                , avenir
                , vh_100
                , mw6
                , center
                ]
            ]
            [ text "Hi mate"
            ]
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
