module TodoUtils exposing (addTodo)
import Todo exposing (..)

addTodo : String -> List Todo -> List Todo
addTodo text todos =
  todos ++ [{text = text}]
