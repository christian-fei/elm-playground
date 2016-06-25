module Todo exposing (Todo, Msg, view)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

type Msg =
  TodoCompleted Todo Bool

type alias Todo =
  { text : String
  , completed : Bool
  }

view : Todo -> Html Msg
view todo =
  li []
    [ input [type' "checkbox", checked todo.completed, onCheck (TodoCompleted todo)] []
    , span [] [text todo.text]
    ]
