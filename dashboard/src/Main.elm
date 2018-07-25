module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Model
import Conversation


---- MODEL ----


type alias Model =
    { conversations : List Conversation }


init : ( Model, Cmd Msg )
init =
    ( Model [], Http.send OnConversationsFetched Conversation.getConversationsRequest )



-- TODO, La fonction request qui sera dans le module
---- UPDATE ----


type Msg
    = OnTabsFetched (Result Http.Error (List Tab))
    | OnTabFetched (Result Http.Error Tab)
    | FocusTab String
    | DeleteTab String
    | OnConversationsFetched (Result Http.Error (List Conversation))
    | OpenConversation Conversation
    | FilterConversation Filtre
    | WebSocketTest String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = always Sub.none
        }
