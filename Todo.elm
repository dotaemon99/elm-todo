module Todo exposing (..)

import Html exposing (Html, div, input, span, text, h4, h2)
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
  }


newTodo : String -> Int -> Todo
newTodo desc id =
  { description = desc
  , id = id
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


-- VIEW


view : Model -> Html Msg
view model =
  div 
    [ mainStyle ]
    [ todosContainer model ]


todosContainer : Model -> Html Msg
todosContainer model =
  div
    [ todosContainerStyle ]
    [ todosHeader
    , todoInputContainer model.todoInput
    , todoEntries
    ]


todosHeader : Html Msg
todosHeader =
  div
    [ todosHeaderStyle ]
    [ todosDate
    , todosCount
    ]


todosDate : Html Msg
todosDate =
  h2
    [ todosDateStyle ]
    [ text "Wednesday, 8th" ]


todosCount : Html Msg
todosCount =
  h4
    [ todosCountStyle ]
    [ text "0 task" ]


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


todoEntries : Html Msg
todoEntries = 
  div
    [ todoEntriesStyle ]
    [ todoEntry ]


todoEntry : Html Msg
todoEntry = 
  div
    [ todoEntryStyle ]
    [ todoCheckBox
    , todoLabel
    ]


todoCheckBox : Html Msg
todoCheckBox =
  input
    [ todoCheckBoxStyle
    , type_ "checkbox"
    ]
    []


todoLabel : Html Msg
todoLabel =
  span
    [ todoLabelStyle ]
    [ text "test" ]


-- VIEW STYLING


mainStyle : Html.Attribute Msg
mainStyle =
  style
    [ ( "textAlign", "center" )
    , ( "background", "url('./background.jpeg')" )
    , ( "height", "100%" )
    , ( "backgroundSize", "100%" )
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


todosDateStyle : Html.Attribute Msg
todosDateStyle =
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
    , ( "paddingBottom", "1em" )
    , ( "paddingTop", "1em" )
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
    [ ( "marginRight", "1em" )
    , ( "alignSelf", "center" )
    , ( "paddingTop", "0.5em" )
    ]


todoLabelStyle : Html.Attribute Msg
todoLabelStyle =
  style
    [ ( "fontSize", "1em" )
    , ( "color", "#707070" )
    , ( "fontFamily", "Verdana" )
    , ( "fontWeight", "normal" )
    ]