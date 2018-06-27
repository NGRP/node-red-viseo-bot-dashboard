module Chat exposing (init, Model, update, view, Msg)

import Html exposing (Html, text, div, h1, img, a, input)
import Html.Attributes exposing (class, href, src, style, placeholder)
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
        [ displayConversation
        , displayFieldAndButtons
        ]


displayConversation : Html Msg
displayConversation =
    div
        [ classes
            [ fl
            , w_100
            , bg_white_80
            , outline
            ]
        , class "discussion_panel"
        ]
        [ text "Conversation Here" ]


displayFieldAndButtons : Html Msg
displayFieldAndButtons =
    div [ classes [ center ], class "discussion_field_and_buttons" ]
        [ input [ classes [ w_70 ], placeholder "Type Here" ] []
        , a [ classes [ f6, dim, br_pill, ba, bw2, ph3, pv2, mb2, dib, black, bg_white_80, w_10 ] ] [ text " Lock " ]
        , a [ classes [ f6, dim, br_pill, ba, bw2, ph3, pv2, mb2, dib, black, bg_white_80, w_10 ] ] [ text "Unlock" ]
        ]



---- PROGRAM ----
