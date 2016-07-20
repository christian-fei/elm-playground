import Html exposing (..)
import Html.App as App
import TimeTravel.Html.App as TimeTravel
import Html.Attributes exposing(value)
import Html.Events exposing (..)
import List
import String
import Todo exposing (..)
import TodoVisibilityBar exposing (..)

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
  , visibility : TodoVisibilityBar.Model
  }

type Msg =
  AddTodo Todo.Model
  | TodoInputChanged String
  | TodoMsg Int Todo.Msg
  | TodoVisibilityBarMsg TodoVisibilityBar.Msg

init : (Model, Cmd Msg)
init =
  (Model [] "" TodoVisibilityBar.init, Cmd.none)

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
    TodoVisibilityBarMsg subMsg ->
      let
        visibility = TodoVisibilityBar.update subMsg model.visibility |> first
      in
        ({model | visibility = visibility}, Cmd.none)


view : Model -> Html Msg
view model =
  main' []
    [ h1 [] [text "Todolist"]
    , ul [] (List.map renderTodo (filterVisibility model.visibility model.todos))
    , form [onSubmit (newTodoFrom model.todoInput model.todos)]
      [ input [value model.todoInput, onInput TodoInputChanged] []
      , button []
               [text "Add"]]
      , App.map TodoVisibilityBarMsg (TodoVisibilityBar.view model.visibility)
    ]

filterVisibility : TodoVisibilityBar.Model -> List Todo.Model -> List Todo.Model
filterVisibility visibility todos =
  List.filter (\t -> TodoVisibilityBar.filter t.completed visibility) todos

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
