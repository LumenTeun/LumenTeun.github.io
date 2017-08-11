module Terminal.View exposing (terminal)

import Html exposing (Html, input, div, text)
import Html.Attributes exposing (value, id)
import Html.Events exposing (onInput, onClick)
import Html.Events.Extra exposing (onEnter)
import Html.CssHelpers
import Model exposing (Model)
import Update exposing (Msg(..))
import Terminal.Style as Style
import Terminal.Commands exposing (getOutput, handleKeyCombination)
import Constants exposing (terminalInputId, terminalId)


{ class } =
    Html.CssHelpers.withNamespace Style.namespace


terminal : Model -> Html Msg
terminal model =
    div
        [ class [ Style.Terminal ]
        , onClick FocusTerminalInput
        , handleKeyCombination
        , id terminalId
        ]
        [ div
            [ class [ Style.Output ] ]
            (model.terminalOutput
                |> List.reverse
                |> List.map viewOutput
            )
        , div
            [ class [ Style.Input ] ]
            [ prompt
            , input
                [ onInput SetTerminalInput
                , onEnter RunCommand
                , value model.terminalInput
                , class [ Style.InputInput ]
                , id terminalInputId
                ]
                []
            ]
        ]


viewOutput : String -> Html Msg
viewOutput command =
    div [] <|
        div [ class [ Style.OutputLine ] ]
            [ prompt
            , text command
            ]
            :: (command
                    |> getOutput
                    |> List.map (\output -> div [] [ text output ])
               )


prompt : Html Msg
prompt =
    div
        [ class [ Style.Prompt ] ]
        [ text "λ" ]
