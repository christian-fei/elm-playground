import Html exposing (..)
import Html.App as Html
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
  String

type alias TodoList = List Todo

type alias Model =
  { todos : TodoList
  }

type Msg =
  AddTodo String

init : (Model, Cmd Msg)
init = (Model ["hey", "wassup"], Cmd.none)
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)
view : Model -> Html Msg
view model =
  main' []
    (List.concat
      [[(h1 [] [text "Todolist"])]
      , (List.map (\x -> (div [] [text x])) model.todos)]
    )
