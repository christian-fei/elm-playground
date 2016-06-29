import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import List
import Todo exposing (..)
import TodoUtils exposing (..)
import Json.Encode exposing (encode)

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
  Noop
  | AddTodo Todo.Model
  | TodoInputChanged String
  | TodoCompleted Todo.Model Bool
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
    --TodoMsg subMsg ->
    --  let
    --    (updatedWidgetModel, widgetCmd) =
    --      Todo.update subMsg model.todos
    --  in
    --    (model, Cmd.none)
    --    --({ model | widgetModel = updatedWidgetModel }, Cmd.map TodoMsg widgetCmd)
    unhandled ->
      let
        something = encode 0 unhandled
        unhandled = Debug.log "-- unhandled" unhandled
      in
        (model, Cmd.none)

view : Model -> Html Msg
view model =
  main' []
    [ h1 [] [text "Todolist"]
    , ul [] (List.map renderTodo model.todos)
    , input [onInput TodoInputChanged] []
    , button [disabled (alreadyPresentTodo model.todoInput model.todos), onClick (newTodoFrom model.todoInput)] [text "Add todo"]]

newTodoFrom : String -> Msg
newTodoFrom text =
  AddTodo {text = text, completed = False}

renderTodo : Todo.Model -> Html Msg
renderTodo = App.map TodoMsg << Todo.view
