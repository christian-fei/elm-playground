module TodoUtils exposing (addTodo)
import Todo exposing (..)

addTodo : Todo -> List Todo -> List Todo
addTodo todo todos =
  todos ++ [todo]
