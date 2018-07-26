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
    ( model, Cmd.none )


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
