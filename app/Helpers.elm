module Helpers exposing (..)

import Html exposing (Html, div, text, a)
import Html.Attributes exposing (href)
import Update exposing (Msg(..))


line : List (Html Msg) -> Html Msg
line =
    div []


link : String -> String -> Html Msg
link url txt =
    a [ href url ]
        [ text txt
        ]
