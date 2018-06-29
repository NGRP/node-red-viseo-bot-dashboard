module ListConversation exposing (init, Model, update, view, Msg)

import Html exposing (Html, text, div, h1, img, a, nav, ul, li)
import Html.Attributes exposing (class, href, src, style)
import Html.Events exposing (onClick)
import Tachyons exposing (classes, tachyons)
import RecupJson
import Json.Decode as Decode
import Date
import ISO8601
import Tachyons.Classes
    exposing
        ( outline
        , w_100
        , h_100
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
        , flex_nowrap
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
        , mr3
        , bg_green
        , flex
        , overflow_auto
        , bg_mid_gray
        , mt0
        , pt2
        )


---- MODEL ----


type alias Model =
    { conversations : RecupJson.Model }



-- conversations : List Conversation
-- type Status
--     = OnGoing
--     | Alert
--     | Taken
--     | Ended


type alias Conversation =
    { id : String
    , last_msg_date : String
    , user_id : String
    , user_name : String
    , msg_status : Int
    , handover : String
    , messages : List Message
    }


type alias Message =
    { date : String
    , conv_id : String
    , user_id : String
    , user_name : String
    , msg_status : Int
    , user_talking : String
    , msg_type : String
    , msg_content : String
    }



-- exampleConvList : List Conversation
-- exampleConvList =
--     [ Conversation "1" OnGoing
--     , Conversation "2" Alert
--     , Conversation "3" OnGoing
--     , Conversation "4" Ended
--     , Conversation "5" Alert
--     , Conversation "6" Taken
--     , Conversation "7" Ended
--     , Conversation "8" Ended
--     , Conversation "9" Ended
--     , Conversation "10" Ended
--     ]


init : Model
init =
    Model



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
        [ displayNav RecupJson.model
        ]


displayNav : Model -> Html Msg
displayNav model =
    nav
        [ classes
            [ w_100
            ]
        ]
        [ displayWhiteSpace
        , displayList model
        ]


displayWhiteSpace : Html Msg
displayWhiteSpace =
    div
        [ classes
            []
        , class "white_space"
        ]
        [ displayNavHeader
        , displayFilters
        ]


displayNavHeader : Html Msg
displayNavHeader =
    h1
        [ classes
            [ f4
            , center
            , mt0
            , pt2
            ]
        ]
        [ text "Toutes les conversations" ]


displayFilters : Html Msg
displayFilters =
    div
        [ classes
            [ flex
            , ph3
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
                , bg_mid_gray
                , mr3
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
                , bg_mid_gray
                , mr3
                ]
            , class "push_btn"

            -- , id "bouton_alerte"
            -- , onClick (coloration (bouton_alerte))
            ]
            -- hover avec alerte et sans alerte
            [ text "Alertes" ]
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
                , bg_mid_gray
                , mr3
                ]
            ]
            -- l'agent a pris la main
            [ text "Suspendu" ]
        ]


displayList : Model -> Html Msg
displayList model =
    div
        [ classes
            [ flex_nowrap
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
                , overflow_auto
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
