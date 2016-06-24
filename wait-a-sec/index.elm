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
  , waitingTime: Float
  }

type Msg =
  EchoRequest String
  | EchoResponse String
  | HandleEchoRequest Float String
  | ProcessEchoRequest Float String
  | InputChanged String
  | RandomWaitingTime Float


init : (Model, Cmd Msg)
init =
  ( Model "" "" False 0
  , Cmd.none
  )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    InputChanged text ->
      ({model | input = text}, Cmd.none)
    ProcessEchoRequest waitingTime text ->
      (model, Cmd.none)
    HandleEchoRequest waitingTime text ->
      (model, Cmd.none)
    RandomWaitingTime mills ->
      ({model | waitingTime = mills}, processEchoRequest model.input mills)
    EchoRequest text ->
      let
        waitingTime = (Random.generate RandomWaitingTime (Random.float 1 1000))
      in
        (model, waitingTime)
    EchoResponse text ->
      ({model | output = text, waiting = False, waitingTime = 0}, Cmd.none)


view : Model -> Html Msg
view model =
  div []
    [ input [value model.input, onInput InputChanged] [],
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
  Task.perform (\x -> x) (\x -> EchoResponse (String.reverse text)) (Process.sleep waitingTime)
