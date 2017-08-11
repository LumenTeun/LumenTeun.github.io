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
            scrollTerminalInput Backward model

        ScrollTerminalInputForward ->
            scrollTerminalInput Forward model

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


type ScrollDirection
    = Forward
    | Backward


scrollTerminalInput : ScrollDirection -> Model -> ( Model, Cmd Msg )
scrollTerminalInput scrollDirection model =
    let
        nextCommandHistoryIndex =
            case scrollDirection of
                Backward ->
                    model.commandHistoryIndex - 1

                Forward ->
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
                case scrollDirection of
                    Backward ->
                        update NoOp model

                    Forward ->
                        ( { model
                            | commandHistoryIndex = Array.length model.commandHistory
                            , terminalInput = ""
                          }
                        , Cmd.none
                        )
