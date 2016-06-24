import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task
import Random
import String
import Process
import Debug

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { input: String
  , output: String
  , waiting: Bool
  , waitingTime: Int
  }

type Msg =
  EchoRequest String | EchoResponse String | HandleEchoRequest Int String | ProcessEchoRequest Int String


init : (Model, Cmd Msg)
init =
  ( Model "" "" False 0
  , Cmd.none
  )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ProcessEchoRequest waitingTime text ->
      (model, Cmd.none)
    HandleEchoRequest waitingTime text ->
      (model, Cmd.none)
    EchoRequest text ->
      ({model | output = "", waiting = True, waitingTime = 666}, processEchoRequest text 666)
    EchoResponse text ->
      ({model | input = "", output = text, waiting = False, waitingTime = 0}, Cmd.none)


view : Model -> Html Msg
view model =
  div []
    [ input [type' "text", value model.input] [],
      br [] [],
      span [] [text model.output],
      br [] [],
      button [onClick (EchoRequest model.input)] [text "Echo this"],
      br [] [],
      span [] [text (String.append "Waiting time: " (toString model.waitingTime))]
    ]


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


processEchoRequest : String -> Float -> Cmd Msg
processEchoRequest text waitingTime =
  Task.perform (\x -> x) (\x -> EchoResponse text) (Process.sleep waitingTime)
