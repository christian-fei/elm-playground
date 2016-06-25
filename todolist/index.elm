import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import List
import Todo exposing (..)
import TodoUtils exposing (..)

main : Program Never
main =
  Html.program
  { init = init
  , subscriptions = subscriptions
  , update = update
  , view = view
  }

type alias Model =
  { todos : List Todo
  , todoInput : String
  }

type Msg =
  Noop
  | AddTodo Todo
  | TodoInputChanged String
  | TodoCompleted Todo Bool

init : (Model, Cmd Msg)
init =
  (Model [{text = "ciao", completed = False}] "", Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    TodoInputChanged text ->
      ({model | todoInput = text}, Cmd.none)
    AddTodo todo ->
      ({model | todos = (addTodo todo model.todos)}, Cmd.none)
    _ ->
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  main' []
    [ h1 [] [text "Todolist"]
    , ul [] (
      List.map (\t -> (li []
        [ input [type' "checkbox", checked t.completed, onCheck (TodoCompleted t)] []
        , span [] [text t.text]
        ])) model.todos
      )
    , input [onInput TodoInputChanged] []
    , button [disabled (alreadyPresentTodo model.todoInput model.todos), onClick (AddTodo {text = model.todoInput, completed = False})] [text "Add todo"]]
