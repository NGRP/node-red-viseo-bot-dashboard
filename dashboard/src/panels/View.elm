module View exposing (..)


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
