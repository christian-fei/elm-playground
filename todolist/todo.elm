module Todo exposing (Model, Msg)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

type Msg =
  TodoCompleted Model Bool

type alias Model =
  { text : String
  , completed : Bool
  }

--view : Model -> Html Msg
--view todo =
--  li []
--    [ input [type' "checkbox", checked todo.completed, onCheck (TodoCompleted todo)] []
--    , span [] [text todo.text]
--    , span [] [text (if todo.completed then "✓" else "✖️")]
--    ]
