module Main exposing (..)

import Http
import Html exposing (Html, text, div, h1, img)
import Model exposing (Msg(..), Model, Filter(..), ApplicationConversation(..), Conversation)
import Conversation exposing (getConversationWithMessagesRequest, toConversationWithMessages, toConversation)
import Panels.View as View
import List.Extra


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

        FilterConversation filter ->
            ( { model | currentFilter = filter }, Cmd.none )

        _ ->
            ( model, Cmd.none )


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



--affiche le view qui va afficher les 4 parties
---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
