import Html.App as App
import Html exposing(..)


main : Program Never
main =
  App.program
    { init = init
    , subscriptions = subscriptions
    , view = view
    , update = update}


type alias Model =
  { timestamp : Maybe Int
  }

type Msg =
  Noop

init : (Model, Cmd Msg)
init =
  (Model Maybe.Nothing, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  case model.timestamp of
    Maybe.Nothing ->
      text "No current time"
    Just timestamp ->
      text ("Hello" ++ (toString timestamp))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  (model, Cmd.none)
