module Api exposing (getTodos)
import Http as Http
import Json.Decode as Json
import Task


type Msg =
  FetchSucceed String
  | FetchFail Http.Error


apiBaseUrl : String
apiBaseUrl = "//pomodoro.cc/api"

--getTodos : (Http.RawError -> a) -> (Http.Response -> a) -> Cmd a
getTodos : Platform.Task Http.Error String
getTodos =
  let
    url = apiBaseUrl ++ "/todos"
    config =  { verb = "GET"
              , headers = [("Authorization", "REPLACE_THIS")]
              , url = url
              , body = Http.empty
              }
    request = Http.send Http.defaultSettings config
  in
    handleRequest request

decodePomodori : Json.Decoder String
decodePomodori =
  Json.at [] Json.string

--handleRequest : Task.Task Http.RawError Http.Response -> (Http.RawError -> a) -> (Http.Response -> a) -> Cmd a
handleRequest : Task.Task Http.RawError Http.Response -> Platform.Task Http.Error String
handleRequest task error response =
  Task.perform FetchFail FetchSucceed task
