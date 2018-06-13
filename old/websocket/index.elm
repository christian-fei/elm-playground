--import Html.App as App
import Html exposing(..)
import Html.Events exposing(..)
import Html.Attributes exposing(value)
import TimeTravel.Html.App as TimeTravel
import WebSocket

main : Program Never
main =
  TimeTravel.program
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }


websocketUrl : String
websocketUrl = "ws://echo.websocket.org"

type alias Model =
  { messages: List String
    , input : String
  }

type Msg =
  ReceivedMessage String
  | UpdateInput String
  | SendMessage String

init : (Model, Cmd Msg)
init = (Model [] "", WebSocket.send websocketUrl "Test")

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen websocketUrl ReceivedMessage

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ReceivedMessage message ->
      ({model | messages = (message :: model.messages)}, Cmd.none)
    UpdateInput input ->
      ({model | input = input}, Cmd.none)
    SendMessage message ->
      ({model | input = ""}, sendMessage message)

view : Model -> Html Msg
view model =
  div [] [
    ul [] (List.map (\m -> li [] [text m]) model.messages),
    form [onSubmit (SendMessage model.input)] [
      input [onInput UpdateInput, value model.input] []
    ]
  ]


sendMessage : String -> Cmd Msg
sendMessage = WebSocket.send websocketUrl
