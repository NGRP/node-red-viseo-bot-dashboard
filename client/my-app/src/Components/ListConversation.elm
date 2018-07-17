module Components.ListConversation exposing (Model, Msg, init, update, view, Status(Running, ConversationSelected))

import Codec.ConversationHeader exposing (ConversationHeader, Status(..))
import Codec.Conversations as Conversations
import Html.Events exposing (onDoubleClick)


-- import Date.Extra as Date

import Html exposing (Html, a, div, h1, img, li, nav, text, ul)
import Html.Attributes exposing (class, href, src, style)
import String.Extra as Str
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( b__dark_blue
        , ba
        , bb
        , bg_green
        , bg_near_black
        , br2
        , br_pill
        , center
        , dib
        , dim
        , f4
        , f5
        , flex
        , flex_column
        , flex_nowrap
        , flex_row
        , fr
        , fw4
        , h_100
        , justify_between
        , justify_center
        , lh_title
        , link
        , list
        , mb2
        , mh3
        , mh4
        , mh5
        , ml0
        , ml4
        , mr3
        , mr4
        , mt0
        , mw6
        , no_underline
        , outline
        , overflow_auto
        , overflow_container
        , pa2
        , pa4
        , ph3
        , pl0
        , pt3
        , pv1
        , pv2
        , pv3
        , w_100
        , w_25
        , white
        )


---- MODEL ----


type alias Model =
    { conv : Conversations.Model
    }


type Status
    = Running
    | ConversationSelected ConversationHeader


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
    | OnDblClick ConversationHeader


update : Msg -> Model -> ( Model, Cmd Msg, Status )
update msg model =
    case msg of
        ConversationsMsg conversationsMsg ->
            let
                ( updatedConversationsModel, conversationsCmd ) =
                    Conversations.update conversationsMsg model.conv
            in
                ( { model | conv = updatedConversationsModel }, Cmd.map ConversationsMsg conversationsCmd, Running )

        OnDblClick conv ->
            ( model, Cmd.none, ConversationSelected conv )



--
-- Suspended : lorque qu’un agent a pris la main -> string non null
--  type Filtre
--    = All
--    | Alerte
--    | Suspended
--
--
-- filterList : liste ? -> Html Msg
-- update filtre conversation.msg_status =
--   case filtre of
--     All ->
--       la liste
--
--     Alerte ->
--     List.filter (\n -> n.Status == Alert )
--
--     Suspended ->
--       -- handover non null
-- List.filter (\n -> n.conversation.handover  /= null )
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


displayFiltersClass : String -> String -> Html Msg
displayFiltersClass txt class_name =
    a
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
        , class class_name
        ]
        [ text txt ]


displayFilters : Html Msg
displayFilters =
    div
        [ classes
            [ flex
            , ph3
            ]
        ]
        [ displayFiltersClass "Tous" "all_btn"
        , displayFiltersClass "avec alerte" "push_btn"
        , displayFiltersClass "sans alerte" "push_btn"
        , displayFiltersClass "Suspendu" "suspended_btn"
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



-- Dlb Click à mettre en place


displayLine : Codec.ConversationHeader.ConversationHeader -> Html Msg
displayLine conversation =
    li
        [ classes
            [ bb
            ]
        , class "list-style"
        , onDoubleClick (OnDblClick conversation)
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
                []
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
                [ text (Str.leftOfBack ":" (Str.rightOf "<" (toString conversation.last_msg_date))) ]
            , div
                [ classes
                    [ w_25
                    ]
                ]
                [ displayHandover conversation.handover ]
            ]
        ]


displayHandover : Maybe String -> Html Msg
displayHandover handoverMaybe =
    case handoverMaybe of
        Nothing ->
            div
                [ classes
                    [ w_25
                    , pv1
                    , mr3
                    , fr
                    ]
                ]
                [ img [ src "./Assets/img/robot.png", class "img_bot" ] [] ]

        Just handover ->
            div
                [ classes
                    [ pv1
                    , mr4
                    , fr
                    ]
                ]
                [ text handover ]


colorStatusString : Codec.ConversationHeader.ConversationHeader -> String
colorStatusString conversation =
    case conversation.msg_status of
        Codec.ConversationHeader.Good ->
            "lb"

        Warning ->
            "lp"

        Alert ->
            "lr"
