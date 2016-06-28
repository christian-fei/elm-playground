module TodoUtils exposing (addTodo, alreadyPresentTodo)
import Todo exposing (..)
import List

addTodo : Todo.Model -> List Todo.Model -> List Todo.Model
addTodo todo todos =
  todos ++ [todo]

alreadyPresentTodo : String -> List Todo.Model -> Bool
alreadyPresentTodo text todos =
  List.member text (List.map .text todos)
