module Chat exposing (init, Model, update, view, Msg)

import Html exposing (Html, text, div, h1, img, a, input, label, section, p)
import Html.Attributes exposing (class, href, src, style, placeholder, attribute, id, name, type_, for)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes
    exposing
        ( fl
        , w_60
        , bg_light_blue
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
        )


---- MODEL ----


type alias Model =
    {}


init : Model
init =
    ({})



---- UPDATE ----


type Msg
    = ChatMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ classes
            [ fl
            , w_60
            , bg_light_blue
            , outline
            ]
        , class "chat_conv"
        ]
        [ displayTabs
        , displayConversation
        , displayFieldAndButtons
        ]


displayTabs : Html Msg
displayTabs =
    div
        [ class "tabs-main" ]
        [ input [ attribute "checked" "", id "tab1", name "tabs", type_ "radio" ]
            []
        , label [ for "tab1" ]
            [ text "Client 1" ]
        , input [ id "tab2", name "tabs", type_ "radio" ]
            []
        , label [ for "tab2" ]
            [ text "Client 2" ]
        , input [ id "tab3", name "tabs", type_ "radio" ]
            []
        , label [ for "tab3" ]
            [ text "Client 3" ]
        , input [ id "tab4", name "tabs", type_ "radio" ]
            []
        , label [ for "tab4" ]
            [ text "Client 4" ]
        ]


displayConversation : Html Msg
displayConversation =
    div
        [ classes
            [ fl
            , w_100
            , bg_white_80
            , outline
            ]
        , class "chat_panel"
        ]
        [ --  section [ id "content1" ]
          --     [ p []
          --         [ text "1" ]
          --     ]
          -- , section [ id "content2" ]
          --     [ p []
          --         [ text "2" ]
          --     ]
          -- , section [ id "content3" ]
          --     [ p []
          --         [ text "3" ]
          --     ]
          -- , section [ id "content4" ]
          --     [ p []
          --         [ text "4" ]
          --     ]
          p [] [ text "Ceci est une fenêtre de discussion." ]
        ]


displayFieldAndButtons : Html Msg
displayFieldAndButtons =
    div [ classes [ center ], class "chat_field_and_buttons" ]
        [ input [ classes [ w_70, f6, br3, ph3, pv2, dib, black, bg_white ], placeholder "Type Here" ] []
        , a [ classes [ f6, link, br3, pv2, dib, dim, white, bg_dark_blue, w_10 ], class "chat_buttons", href "#" ] [ text " Lock " ]
        , a [ classes [ f6, link, br3, pv2, dib, dim, white, bg_dark_blue, w_10 ], class "chat_buttons", href "#" ] [ text "Unlock" ]
        ]



---- PROGRAM ----
