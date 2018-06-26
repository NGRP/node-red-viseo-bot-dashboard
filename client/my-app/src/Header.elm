module Header exposing (init, Model, update, view, Msg)

import Html exposing (Html, text, div, h1, img, a)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes exposing (..)


---- MODEL ----


type alias Model =
    {}


init : Model
init =
    ({})



---- UPDATE ----


type Msg
    = HeaderMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ classes
            [ flex
            , w_100
            ]
        , class "header"
        ]
        [ div
            [ classes
                []
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
                    , w_10
                    , center
                    ]
                , href "#"
                , class "float_r"
                ]
                [ text "Log out" ]
            , a
                [ classes
                    [ f4
                    , link
                    , dib
                    , ph3
                    , pv2
                    , dark_blue
                    , absolute
                    , w_10
                    ]
                , href "#"
                , class "float_l"
                ]
                [ text "VISEO" ]
            ]
        ]



---- PROGRAM ----
