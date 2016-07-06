import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import List
import Todo exposing (..)
import TodoUtils exposing (..)

main : Program Never
main =
  App.program
  { init = init
  , subscriptions = subscriptions
  , update = update
  , view = view
  }

type alias Model =
  { todos : List Todo.Model
  , todoInput : String
  }

type Msg =
  AddTodo Todo.Model
  | TodoInputChanged String
  | TodoMsg Int Todo.Msg

init : (Model, Cmd Msg)
init =
  (Model [{id = 0, text = "ciao", completed = False}] "", Cmd.none)

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
    TodoMsg todoId subMsg ->
      let
        todos = List.map (todoFrom subMsg todoId) model.todos
      in
        ({model | todos = todos}, Cmd.none)

todoFrom : Todo.Msg -> Int -> Todo.Model -> Todo.Model
todoFrom subMsg todoId todo =
  if todo.id == todoId then
    Todo.update subMsg todo
    |> first
  else
    todo


view : Model -> Html Msg
view model =
  main' []
    [ h1 [] [text "Todolist"]
    , ul [] (List.map renderTodo model.todos)
    , input [onInput TodoInputChanged] []
    , button [disabled (alreadyPresentTodo model.todoInput model.todos), onClick (newTodoFrom model.todoInput model.todos)] [text "Add todo"]]

newTodoFrom : String -> List Todo.Model -> Msg
newTodoFrom text todos =
  AddTodo {id = (List.length todos), text = text, completed = False}

renderTodo : Todo.Model -> Html Msg
renderTodo model =
  App.map (TodoMsg model.id) (Todo.view model)

first : (a, b) -> a
first (x,_) = x
