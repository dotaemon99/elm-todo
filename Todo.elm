module Todo exposing (..)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)

main = Html.beginnerProgram { model = 0, view = view >> toUnstyled, update = update }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

view : any -> Html Msg
view model =
  div 
    [ css 
      [ textAlign center
      , backgroundImage (url "./background.jpeg")
      , backgroundSize cover
      , Css.height (pct 100)
      , paddingTop (vh 20)
      ] 
    ]
    [ todosContainer ]

todosContainer : Html msg
todosContainer =
  div
    [ css 
      [ Css.height (vh 40)
      , marginLeft (pct 25)
      , marginRight (pct 25)
      ]
    ]
    [ todosHeader
    , todoInput
    , todoEntries
    ]
    
todosHeader : Html msg
todosHeader =
  div
    [ css 
      [ padding (Css.em 3)
      , paddingTop (Css.em 1.5)
      , paddingBottom (Css.em 1.5)
      , backgroundColor (rgb 252 252 252)
      , displayFlex
      , flexDirection row
      , borderTopLeftRadius (Css.em 0.5)
      , borderTopRightRadius (Css.em 0.5)
      ] 
    ]
    [ h2
      [ css 
        [ fontSize (Css.em 1.8)
        , color (rgb 255 87 51)
        , textAlign left
        , fontFamilies [ "Helvetica" ] 
        ] 
      ]
      [ text "Wednesday, 8th" ],
      h4
      [ css 
        [ fontSize (Css.em 1.2)
        , color (rgb 175 175 175)
        , textAlign right
        , fontFamilies [ "Verdana" ]
        , fontWeight normal
        , alignSelf center
        , flex (int 1)
        ] 
      ]
      [ text "0 task" ]
    ]

todoInput : Html msg
todoInput =
  div
    [ css 
      [ padding (Css.em 3)
      , paddingBottom (Css.em 2)
      , paddingTop (Css.em 2)
      , backgroundColor (rgb 255 255 255)
      , border (px 0)
      , borderBottom (px 0.25)
      , borderTop (px 0.25)
      , borderColor (rgb 238 238 238)
      , borderStyle solid
      ] 
    ]
    [ input
      [ type_ "text"
      , placeholder "What is your main focus for today?"
      , css 
        [ Css.width (pct 100)
        , Css.height (pct 100)
        , border (px 0)
        , fontSize (Css.em 1.5)
        , fontWeight normal
        , outline none
        ]
      ]
      []
    ]

todoEntries : Html msg
todoEntries = 
  div
    [ css
      [ paddingBottom (Css.em 1.5)
      , backgroundColor (rgb 255 255 255)
      , borderBottomLeftRadius (Css.em 0.5)
      , borderBottomRightRadius (Css.em 0.5)
      ]
    ]
    []