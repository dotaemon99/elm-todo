module Todo exposing (..)

import Html exposing (Html, div, input, span, text, h4, h2, button)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json

main = Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL


-- The full application state of our todo app.
type alias Model =
  { todos : List Todo
  , todoInput : String
  , uid : Int
  }


type alias Todo =
  { description : String
  , id : Int
  , completed : Bool
  }


newTodo : String -> Int -> Todo
newTodo desc id =
  { description = desc
  , id = id
  , completed = False
  }


model: Model
model = 
  { todos = []
  , todoInput = ""
  , uid = 0
  }


-- UPDATE


type Msg 
  = Add 
  | UpdateInput String
  | UpdateStatus Int Bool
  | DeleteTodo Int

update : Msg -> Model -> Model
update msg model =
  case msg of
    Add ->
      { model
        | uid = model.uid + 1
        , todoInput = ""
        , todos =
          if String.isEmpty model.todoInput then
            model.todos
          else
            model.todos ++ [ newTodo model.todoInput model.uid ]
      }
    
    UpdateInput value ->
      { model | todoInput = value }

    UpdateStatus id isCompleted ->
      let
        updatedTodo todo =
          if todo.id == id then
            { todo | completed = isCompleted }
          else
            todo
      in
        { model | todos = List.map updatedTodo model.todos }

    DeleteTodo id ->
      { model | todos = List.filter (\todo -> todo.id /= id) model.todos}


-- VIEW


view : Model -> Html Msg
view model =
  div 
    [ mainStyle ]
    [ todosContainer model ]


todosContainer : Model -> Html Msg
todosContainer model =
  let todosLength = List.length (model.todos)
  in div
    [ todosContainerStyle ]
    [ todosHeader todosLength
    , todoInputContainer model.todoInput
    , todoEntries model.todos
    ]


todosHeader : Int -> Html Msg
todosHeader todosLength =
  div
    [ todosHeaderStyle ]
    [ todosTitle
    , todosCount todosLength
    ]


todosTitle : Html Msg
todosTitle =
  h2
    [ todosTitleStyle ]
    [ text "To-do Application" ]


todosCount : Int -> Html Msg
todosCount todosLength =
  let 
    mappedTodosLength = toString todosLength
    tasksStatement =
      if todosLength > 0 then
        " tasks"
      else " task"
    todosCountStatement = mappedTodosLength ++ tasksStatement
  in
    h4
      [ todosCountStyle ]
      [ text todosCountStatement ]


todoInputContainer : String -> Html Msg
todoInputContainer field =
  div
    [ todoInputContainerStyle ]
    [ todoInput field ]


todoInput : String -> Html Msg
todoInput field =
  input
    [ type_ "text"
    , placeholder "What is your main focus for today?"
    , autofocus True
    , onInput UpdateInput
    , onEnter Add
    , value field
    , todoInputStyle
    ]
    []


onEnter : Msg -> Html.Attribute Msg
onEnter msg =
  let
    isEnter code =
      if code == 13 then
        Json.succeed msg
      else
        Json.fail "not ENTER"
  in
    on "keydown" (Json.andThen isEnter keyCode)


todoEntries : List Todo -> Html Msg
todoEntries todos =
  div
    [ todoEntriesStyle ]
    ( List.map (todoEntry) todos )


todoEntry : Todo -> Html Msg
todoEntry todo = 
  div
    [ todoEntryStyle ]
    [ todoCheckBox todo.id todo.completed
    , todoLabel todo.description todo.completed
    , todoDeleteButton todo.id
    ]


todoCheckBox : Int -> Bool -> Html Msg
todoCheckBox id isCompleted =
  input
    [ todoCheckBoxStyle
    , type_ "checkbox"
    , checked isCompleted
    , onClick (UpdateStatus id (not isCompleted))
    ]
    []


todoLabel : String -> Bool -> Html Msg
todoLabel desc isCompleted =
  span
    [ if isCompleted then
        todoCompleteLabelStyle
      else 
        todoLabelStyle
    ]
    [ text desc ]


todoDeleteButton : Int -> Html Msg
todoDeleteButton id =
  button
    [ todoDeleteButtonStyle
    , onClick (DeleteTodo id)
    ]
    [ text "x" ]


-- VIEW STYLING


mainStyle : Html.Attribute Msg
mainStyle =
  style
    [ ( "textAlign", "center" )
    , ( "background", "url('./background.jpeg')" )
    , ( "height", "100%" )
    , ( "backgroundSize", "cover" )
    , ( "backgroundAttachment", "scroll" )
    ]


