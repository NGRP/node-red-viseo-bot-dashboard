module ListConversation exposing (init, Model, update, view, Msg)

import Html exposing (Html, text, div, h1, img, a, nav, ul, li)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( outline
        , bg_pink
        , w_100
        , list
        , pl0
        , ml0
        , center
        , mw6
        , ba
        , b__light_silver
        , br2
        , pa2
        , pa4
        , ph3
        , pv3
        , bb
        , nowrap
        , overflow_container
        , f4
        , no_underline
        )


---- MODEL ----


type alias Model =
    {}


init : Model
init =
    ({})



---- UPDATE ----


type Msg
    = ListeConvMsg


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
        , class "liste"
        ]
        [ displayListExample
        ]


displayListExample : Html Msg
displayListExample =
    nav
        [ classes
            [ pa2
            , pa4
            ]
        ]
        [ h1
            [ classes
                [ f4
                , center
                ]
            , class "center"
            ]
            [ text " Liste des conv" ]
        , div
            [ classes
                [ nowrap
                , overflow_container
                ]
            , class "listHeight"
            ]
            [ ul
                [ classes
                    [ list
                    , pl0
                    , center
                    , mw6
                    , ba
                    , b__light_silver
                    , br2
                    , w_100
                    ]
                ]
                [ displayLine
                , displayLine
                , displayLine
                , displayLine
                , displayLine
                , displayLine
                , displayLine
                , displayLine
                , displayLine
                ]
            ]
        ]


displayLine : Html Msg
displayLine =
    li
        [ classes
            [ ph3
            , pv3
            , bb
            ]
        ]
        [ a
            [ classes
                [ no_underline
                ]
            ]
            [ text "lena" ]
        ]
