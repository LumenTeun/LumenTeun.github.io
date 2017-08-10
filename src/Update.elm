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
            ( { model
                | input = text
              }
            , Cmd.none
            )

        RunCommand ->
            ( { model
                | input = ""
                , commandHistory = model.input :: model.commandHistory
              }
            , terminalId
                |> Dom.Scroll.toBottom
                |> Task.attempt TaskResult
            )

        NoOp ->
            ( model, Cmd.none )
