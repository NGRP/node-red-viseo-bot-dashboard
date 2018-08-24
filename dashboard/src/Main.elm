module Main exposing (..)

import Http
import Html exposing (Html, text, div, h1, img)
import Model exposing (Msg(..), Model, Filter(..), ApplicationConversation(..), Conversation, Handler(..), WebSocketEvent(..), Message)
import Conversation exposing (getConversationWithMessagesRequest, toConversationWithMessages, toConversation, webSocketEventDecoder)
import Panels.View as View
import List.Extra
import WebSocket
import Json.Decode as Decode


---- MODEL ----


init : ( Model, Cmd Msg )
init =
    ( Model [] All, Http.send OnConversationsFetched Conversation.getConversationsRequest )



-- TODO, La fonction request qui sera dans le module
---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnMessagesFetched (Err error) ->
            let
                test =
                    Debug.log "erreur" error
            in
                ( model, Cmd.none )

        OnMessagesFetched (Ok conversationWithMessages) ->
            let
                newConversations =
                    unfocusAll model.conversations
                        |> (List.Extra.replaceIf
                                (\conversation ->
                                    if conversationWithMessages.conversation == toConversation conversation then
                                        True
                                    else
                                        False
                                )
                                (Focus conversationWithMessages)
                           )
            in
                ( { model | conversations = newConversations }, Cmd.none )

        FocusConversation conversation ->
            let
                newConversations =
                    unfocusAll model.conversations
                        |> (List.Extra.updateIf
                                (\appConversation ->
                                    if conversation == toConversation appConversation then
                                        True
                                    else
                                        False
                                )
                                (\appConversation ->
                                    case appConversation of
                                        Open conversationWithMessages ->
                                            Focus conversationWithMessages

                                        notOpenConversation ->
                                            notOpenConversation
                                )
                           )
            in
                ( { model | conversations = newConversations }, Cmd.none )

        OnConversationsFetched (Err error) ->
            ( { model | conversations = [] }, Cmd.none )

        OnConversationsFetched (Ok conversationsList) ->
            ( { model | conversations = List.map Close conversationsList }, Cmd.none )

        OpenConversation conversation ->
            ( model, Http.send OnMessagesFetched (getConversationWithMessagesRequest conversation) )

        CloseConversation conversation ->
            let
                newConversations =
                    (List.Extra.updateIf
                        (\appConversation ->
                            if conversation == toConversation appConversation then
                                True
                            else
                                False
                        )
                        (\appConversation ->
                            case appConversation of
                                Open conversationWithMessages ->
                                    Close conversationWithMessages.conversation

                                Focus conversationWithMessages ->
                                    Close conversationWithMessages.conversation

                                notOpenConversation ->
                                    notOpenConversation
                        )
                        model.conversations
                    )
            in
                ( { model | conversations = newConversations }, Cmd.none )

        FilterConversation filter ->
            ( { model | currentFilter = filter }, Cmd.none )

        SwitchLockState conversation ->
            let
                newConversations =
                    (List.Extra.updateIf
                        (\appConversation ->
                            if conversation == toConversation appConversation then
                                True
                            else
                                False
                        )
                        (\appConversation ->
                            case appConversation of
                                Focus conversationWithMessages ->
                                    Focus { conversationWithMessages | conversation = switchLockState conversationWithMessages.conversation }

                                notFocusedConversation ->
                                    notFocusedConversation
                        )
                        model.conversations
                    )
            in
                ( { model | conversations = newConversations }, Cmd.none )

        WebSocketMessage message ->
            let
                wsEventResult =
                    Decode.decodeString webSocketEventDecoder message
            in
                case Debug.log "test " wsEventResult of
                    Ok wsEvent ->
                        case wsEvent of
                            NewMessage convId message ->
                                let
                                    newConversations =
                                        (List.Extra.updateIf
                                            (\appConversation ->
                                                if convId == (toConversation appConversation).id then
                                                    True
                                                else
                                                    False
                                            )
                                            (\appConversation ->
                                                case appConversation of
                                                    Focus conversationWithMessages ->
                                                        Focus { conversationWithMessages | listMsg = (addMessage conversationWithMessages.listMsg message) }

                                                    Open conversationWithMessages ->
                                                        Open { conversationWithMessages | listMsg = (addMessage conversationWithMessages.listMsg message) }

                                                    notOpenConversation ->
                                                        notOpenConversation
                                            )
                                            model.conversations
                                        )
                                in
                                    ( { model | conversations = newConversations }, Cmd.none )

                            HandoverUpdate conversation ->
                                ( model, Cmd.none )

                    Err error ->
                        let
                            wserror =
                                Debug.log "error ws" error
                        in
                            ( model, Cmd.none )



-- TODO
-- OnMessageSent message ->
--
-- _ ->
--     ( model, Cmd.none )


addMessage : List Message -> Message -> List Message
addMessage msgList message =
    msgList ++ [ message ]


switchLockState : Conversation -> Conversation
switchLockState conversation =
    case conversation.handover of
        BotHandler ->
            { conversation | handover = IdAgent "1" }

        IdAgent agentid ->
            { conversation | handover = BotHandler }


unfocusAll : List ApplicationConversation -> List ApplicationConversation
unfocusAll appConversations =
    List.map
        (\conversation ->
            case conversation of
                Focus conversationWithMessages ->
                    Open conversationWithMessages

                appConversation ->
                    appConversation
        )
        appConversations



-- FilterConversation filtre ->
--     ( { model | currentFilter = filtre }, Cmd.none)
-- putMessagesInFocusedConversation : Model -> ConversationWithMessages -> Model
-- putMessagesInFocusedConversation model conversationWithMessages =
--     List.Extra.find
--         (\conversation ->
--             case conversation of
--                 Focus conversationWithMessages ->
--                     True
--
--                 _ ->
--                     False
--         )
--         conversations
--         |> Maybe.map FONCTIONAAJOUTER


view : Model -> Html Msg
view model =
    View.view model


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://localhost:3001/" WebSocketMessage



--affiche le view qui va afficher les 4 parties
---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
