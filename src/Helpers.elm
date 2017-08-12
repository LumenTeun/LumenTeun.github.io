module Helpers exposing (..)

import Html exposing (Html, div, text)
import Update exposing (Msg(..))


line : String -> Html Msg
line txt =
    div [] [ text txt ]
