import Html.App as App
import Html exposing(..)


main : Program Never
main =
  App.program
    { init = init
    , subscriptions = subscriptions
    , view = view
    , update = update}


type alias Model = {}

type Msg =
  Noop

init : (Model, Cmd Msg)
init =
  (Model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  text "Hello"

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  (model, Cmd.none)
