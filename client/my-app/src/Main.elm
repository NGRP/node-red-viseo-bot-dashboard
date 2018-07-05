module Main exposing (..)

import Html exposing (Html, text, div, h1, img, a)
import Html.Attributes exposing (class, href, src, style)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( vh_100
        , dt
        , min_vh_100
        , flex
        , w_100
        , h_100
        , flex_column
        , fl
        , w_40
        )
import Components.Statistics as Statistics
import Components.ListConversation as ListConversation
import Components.Chat as Chat
import Components.Header as Header


--commentaire
---- MODEL ----


type alias Model =
    { stat : Statistics.Model
    , header : Header.Model
    , listConv : ListConversation.Model
    , chat : Chat.Model
    }


init : ( Model, Cmd Msg )
init =
    initialModel


initialModel : ( Model, Cmd Msg )
initialModel =
    let
        ( m, cm ) =
            ListConversation.init
    in
        ( { stat = Statistics.init, header = Header.init, listConv = m, chat = Chat.init }, Cmd.map ListConvMsg cm )



---- UPDATE ----


type Msg
    = StatMsg Statistics.Msg
    | HeaderMsg Header.Msg
    | ListConvMsg ListConversation.Msg
    | ChatMsg Chat.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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
                ( updatedListeConvModel, listConvCmd ) =
                    ListConversation.update listConvMsg model.listConv
            in
                ( { model | listConv = updatedListeConvModel }, Cmd.map ListConvMsg listConvCmd )

        ChatMsg chatMsg ->
            let
                ( updatedChatModel, chatCmd ) =
                    Chat.update chatMsg model.chat
            in
                ( { model | chat = updatedChatModel }, Cmd.map ChatMsg chatCmd )



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
            [ (Html.map HeaderMsg (Header.view model.header))
            , (displayLeftPanel model)
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
        , subscriptions = always Sub.none
        }
