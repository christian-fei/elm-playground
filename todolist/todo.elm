module Todo exposing (Model, Msg, update, view)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

type Msg =
  TodoCompleted Model Bool

type alias Model =
  { text : String
  , completed : Bool
  }

update : Msg -> List Model -> (List Model, Cmd Msg)
update msg model =
  case msg of
    _ ->
      (model, Cmd.none)
    --TodoCompleted todo completed ->
    --  let
    --    _ = Debug.log "" msg
    --  in
    --    ({model | completed = completed}, Cmd.none)

view : Model -> Html Msg
view todo =
  li []
    [ input [type' "checkbox", checked todo.completed, onCheck (TodoCompleted todo)] []
    , span [] [text todo.text]
    , span [] [text (if todo.completed then "✓" else "✖️")]
    ]
