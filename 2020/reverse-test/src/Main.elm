module Main exposing (..)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Browser

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model = {
  content: String
  , reversed: String
  , length: Int
  }

init : Model
init = {
  content = ""
  , reversed = ""
  , length = 0
  }


type Msg = Change String
update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent, reversed = String.reverse newContent, length = String.length newContent }

view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
    , div [] [ text model.reversed ]
    , div [] [ text (String.fromInt model.length) ]
    ]