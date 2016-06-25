module TodoUtils exposing (addTodo, alreadyPresentTodo)
import Todo exposing (..)
import List

addTodo : Todo -> List Todo -> List Todo
addTodo todo todos =
  todos ++ [todo]

alreadyPresentTodo : String -> List Todo -> Bool
alreadyPresentTodo text todos =
  List.member text (List.map toTodoText todos)

toTodoText : Todo -> String
toTodoText todo =
  todo.text
