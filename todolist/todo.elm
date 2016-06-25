module Todo exposing (Todo, addTodo)


type alias Todo =
  { text :  String
  }

addTodo : String -> List Todo -> List Todo
addTodo text todos =
  todos ++ [{text = text}]
