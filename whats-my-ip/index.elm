--import Html.App as App
import Html exposing(..)
--import Html.Events exposing(..)
--import Html.Attributes exposing(value)
import TimeTravel.Html.App as TimeTravel

main : Program Never
main =
  TimeTravel.program
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }

type alias Model =
  {
    ip: String
  }

type Msg =
  None

init : (Model, Cmd Msg)
init = (Model "Unknown IP", Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    _ -> (model, Cmd.none)

view : Model -> Html Msg
view model = text "42"
