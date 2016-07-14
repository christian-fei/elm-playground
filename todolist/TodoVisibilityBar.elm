module TodoVisibilityBar exposing (Model, Msg, update, view, init, filter)
import Html exposing (..)
import Html.Events exposing(onClick)

type Msg =
  All
  | Uncompleted
  | Completed

type alias Model = Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  (msg, Cmd.none)

init : Model
init = All

view : Model -> Html Msg
view model =
  ul [] (List.map (\(visibilityMsg, displayText) ->
            li [onClick visibilityMsg] [text displayText]
          )
          [(All, "All"), (Uncompleted, "Uncompleted"), (Completed, "Completed")]
        )

filter : Bool -> Msg -> Bool
filter completed msg =
  case msg of
    All          -> True
    Completed    -> completed
    Uncompleted  -> not completed
