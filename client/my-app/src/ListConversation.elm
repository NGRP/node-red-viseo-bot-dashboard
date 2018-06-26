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
        , bg_green
        )


---- MODEL ----


type alias Model =
    { conversations : List Conversation }


type Status
    = OnGoing
    | Alert
    | Taken
    | Ended


type alias Conversation =
    { conv_id : String

    --, discussion : List String
    , status : Status
    }


exampleConvList : List Conversation
exampleConvList =
    [ Conversation "1" OnGoing
    , Conversation "2" Alert
    , Conversation "3" OnGoing
    , Conversation "4" Ended
    , Conversation "5" Alert
    , Conversation "6" Taken
    , Conversation "7" Ended
    ]


init : Model
init =
    Model
        (exampleConvList)



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
        , class "list"
        ]
        [ displayNav model
        ]


displayNav : Model -> Html Msg
displayNav model =
    nav
        [ classes
            [ pa2
            , w_100
            ]
        ]
        [ displayNavHeader
        , displayFilters
        , displayList model
        ]


displayNavHeader : Html Msg
displayNavHeader =
    h1
        [ classes
            [ f4
            , center
            ]
        ]
        [ text "Toutes les conversations" ]


displayFilters : Html Msg
displayFilters =
    div
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
        ]


displayList : Model -> Html Msg
displayList model =
    div
        [ classes
            [ nowrap
            ]
        ]
        [ ul
            [ classes
                [ list
                , pl0
                , center
                , ba
                , b__light_silver
                , br2
                , overflow_container
                ]
            , class "listHeight"
            ]
            (List.map displayLine model.conversations)
        ]


displayLine : Conversation -> Html Msg
displayLine conversation =
    li
        [ classes
            [ ph3
            , pv3
            , bb
            , bg_green
            ]
        ]
        [ a
            [ classes
                [ no_underline
                ]
            ]
            [ text conversation.conv_id
            ]
        ]



-- displayLine : Html Msg
-- displayLine =
--     li
--         [ classes
--             [ ph3
--             , pv3
--             , bb
--             ]
--         ]
--         [ a
--             [ classes
--                 [ no_underline
--                 ]
--             ]
--             [ text "aym > lena :))" ]
--         ]