todosContainerStyle : Html.Attribute Msg
todosContainerStyle =
  style
    [ ( "height", "40vh" )
    , ( "marginLeft", "25%" )
    , ( "marginRight", "25%" )
    , ( "paddingTop", "20vh" )
    ]


todosHeaderStyle : Html.Attribute Msg
todosHeaderStyle =
  style
    [ ( "padding", "3em" )
    , ( "paddingTop", "1.5em" )
    , ( "paddingBottom", "1.5em" )
    , ( "backgroundColor", "#FCFCFC" )
    , ( "display", "flex" )
    , ( "flexDirection", "row" )
    , ( "borderTopLeftRadius", "0.5em" )
    , ( "borderTopRightRadius", "0.5em" )
    ]


todosTitleStyle : Html.Attribute Msg
todosTitleStyle =
  style
    [ ( "fontSize", "1.8em" )
    , ( "color", "#FF5733" )
    , ( "textAlign", "left" )
    , ( "fontFamily", "Helvetica" )
    ]


todosCountStyle : Html.Attribute Msg
todosCountStyle =
  style
    [ ( "fontSize", "1.2em" )
    , ( "color", "#AFAFAF" )
    , ( "textAlign", "right" )
    , ( "fontFamily", "Verdana" )
    , ( "fontWeight", "normal" )
    , ( "alignSelf", "center" )
    , ( "flex", "1" )
    ]


todoInputContainerStyle : Html.Attribute Msg
todoInputContainerStyle =
  style
    [ ( "padding", "3em" )
    , ( "paddingBottom", "2em" )
    , ( "paddingTop", "2em" )
    , ( "backgroundColor", "white" )
    , ( "border", "0px" )
    , ( "borderTop", "0.25px" )
    , ( "borderBottom", "0.25px" )
    , ( "borderColor", "#EEE" )
    , ( "borderStyle", "solid" )
    ]


todoInputStyle : Html.Attribute Msg
todoInputStyle =
  style
    [ ( "width", "100%" )
    , ( "height", "100%" )
    , ( "border", "0px" )
    , ( "fontSize", "1.5em" )
    , ( "fontWeight", "normal" )
    , ( "outline", "none" )
    ]


todoEntriesStyle : Html.Attribute Msg
todoEntriesStyle =
  style
    [ ( "paddingBottom", "1.5em" )
    , ( "backgroundColor", "white" )
    , ( "borderBottomLeftRadius", "0.5em" )
    , ( "borderBottomRightRadius", "0.5em" )
    ]


todoEntryStyle : Html.Attribute Msg
todoEntryStyle =
  style
    [ ( "padding", "3em" )
    , ( "paddingBottom", "1.25em" )
    , ( "paddingTop", "1.25em" )
    , ( "backgroundColor", "white" )
    , ( "border", "0px" )
    , ( "borderBottom", "0.25px" )
    , ( "borderColor", "#EEE" )
    , ( "borderStyle", "solid" )
    , ( "display", "flex" )
    , ( "flexDirection", "row" )
    ]


todoCheckBoxStyle : Html.Attribute Msg
todoCheckBoxStyle =
  style
    [ ( "marginRight", "2em" )
    , ( "alignSelf", "center" )
    , ( "marginTop", "0.5em" )
    , ( "zoom", "1.5" )
    ]


todoLabelStyle : Html.Attribute Msg
todoLabelStyle =
  style
    [ ( "fontSize", "1.4em" )
    , ( "color", "#707070" )
    , ( "fontFamily", "Helvetica" )
    , ( "fontWeight", "normal" )
    , ( "display" , "flex" )
    , ( "flex", "1" )
    , ( "alignSelf", "center" )
    ]

todoCompleteLabelStyle : Html.Attribute Msg
todoCompleteLabelStyle =
  style
    [ ( "fontSize", "1.4em" )
    , ( "color", "#A0A0A0" )
    , ( "fontFamily", "Helvetica" )
    , ( "fontWeight", "normal" )
    , ( "textDecoration", "line-through" )
    , ( "display" , "flex" )
    , ( "flex", "1" )
    , ( "alignSelf", "center" )
    ]

todoDeleteButtonStyle : Html.Attribute Msg
todoDeleteButtonStyle =
  style
    [ ( "color", "#AB5255" )
    , ( "padding", "0px" )
    , ( "border", "none" )
    , ( "background", "none" )
    , ( "fontSize", "1.5em" )
    ]