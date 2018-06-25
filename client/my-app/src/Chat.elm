module Chat exposing (init, Model, update, view, Msg)

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
            , bg_yellow
            , outline
            ]
        , class "conv"
        ]
        [ text "CONVERSATIONS" ]



---- PROGRAM ----
