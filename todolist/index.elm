import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import List

main : Program Never
main =
  Html.program
  { init = init
  , subscriptions = subscriptions
  , update = update
  , view = view
  }

type alias Todo =
  { text :  String
  }

type alias Model =
  { todos : List Todo
  }

type Msg =
  AddTodo String
  | TodoInputChanged String

init : (Model, Cmd Msg)
init = (Model [], Cmd.none)
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    TodoInputChanged text ->
      (model, Cmd.none)
    _ ->
      (model, Cmd.none)
view : Model -> Html Msg
view model =
  main' []
    (List.concat
      [[(h1 [] [text "Todolist"])]
      , (List.map (\x -> (div [] [text x.text])) model.todos)
      , [(input [onInput TodoInputChanged] [])]]
    )
