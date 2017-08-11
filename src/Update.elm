module Update
    exposing
        ( Msg(..)
        , update
        )

import Model exposing (Model)
import Constants exposing (inputId, terminalId)
import Dom
import Dom.Scroll
import Task


type Msg
    = NoOp
    | FocusInput
    | TaskResult (Result Dom.Error ())
    | SetInput String
    | RunCommand
    | ClearTerminal


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FocusInput ->
            ( model
            , inputId
                |> Dom.focus
                |> Task.attempt TaskResult
            )

        TaskResult result ->
            update NoOp model

        SetInput text ->
            ( { model | input = text }, Cmd.none )

        ClearTerminal ->
            ( { model | renderedCommands = [] }, Cmd.none )

        RunCommand ->
            let
                command =
                    model.input

                nextModelBase =
                    { model
                        | input = ""
                        , commandHistory = command :: model.commandHistory
                    }

                scrollToBottom =
                    terminalId
                        |> Dom.Scroll.toBottom
                        |> Task.attempt TaskResult
            in
                case command of
                    "clear" ->
                        update ClearTerminal nextModelBase

                    _ ->
                        { nextModelBase
                            | renderedCommands = command :: model.renderedCommands
                        }
                            ! [ scrollToBottom ]

        NoOp ->
            ( model, Cmd.none )
