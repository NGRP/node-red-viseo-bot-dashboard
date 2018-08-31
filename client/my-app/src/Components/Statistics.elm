module Components.Statistics exposing (init, Model, update, view, Msg)

import Html exposing (Html, text, div, h1, img, a)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( outline
        , bg_blue
        , w_100
        )


---- MODEL ----
-- exposer init, model et view et update


type alias Model =
    {}


init : Model
init =
    ({})



---- UPDATE ----


type Msg
    = StatMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ classes
            [ outline
            , w_100
            ]
        , class "statistics_stats"
        ]
        [ text "STATISTIQUES" ]
