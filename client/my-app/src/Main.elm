module Main exposing (..)

import Components.Chat as Chat
import Components.Header as Header
import Components.ListConversation as ListConversation exposing (Model, Msg, init, update, view, Status(Running, ConversationSelected))
import Components.Statistics as Statistics
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( dt
        , fl
        , flex
        , flex_column
        , h_100
        , min_vh_100
        , vh_100
        , w_100
        , w_40
        )
import WebSocket


--commentaire
---- MODEL ----


type alias Model =
    { stat : Statistics.Model
    , header : Header.Model
    , listConv : ListConversation.Model
    , chat : Chat.Model
    , wsMsg : String
    }


init : ( Model, Cmd Msg )
init =
    initialModel


initialModel : ( Model, Cmd Msg )
initialModel =
    let
        ( m, cm ) =
            ListConversation.init

        ( m2, cm2 ) =
            Chat.init
    in
        ( { stat = Statistics.init, header = Header.init, listConv = m, chat = m2, wsMsg = " " }, Cmd.batch [ Cmd.map ListConvMsg cm, Cmd.map ChatMsg cm2 ] )



---- UPDATE ----


type Msg
    = StatMsg Statistics.Msg
    | HeaderMsg Header.Msg
    | ListConvMsg ListConversation.Msg
    | ChatMsg Chat.Msg
    | WebSocketTest String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- Debug.log "debug main msg"
        StatMsg statMsg ->
            let
                ( updatedStatisticsModel, statisticsCmd ) =
                    Statistics.update statMsg model.stat
            in
                ( { model | stat = updatedStatisticsModel }, Cmd.map StatMsg statisticsCmd )

        HeaderMsg headerMsg ->
            let
                ( updatedHeaderModel, headerCmd ) =
                    Header.update headerMsg model.header
            in
                ( { model | header = updatedHeaderModel }, Cmd.map HeaderMsg headerCmd )

        ListConvMsg listConvMsg ->
            let
                ( updatedListeConvModel, listConvCmd, status ) =
                    ListConversation.update listConvMsg model.listConv
            in
                case status of
                    Running ->
                        ( { model | listConv = updatedListeConvModel }, Cmd.map ListConvMsg listConvCmd )

                    ConversationSelected conv ->
                        let
                            ( updatedChatModel, chatCmd ) =
                                Chat.addConversation conv model.chat
                        in
                            ( { model | chat = updatedChatModel, listConv = updatedListeConvModel }, Cmd.batch [ Cmd.map ChatMsg chatCmd, Cmd.map ListConvMsg listConvCmd ] )

        ChatMsg chatMsg ->
            let
                ( updatedChatModel, chatCmd ) =
                    Chat.update chatMsg model.chat
            in
                ( { model | chat = updatedChatModel }, Cmd.map ChatMsg chatCmd )

        WebSocketTest txt ->
            ( { model | wsMsg = txt }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen wsServer WebSocketTest


wsServer : String
wsServer =
    "ws://localhost:3001/health"



-- messageTest :   Sub Msg -> Html Msg
-- messageTest submsg =
--   subscriptions
---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ classes
            [ vh_100
            , dt
            , min_vh_100
            , flex
            ]
        ]
        [ tachyons.css
        , div
            [ classes
                [ w_100
                , h_100
                ]
            ]
            [ Html.map HeaderMsg (Header.view model.header)
            , displayLeftPanel model
            , Html.map ChatMsg (Chat.view model.chat)
            ]
        ]



-- Html.map WidgetMsg (Widget.view model.widgetModel)


displayLeftPanel : Model -> Html Msg
displayLeftPanel model =
    div
        [ classes
            [ flex
            , flex_column
            , fl
            , w_40
            ]
        , class "main_leftPanel"
        ]
        [ Html.map StatMsg (Statistics.view model.stat)
        , Html.map ListConvMsg (ListConversation.view model.listConv)
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
