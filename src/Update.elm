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
import Array.Hamt as Array


type Msg
    = NoOp
    | FocusTerminalInput
    | TaskResult (Result Dom.Error ())
    | SetTerminalInput String
    | RunCommand
    | ClearTerminalOutput
    | ClearTerminalInput
    | ScrollTerminalInputBack
    | ScrollTerminalInputForward


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

        ScrollTerminalInputBack ->
            let
                nextCommandHistoryIndex =
                    model.commandHistoryIndex - 1

                maybeNextTerminalInput =
                    Array.get nextCommandHistoryIndex model.commandHistory
            in
                case maybeNextTerminalInput of
                    Just nextTerminalInput ->
                        ( { model
                            | commandHistoryIndex = nextCommandHistoryIndex
                            , terminalInput = nextTerminalInput
                          }
                        , Cmd.none
                        )

                    Nothing ->
                        update NoOp model

        ScrollTerminalInputForward ->
            let
                nextCommandHistoryIndex =
                    model.commandHistoryIndex + 1

                maybeNextTerminalInput =
                    Array.get nextCommandHistoryIndex model.commandHistory
            in
                case maybeNextTerminalInput of
                    Just nextTerminalInput ->
                        ( { model
                            | commandHistoryIndex = nextCommandHistoryIndex
                            , terminalInput = nextTerminalInput
                          }
                        , Cmd.none
                        )

                    Nothing ->
                        ( { model
                            | commandHistoryIndex = Array.length model.commandHistory
                            , terminalInput = ""
                          }
                        , Cmd.none
                        )

        RunCommand ->
            let
                command =
                    model.terminalInput

                nextCommandHistory =
                    Array.push command model.commandHistory

                nextModelBase =
                    { model
                        | terminalInput = ""
                        , commandHistory = nextCommandHistory
                        , commandHistoryIndex = Array.length nextCommandHistory
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
