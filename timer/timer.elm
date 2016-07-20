port module Timer exposing (main)
import Html exposing (..)
import Html.App as App

type Msg =
  StartTimer Int
  | StopTimer

type alias Model = Int

main : Program Never
main =
  App.program
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }

init : (Model, Cmd Msg)
init = (0, Cmd.none)

port startTimer : (Int -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  startTimer StartTimer

view : Model -> Html Msg
view model =
  text (toString model)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    StartTimer time ->
      (time, Cmd.none)
    _               ->
      (model, Cmd.none)
