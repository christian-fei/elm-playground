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
  | TodoMsg Todo.Msg

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
    TodoCompleted todo completed ->
      (model, Cmd.none)
    _ ->
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  main' []
    [ h1 [] [text "Todolist"]
    , ul [] (
      List.map renderTodo model.todos)
    , input [onInput TodoInputChanged] []
    , button [disabled (alreadyPresentTodo model.todoInput model.todos), onClick (newTodoFrom model.todoInput)] [text "Add todo"]]

newTodoFrom : String -> Msg
newTodoFrom text =
  AddTodo {text = text, completed = False}

renderTodo : Todo -> Html Msg
renderTodo todo =
  Html.map TodoMsg (Todo.view todo)
