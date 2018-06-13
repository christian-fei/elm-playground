module Todo exposing (Model, Msg, update, view)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

type Msg =
  TodoCompleted Bool

type alias Model =
  { id : Int
  , text : String
  , completed : Bool
  }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    TodoCompleted completed ->
      ({model | completed = completed}, Cmd.none)

view : Model -> Html Msg
view todo =
  li []
    [ input [type' "checkbox", checked todo.completed, onCheck TodoCompleted] []
    , span [] [text todo.text]
    ]
