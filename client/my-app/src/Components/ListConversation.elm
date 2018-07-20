module Components.ListConversation exposing (Model, Msg, init, update, view, Status(..))

-- import ISO8601

import Tachyons exposing (classes, tachyons)
import Codec.Conversations as Conversations exposing (Filtre(..), filterList)


-- import Date.Extra as Date

import String.Extra as Str
import Html.Events exposing (onClick)
import Codec.ConversationHeader exposing (ConversationHeader, Status(..))
import Html exposing (Html, a, div, h1, img, li, nav, text, ul)
import Html.Attributes exposing (class, href, src, style)
import String.Extra as Str
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
        , ph5
        , w_100
        , w_25
        , white
        )


---- MODEL ----


type alias Model =
    { conv : Conversations.Model
    , convFiltree : List ConversationHeader
    , filtreSelection : Filtre
    }


type Status
    = Running
    | ConversationSelected ConversationHeader



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
--Initialiser la conversation avec le filtre All


initialModel : ( Model, Cmd Msg )
initialModel =
    let
        ( conversationModel, conversationMsg ) =
            Conversations.init
    in
        ( Model conversationModel conversationModel.conversations All, Cmd.map ConversationsMsg conversationMsg )


init : ( Model, Cmd Msg )
init =
    initialModel



---- UPDATE ----


type Msg
    = ConversationsMsg Conversations.Msg
    | DoFilterMsg Filtre
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

        DoFilterMsg filtre ->
            case filtre of
                All ->
                    ( { model | convFiltree = (filterList filtre model.conv.conversations) }, Cmd.none, Running )

                Alerte ->
                    ( { model | convFiltree = (filterList filtre model.conv.conversations) }, Cmd.none, Running )

                SansAlerte ->
                    ( { model | convFiltree = (filterList filtre model.conv.conversations) }, Cmd.none, Running )

                Suspended ->
                    ( { model | convFiltree = (filterList filtre model.conv.conversations) }, Cmd.none, Running )



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


displayFiltersClass : String -> String -> Filtre -> Html Msg
displayFiltersClass txt class_name filtre =
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
        , href "#"
        , class class_name
        , onClick (DoFilterMsg filtre)
        ]
        [ text txt ]


displayFilters : Html Msg
displayFilters =
    div
        [ classes
            [ flex
            , ph5
            ]
        ]
        [ displayFiltersClass "Tous" "all_btn" All
        , displayFiltersClass "avec alerte" "push_btn" Alerte
        , displayFiltersClass "sans alerte" "push_btn" SansAlerte
        , displayFiltersClass "Suspendu" "suspended_btn" Suspended
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
            , class "style-7"
            ]
            (List.map displayLine model.convFiltree)
        ]



-- Dlb Click à mettre en place


displayLine : Codec.ConversationHeader.ConversationHeader -> Html Msg
displayLine conversation =
    li
        [ classes
            [ bb
            ]
        , class "list-style"
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
                    , pv3
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
