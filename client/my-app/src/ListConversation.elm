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
        , f5
        , dim
        , br_pill
        , bg_near_black
        , link
        , pv2
        , white
        , dib
        , mb2
        , mh4
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
        [ displayNav
        ]


displayNav : Html Msg
displayNav =
    nav
        [ classes
            [ pa2
            , w_100
            ]
        ]
        [ displayNavH1
        , displayList
        ]


displayNavH1 : Html Msg
displayNavH1 =
    h1
        [ classes
            [ f4
            , center
            ]
            [ text "Toutes les conversations" ]
        , div
            [ classes
                [ pa2
                ]
            ]
            [ a
                [ classes
                    [ f5
                    , link
                    , dim
                    , br_pill
                    , ph3
                    , pv2
                    , mb2
                    , dib
                    , white
                    , bg_near_black
                    ]
                ]
                [ text "Tous" ]
            , a
                [ classes
                    [ f5
                    , link
                    , dim
                    , br_pill
                    , ph3
                    , pv2
                    , mb2
                    , dib
                    , white
                    , bg_near_black
                    , mh4
                    ]
                ]
                [ text "Alertes" ]
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
