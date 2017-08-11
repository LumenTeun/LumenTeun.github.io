module Terminal.Commands exposing (getOutput, handleKeyCombination)

import Html
import Html.Events exposing (on)
import Json.Decode as Json
import Regex exposing (regex, HowMany(AtMost))
import Update exposing (Msg(..))


getOutput : String -> String
getOutput command =
    let
        ( cmd, tail ) =
            case splitAtFirstWhitespace command of
                cmd :: tail :: _ ->
                    ( cmd, tail )

                cmd :: _ ->
                    ( cmd, "" )

                _ ->
                    ( "", "" )
    in
        case cmd of
            "echo" ->
                tail

            "hello" ->
                "hi :)"

            "" ->
                ""

            _ ->
                "ash: command not found: " ++ command


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
                    Json.succeed <| getCtrlKeyBinding key
                else
                    Json.succeed <| getKeyBinding key
            )
        |> on "keydown"


getCtrlKeyBinding : String -> Msg
getCtrlKeyBinding key =
    case (String.toLower key) of
        "l" ->
            ClearTerminalOutput

        "u" ->
            ClearTerminalInput

        "p" ->
            ScrollTerminalInputBack

        "n" ->
            ScrollTerminalInputForward

        _ ->
            NoOp


getKeyBinding : String -> Msg
getKeyBinding key =
    case (String.toLower key) of
        "arrowup" ->
            ScrollTerminalInputBack

        "arrowdown" ->
            ScrollTerminalInputForward

        _ ->
            NoOp


splitAtFirstWhitespace : String -> List String
splitAtFirstWhitespace =
    Regex.split (AtMost 1) (regex "\\s+")
