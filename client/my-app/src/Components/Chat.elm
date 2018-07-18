module Components.Chat exposing (init, Model, update, view, Msg, addConversation)

import Html exposing (Html, text, div, h1, img, a, input, label, section, p, span, ul, li)
import Html.Attributes exposing (class, href, src, style, placeholder, attribute, id, name, type_, for)
import Tachyons exposing (classes, tachyons)
import Codec.Tabs as Tabs exposing (..)
import Codec.ConversationMsg as ConversationMsg exposing (ConversationMsg)
import Codec.ConversationHeader as ConversationHeader exposing (ConversationHeader)
import Tachyons.Classes
    exposing
        ( fl
        , w_60
        , bg_light_blue
        , bg_mid_gray
        , outline
        , w_100
        , bg_white_80
        , w_70
        , f6
        , br3
        , ph3
        , pv2
        , dib
        , black
        , bg_white
        , f6
        , link
        , dim
        , white
        , bg_dark_blue
        , w_10
        , center
        , flex
        , flex_column
        , w_75
        , ml5
        , ml2
        , bg_green
        , bg_blue
        , white_60
        , overflow_auto
        , list
        , tj
        , f5
        , fl
        , mt2
        , mb1
        , pa2
        , input_reset
        , f7
        , mb0
        )
import Dict exposing (Dict, get, toList)
import Html.Events exposing (onClick)


-- import String.Extra as Str
---- MODEL ----


type alias Model =
    { tabs : Tabs.Model, displayedTab : Tabs.Tab }


initialModel : ( Model, Cmd Msg )
initialModel =
    let
        ( tabsModel, tabsMsg ) =
            Tabs.init
    in
        ( Model tabsModel (Tab "" []), Cmd.map TabsMsg tabsMsg )


init : ( Model, Cmd Msg )
init =
    initialModel



---- UPDATE ----


type Msg
    = TabsMsg Tabs.Msg
    | OnCheckedTab String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TabsMsg tabsMsg ->
            let
                ( updatedTabsModel, tabsCmd ) =
                    Tabs.update tabsMsg model.tabs
            in
                ( { model | tabs = updatedTabsModel }, Cmd.map TabsMsg tabsCmd )

        OnCheckedTab key ->
            case (get key model.tabs.tabs) of
                Nothing ->
                    ( model, Cmd.none )

                Just tab ->
                    ( { model | displayedTab = tab }, Cmd.none )


addConversation : ConversationHeader -> Model -> ( Model, Cmd Msg )
addConversation conv model =
    ( model, Cmd.map TabsMsg (Tabs.newTabCmd conv.id) )



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ classes
            [ fl
            , w_60
            , outline
            , flex
            , flex_column
            ]
        , class "chat_conv"
        ]
        [ displayTabs model
        , displayConversation model
        , displayFieldAndButtons
        ]



-- displayTabs : Html Msg
-- displayTabs =
--     div
--         [ class "tabs-main" ]
--         [ input [ attribute "checked" "", id "tab1", name "tabs", type_ "radio" ]
--             []
--         , label [ for "tab1" ]
--             [ text "Client 1" ]
--         , input [ id "tab2", name "tabs", type_ "radio" ]
--             []
--         , label [ for "tab2" ]
--             [ text "Client 2" ]
--         , input [ id "tab3", name "tabs", type_ "radio" ]
--             []
--         , label [ for "tab3" ]
--             [ text "Client 3" ]
--         , input [ id "tab4", name "tabs", type_ "radio" ]
--             []
--         , label [ for "tab4" ]
--             [ text "Client 4" ]
--         ]


displayTabs : Model -> Html Msg
displayTabs model =
    div
        [ class "tabs-main" ]
        (List.map displayTab (toList model.tabs.tabs))


displayTab : ( String, Tab ) -> Html Msg
displayTab ( key, tab ) =
    div
        [ classes
            [ fl
            , flex
            , mb0
            ]
        ]
        [ input [ id ("tab" ++ key), name "tabs", type_ "radio", onClick (OnCheckedTab key) ]
            []
        , label [ for ("tab" ++ key) ] [ text ("User " ++ key) ]
        ]


displayConversation : Model -> Html Msg
displayConversation model =
    div
        [ classes
            [ fl
            , w_100
            , outline
            , overflow_auto
            ]
        , class "chat_panel"
        , id "style-7"
        ]
        [ displayMessages model.displayedTab ]


displayMessages : Tab -> Html Msg
displayMessages tab =
    div []
        [ ul
            []
            (List.map displayMessage tab.conversationMsgs)
        ]


displayMessage : ConversationMsg -> Html Msg
displayMessage cm =
    li
        [ classes [ br3, list, flex, flex_column ] ]
        [ div [] [ span [ classes [ black, f6 ], class "nameUser" ] [ text cm.user_name ] ]
        , p [ classes [ br3, tj, f5, mt2, mb1, pa2 ], class "container l_msg_margin msg_user" ]
            [ text cm.msg_content ]
        , div []
            [ span [ classes [ black, f7, fl ], class "time-left" ]
                [ text "11:00" ]
            ]
        ]


displayFieldAndButtons : Html Msg
displayFieldAndButtons =
    div [ classes [ w_100 ], class "discussion_field_and_buttons" ]
        [ input [ classes [ w_75, f6, br3, ph3, pv2, dib, black, bg_white ], placeholder "Type Here", class "input_chat" ] []
        , a [ classes [ br3, pv2, dib, dim, ml2 ], class "buttons", href "#" ] [ img [ src "./Assets/img/lock.png", class "img_lock" ] [] ]
        ]



---- PROGRAM ----
