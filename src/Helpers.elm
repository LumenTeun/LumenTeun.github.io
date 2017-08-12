module Helpers exposing (..)

import Html exposing (Html, div, text)
import Update exposing (Msg(..))


line : List (Html Msg) -> Html Msg
line =
    div []
