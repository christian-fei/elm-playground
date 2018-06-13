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
  | RequestIPSuccess (String)
  | RequestIPFail Http.Error

init : (Model, Cmd Msg)
init = (Model "Unknown IP", requestIp)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    RequestIPSuccess ip ->
      ({model | ip = ip}, Cmd.none)
    _                   -> (model, Cmd.none)

view : Model -> Html Msg
view model = text model.ip


---
jsonIpUrl : String
jsonIpUrl = "http://jsonip.com"

requestIp : Cmd Msg
requestIp =
  Task.perform RequestIPFail RequestIPSuccess (Http.get decodeResponse "http://jsonip.com")

decodeResponse : Json.Decoder String
decodeResponse =
  Json.at ["ip"] Json.string
