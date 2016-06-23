import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task

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
  EchoRequest String | EchoResponse String

init : (Model, Cmd Msg)
init =
  ( Model "" "" False 0
  , Cmd.none
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    EchoRequest text ->
      ({model | output = "", waiting = True, waitingTime = 666}, Cmd.none)
    EchoResponse text ->
      ({model | input = "", output = text, waiting = False, waitingTime = 0}, Cmd.none)

view : Model -> Html Msg
view model =
  div []
    [ input [type' "text", value model.input] [],
      br [] [],
      span [] [text model.output],
      br [] [],
      button [] [text "Echo this"],
      br [] [],
      span [] [text "Waiting time: TODO"]
    ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
