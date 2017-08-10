module Terminal.View exposing (terminal)

import Html exposing (Html, label, input, span, div, text, a)
import Html.Attributes exposing (checked, title, href, type_)
import Html.Events exposing (onMouseEnter, onMouseLeave, onClick)
import Html.CssHelpers
import Model exposing (Model)
import Update exposing (Msg(..))
import Terminal.Style as Style


{ class } =
    Html.CssHelpers.withNamespace Style.namespace


terminal : Model -> Html Msg
terminal model =
    div
        [ class [ Style.Terminal ] ]
        [ div
            [ class [ Style.Output ] ]
            []
        , div
            [ class [ Style.Input ] ]
            [ div [ class [ Style.InputPrompt ] ] [ text "λ" ]
            , input [ class [ Style.InputInput ] ] []
            ]
        ]
