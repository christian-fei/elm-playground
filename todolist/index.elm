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
  AddTodo String
  | TodoInputChanged String

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
    AddTodo text ->
      ({model | todos = (addTodo {text = text, completed = False} model.todos)}, Cmd.none)

view : Model -> Html Msg
view model =
  main' []
    [ h1 [] [text "Todolist"]
    , ul [] (
      List.map (\t -> (li []
        [ span [] [text t.text]
        , input [type' "checkbox", checked t.completed] []
        ])) model.todos
      )
    , input [onInput TodoInputChanged] []
    , button [onClick (AddTodo model.todoInput)] [text "Add todo"]]
