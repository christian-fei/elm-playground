import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL
type alias Model =
  { input : String
  , output : String
  }

model : Model
model =
  Model "" ""



-- UPDATE
type Msg
    = InputChanged String

update : Msg -> Model -> Model
update msg model =
  case msg of
    InputChanged input ->
      { model | output = String.reverse input, input = input }



-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input [ autofocus True, type' "text", placeholder "Input your string here", onInput InputChanged ] [],
      div [] [text model.output],
      div [] [text model.input]
    ]
