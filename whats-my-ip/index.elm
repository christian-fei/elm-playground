--import Html.App as App
import Html exposing(..)
--import Html.Events exposing(..)
--import Html.Attributes exposing(value)
import Http
import TimeTravel.Html.App as TimeTravel
import Json.Decode as Json exposing ((:=))
import Task

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
  DoNothing
  | RequestIP
  | UpdateIP (Maybe String)

init : (Model, Cmd Msg)
init = (Model "Unknown IP", Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    RequestIP -> (model, requestIp)
    _         -> (model, Cmd.none)

view : Model -> Html Msg
view model = text "42"


---
jsonIpUrl = "http://jsonip.com"

requestIp : Cmd Msg
requestIp =
  Task.map UpdateIP (Task.toMaybe (Http.get extractIpField "http://jsonip.com"))
  --Http.get ("ip" := Json.string) "http://jsonip.com"
  --  |> Task.toMaybe
  --  |> Task.map UpdateIP
  --  |> Task

extractIpField : Json.Decoder String
extractIpField =
  Json.at ["ip"] Json.string
