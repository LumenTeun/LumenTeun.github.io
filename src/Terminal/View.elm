module Terminal.View exposing (terminal)

import Html exposing (Html, input, div, text)
import Html.Attributes exposing (value, id)
import Html.Events exposing (onInput, onClick)
import Html.CssHelpers
import Model exposing (Model)
import Update exposing (Msg(..))
import Terminal.Style as Style
import Constants exposing (inputId)


{ class } =
    Html.CssHelpers.withNamespace Style.namespace


terminal : Model -> Html Msg
terminal model =
    div
        [ class [ Style.Terminal ], onClick FocusInput ]
        [ div
            [ class [ Style.Output ] ]
            []
        , div
            [ class [ Style.Input ] ]
            [ div [ class [ Style.InputPrompt ] ] [ text "λ" ]
            , input
                [ onInput SetInput
                , value model.input
                , class [ Style.InputInput ]
                , id inputId
                ]
                []
            ]
        ]
