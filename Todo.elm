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
    [ div
      [ css [] ]
      [ h2
        [ css [] ]
        [ text "Wednesday, 8th" ]
      ]
    ]
    