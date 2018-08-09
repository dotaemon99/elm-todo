module Todo exposing (..)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)

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
      , height (pct 100)
      , paddingTop (vh 20)
      ] 
    ]
    [ todosContainer ]

todosContainer : Html msg
todosContainer =
  div
    [ css 
      [ height (vh 40)
      , marginLeft (pct 25)
      , marginRight (pct 25)
      , backgroundColor (rgb 255 255 255)
      ]
    ]
    [ todosHeader ]
    
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
      , border (px 0)
      , borderBottom (px 0.5)
      , borderColor (rgb 221 221 221)
      , borderStyle solid
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
        , fontFamilies [ "Helvetica" ]
        , alignSelf center
        , flex (int 1)
        ] 
      ]
      [ text "0 task" ]
    ]