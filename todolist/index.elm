import Html exposing (..)
import Html.App as App
import TimeTravel.Html.App as TimeTravel
import Html.Attributes exposing(value)
import Html.Events exposing (..)
import List
import String
import Todo exposing (..)

main : Program Never
main =
  TimeTravel.program
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
      ({model | todos = (todo :: model.todos), todoInput = ""}, Cmd.none)
    TodoMsg todoId subMsg ->
      let
        todos = List.map (mapTodoFrom subMsg todoId) model.todos
      in
        ({model | todos = todos}, Cmd.none)


view : Model -> Html Msg
view model =
  main' []
    [ h1 [] [text "Todolist"]
    , ul [] (List.map renderTodo model.todos)
    , form [onSubmit (newTodoFrom model.todoInput model.todos)]
      [ input [value model.todoInput, onInput TodoInputChanged] []
      , button []
               [text "Add"]]]

newTodoFrom : String -> List Todo.Model -> Msg
newTodoFrom text todos =
  AddTodo {id = (List.length todos), text = (String.trim text), completed = False}

mapTodoFrom : Todo.Msg -> Int -> Todo.Model -> Todo.Model
mapTodoFrom subMsg todoId todo =
  if todo.id == todoId then
    Todo.update subMsg todo
    |> first
  else
    todo


renderTodo : Todo.Model -> Html Msg
renderTodo model =
  App.map (TodoMsg model.id) (Todo.view model)

first : (a, b) -> a
first (x,_) = x
