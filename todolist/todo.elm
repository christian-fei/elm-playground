module Todo exposing (Model, Msg, update, view)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

type Msg =
  TodoCompleted Model Bool

type alias Model =
  { id : Int
  , text : String
  , completed : Bool
  }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    TodoCompleted todo completed ->
      if model.id == todo.id then
        ({model | completed = completed}, Cmd.none)
      else
        (model, Cmd.none)

view : Model -> Html Msg
view todo =
  li []
    [ span [] [text (toString todo.id)]
    , input [type' "checkbox", checked todo.completed, onCheck (TodoCompleted todo)] []
    , span [] [text todo.text]
    , span [] [text (if todo.completed then "✓" else "✖️")]
    ]
