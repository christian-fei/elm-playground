import Html exposing (..)
import Html.App as Html

main : Program Never
main =
  Html.program
  { init = init
  , subscriptions = subscriptions
  , update = update
  , view = view
  }

type alias Model = ()

type Msg = Noop

init : (Model, Cmd Msg)
init =
  ((), Cmd.none)
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)
view : Model -> Html Msg
view model = text "Todolist"
