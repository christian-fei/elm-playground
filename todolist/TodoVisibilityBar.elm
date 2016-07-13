module TodoVisibilityBar exposing (Model, Msg, update, view)
import Html exposing (..)
import Html.Events exposing(onCheck)

type Msg =
  All
  | Uncompleted
  | Completed

type alias Model = Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  (model, Cmd.none)

view : Model -> Html Msg
view model =
  ul [] (List.map (\(visibilityMsg, displayText) ->
            li [onCheck (\_ -> visibilityMsg)] [text displayText]
          )
          [(All, "All"), (Uncompleted, "Uncompleted"), (Completed, "Completed")]
        )
