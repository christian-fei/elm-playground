import Html.App as App
import Html exposing(..)
import Time exposing (Time, second)


main : Program Never
main =
  App.program
    { init = init
    , subscriptions = subscriptions
    , view = view
    , update = update}


type alias Model =
  { timestamp : Maybe Float
  }

type Msg =
  Noop
  | ReadTimestamp Time

init : (Model, Cmd Msg)
init =
  (Model Maybe.Nothing, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second ReadTimestamp

view : Model -> Html Msg
view model =
  case model.timestamp of
    Maybe.Nothing ->
      text "No current time"
    Just timestamp ->
      text ("Current time: " ++ (toString timestamp))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Noop ->
      (model, Cmd.none)
    ReadTimestamp currentTime ->
      ({model | timestamp = Just currentTime}, Cmd.none)

