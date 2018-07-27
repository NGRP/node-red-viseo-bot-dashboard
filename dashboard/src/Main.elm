module Main exposing (..)

import Http
import Html exposing (Html, text, div, h1, img)
import Model exposing (Msg(..), Model, Filter(..))
import Conversation
import Panels.View as View


---- MODEL ----


init : ( Model, Cmd Msg )
init =
    ( Model [] All, Http.send OnConversationsFetched Conversation.getConversationsRequest )



-- TODO, La fonction request qui sera dans le module
---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
    -- OnMessagesFetched (Err error) ->
    --
    -- OnMessagesFetched (Ok conversationWithMessages) ->

    FocusTab focusedTabId ->
      (model | messages = listMsg, Cmd.none)
    OnConversationsFetched (Err error) ->
      (model | conversations = [], Cmd.none)
    OnConversationsFetched (Ok conversationsList)->
      (model | conversations = conversationsList, Cmd.none)
    -- OpenConversation conversation ->

    FilterConversation filtre ->
        ( { model | currentFilter = filtre }, Cmd.none)

putMessagesInFocusedConversation Model -> ConversationWithMessages -> Model
putMessagesInFocusedConversation model conversationWithMessages =

List.Extra.find
    (\conversation ->
        case conversation of
            Focus conversationWithMessages ->
                True

            _ ->
                False
    )
    conversations
    |> Maybe.map FONCTIONAAJOUTER






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
