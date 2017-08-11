module Update
    exposing
        ( Msg(..)
        , update
        )

import Model exposing (Model)
import Constants exposing (terminalInputId, terminalId)
import Dom
import Dom.Scroll
import Task


type Msg
    = NoOp
    | FocusTerminalInput
    | TaskResult (Result Dom.Error ())
    | SetTerminalInput String
    | RunCommand
    | ClearTerminalOutput
    | ClearTerminalInput


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FocusTerminalInput ->
            ( model
            , terminalInputId
                |> Dom.focus
                |> Task.attempt TaskResult
            )

        TaskResult result ->
            update NoOp model

        SetTerminalInput text ->
            ( { model | terminalInput = text }, Cmd.none )

        ClearTerminalOutput ->
            ( { model | terminalOutput = [] }, Cmd.none )

        ClearTerminalInput ->
            ( { model | terminalInput = "" }, Cmd.none )

        RunCommand ->
            let
                command =
                    model.terminalInput

                nextModelBase =
                    { model
                        | terminalInput = ""
                        , commandHistory = command :: model.commandHistory
                    }

                scrollToBottom =
                    terminalId
                        |> Dom.Scroll.toBottom
                        |> Task.attempt TaskResult
            in
                case command of
                    "clear" ->
                        update ClearTerminalOutput nextModelBase

                    _ ->
                        { nextModelBase
                            | terminalOutput = command :: model.terminalOutput
                        }
                            ! [ scrollToBottom ]

        NoOp ->
            ( model, Cmd.none )
