module Components.ListConversation exposing (init, Model, update, view, Msg)

import Html exposing (Html, text, div, h1, img, a, nav, ul, li)
import Html.Attributes exposing (class, href, src, style)
import Codec.ConversationHeader exposing (ConversationHeader)


-- import Html.Events exposing (onClick)

import Tachyons exposing (classes, tachyons)
import Conversations
import Date.Extra as Date
import String.Extra as Str


-- import ISO8601

import Tachyons.Classes
    exposing
        ( outline
        , w_100
        , h_100
        , list
        , pl0
        , ml0
        , ml4
        , mh4
        , mw6
        , w_25
        , ba
        , b__dark_blue
        , br2
        , pa2
        , pa4
        , ph3
        , pv3
        , bb
        , flex_nowrap
        , flex_column
        , overflow_container
        , fw4
        , no_underline
        , f5
        , f4
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
        , mt0
        , pt3
        , lh_title
        , center
        , justify_center
        , justify_between
        , flex_row
        , mh5
        , mh3
        , fr
        , pv3
        , pv1
        )


---- MODEL ----


type alias Model =
    { conv : Conversations.Model
    }



-- conversations : List Conversation
-- type Status
--     = OnGoing
--     | Alert
--     | Taken
--     | Ended
-- type alias Conversation =
--     { id : String
--     , last_msg_date : String
--     , user_id : String
--     , user_name : String
--     , msg_status : Int
--     , handover : String
--     , messages : List Message
--     }
--
--
-- type alias Message =
--     { date : String
--     , conv_id : String
--     , user_id : String
--     , user_name : String
--     , msg_status : Int
--     , user_talking : String
--     , msg_type : String
--     , msg_content : String
--     }
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


initialModel : ( Model, Cmd Msg )
initialModel =
    let
        ( conversationModel, conversationMsg ) =
            Conversations.init
    in
        ( Model conversationModel, Cmd.map ConversationsMsg conversationMsg )


init : ( Model, Cmd Msg )
init =
    initialModel



---- UPDATE ----


type Msg
    = ConversationsMsg Conversations.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ConversationsMsg conversationsMsg ->
            let
                ( updatedConversationsModel, conversationsCmd ) =
                    Conversations.update conversationsMsg model.conv
            in
                ( { model | conv = updatedConversationsModel }, Cmd.map ConversationsMsg conversationsCmd )



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ classes
            [ outline
            , w_100
            ]
        , class "listconv_list"
        ]
        [ displayNav model
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
        , class "listconv_whitespace"
        ]
        [ displayNavHeader
        , displayFilters
        ]


displayNavHeader : Html Msg
displayNavHeader =
    h1
        [ classes
            [ fw4
            , f4
            , mt0
            , pt3
            ]
        , class "conversation"
        ]
        [ text "CONVERSATIONS" ]


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
                , mr3
                ]
            , class "all_btn"
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
                , mr3
                ]
            , class "suspended_btn"
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
                , b__dark_blue
                , br2
                , overflow_auto
                ]
            , class "listconv_listHeight"
            ]
            (List.map displayLine model.conv.conversations)
        ]


displayLine : Codec.ConversationHeader.ConversationHeader -> Html Msg
displayLine conversation =
    let
        d =
            Date.fromIsoString conversation.last_msg_date
    in
        li
            [ classes
                [ bb
                ]
            ]
            [ a
                [ classes
                    [ no_underline
                    , link
                    , flex
                    , justify_between
                    ]
                , class "link_list"
                , href "#"
                ]
                [ div
                    [ class (colorStatusString conversation)
                    ]
                    [ text (toString (conversation.msg_status)) ]
                , div
                    [ classes
                        [ pv3
                        , ml4
                        ]
                    , class "user_name"
                    ]
                    [ text conversation.user_name ]
                , div
                    [ classes
                        [ pv3 ]
                    , class "date"
                    ]
                    [ text (Str.leftOfBack ":" (Str.rightOf "<" (toString d))) ]
                , div
                    [ classes
                        [ w_25
                        , pv1
                        , mr3
                        ]
                    ]
                    [ img [ src "./Assets/img/robot.png", class "img_bot" ] [] ]
                ]
            ]



--


colorStatusString : Codec.ConversationHeader.ConversationHeader -> String
colorStatusString conversation =
    case conversation.msg_status of
        0 ->
            "lb"

        1 ->
            "lb"

        2 ->
            "lb"

        3 ->
            "lb"

        4 ->
            "lp"

        5 ->
            "lp"

        6 ->
            "lp"

        7 ->
            "lr"

        8 ->
            "lr"

        9 ->
            "lr"

        _ ->
            "none"
