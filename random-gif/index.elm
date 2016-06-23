import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Task



main =
  Html.program
    { init = init "cats"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { topic : String
  , gifUrl : String
  , loading: Bool
  }


init : String -> (Model, Cmd Msg)
init topic =
  ( Model topic "waiting.gif" True
  , getRandomGif topic
  )



-- UPDATE


type Msg
  = MorePlease
  | TopicChanged String
  | FetchSucceed String
  | FetchFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      ({model | loading = True}, getRandomGif model.topic)

    TopicChanged newTopic ->
      ({model | topic = newTopic}, Cmd.none)

    FetchSucceed newUrl ->
      (Model model.topic newUrl False, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)



-- VIEW


view : Model -> Html Msg
view model =
  let loadingText = if model.loading == True then "loading..." else ""
  in
    div []
      [ input [value model.topic, onInput TopicChanged] []
      , button [ onClick MorePlease ] [ text "More Please!" ]
      , span [] [text loadingText]
      , br [] []
      , img [src model.gifUrl] []
      ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "//api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string
