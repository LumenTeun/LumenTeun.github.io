module Terminal.View exposing (terminal)

import Html exposing (Html, input, div, text)
import Html.Attributes exposing (value, id)
import Html.Events exposing (onInput, onClick)
import Html.Events.Extra exposing (onEnter)
import Html.CssHelpers
import Model exposing (Model)
import Update exposing (Msg(..))
import Terminal.Style as Style
import Constants exposing (inputId, terminalId)


{ class } =
    Html.CssHelpers.withNamespace Style.namespace


terminal : Model -> Html Msg
terminal model =
    div
        [ class [ Style.Terminal ]
        , onClick FocusInput
        , id terminalId
        ]
        [ div
            [ class [ Style.Output ] ]
            (model.renderedCommands
                |> List.reverse
                |> List.map viewOutput
            )
        , div
            [ class [ Style.Input ] ]
            [ prompt
            , input
                [ onInput SetInput
                , onEnter RunCommand
                , value model.input
                , class [ Style.InputInput ]
                , id inputId
                ]
                []
            ]
        ]


viewOutput : String -> Html Msg
viewOutput command =
    div []
        [ div [ class [ Style.OutputLine ] ]
            [ prompt
            , text command
            ]
        , getOutput command
        ]


getOutput : String -> Html Msg
getOutput command =
    case command of
        "" ->
            text ""

        _ ->
            div [] [ text ("ash: command not found: " ++ command) ]


prompt : Html Msg
prompt =
    div
        [ class [ Style.Prompt ] ]
        [ text "λ" ]
