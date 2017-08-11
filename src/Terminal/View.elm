module Terminal.View exposing (terminal)

import Html exposing (Html, input, div, text)
import Html.Attributes exposing (value, id)
import Html.Events exposing (on, onInput, onClick)
import Html.Events.Extra exposing (onEnter)
import Html.CssHelpers
import Json.Decode as Json
import Model exposing (Model)
import Update exposing (Msg(..))
import Terminal.Style as Style
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


type alias KeyCombination =
    { key : String
    , ctrlKey : Bool
    }


handleKeyCombination : Html.Attribute Msg
handleKeyCombination =
    (Json.map2 KeyCombination
        (Json.field "key" Json.string)
        (Json.field "ctrlKey" Json.bool)
    )
        |> Json.andThen
            (\{ ctrlKey, key } ->
                if ctrlKey then
                    Json.succeed <| getKeyBinding key
                else
                    Json.fail "No ctrl"
            )
        |> on "keydown"


getKeyBinding : String -> Msg
getKeyBinding key =
    case key of
        "l" ->
            ClearTerminalOutput

        "L" ->
            ClearTerminalOutput

        "u" ->
            ClearTerminalInput

        "U" ->
            ClearTerminalInput

        _ ->
            NoOp
