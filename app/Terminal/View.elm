module Terminal.View exposing (terminal)

import Html exposing (Html, input, div, text)
import Html.Attributes exposing (value, id, attribute)
import Html.Events exposing (onInput, onClick)
import Html.Events.Extra exposing (onEnter)
import Html.CssHelpers
import Model exposing (Model)
import Update exposing (Msg(..))
import Terminal.Css as Css
import Terminal.Commands exposing (getOutput, handleKeyCombination)
import Constants exposing (terminalInputId, terminalId)


terminal : Model -> Html Msg
terminal model =
    div
        [ Css.terminal
        , onClick FocusTerminalInput
        , handleKeyCombination
        , id terminalId
        ]
        [ div
            []
            (model.terminalOutput
                |> List.reverse
                |> List.map viewOutput
            )
        , div
            [ Css.input ]
            [ prompt
            , input
                [ onInput SetTerminalInput
                , onEnter RunCommand
                , value model.terminalInput
                , Css.inputInput
                , id terminalInputId
                , attribute "aria-label" "terminal input"
                ]
                []
            ]
        ]


viewOutput : String -> Html Msg
viewOutput command =
    div [] <|
        div [ Css.outputLine ]
            [ prompt
            , text command
            ]
            :: getOutput command


prompt : Html Msg
prompt =
    div
        [ Css.prompt ]
        [ text "λ " ]
