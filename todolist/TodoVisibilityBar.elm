module TodoVisibilityBar exposing (Model, Msg, update, view, init)
import Html exposing (..)
import Html.Events exposing(onClick)

type Msg =
  All
  | Uncompleted
  | Completed

type alias Model = String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    All           -> ("All", Cmd.none)
    Completed     -> ("Completed", Cmd.none)
    Uncompleted   -> ("Uncompleted", Cmd.none)

init : Model
init = "All"


view : Model -> Html Msg
view model =
  ul [] (List.map (\(visibilityMsg, displayText) ->
            li [onClick visibilityMsg] [text displayText]
          )
          [(All, "All"), (Uncompleted, "Uncompleted"), (Completed, "Completed")]
        )
