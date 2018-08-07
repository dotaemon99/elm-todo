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

view model =
  div 
    [ css
        [
        ]
    ]
    [ span
      [ css
          [ color (rgb 70 70 70)
          , fontSize (px 32)
          ]
      ]
      [ text "Todos" ]
    ]