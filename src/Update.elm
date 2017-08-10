module Update
    exposing
        ( Msg(..)
        , update
        )

import Model exposing (Model)
import Constants exposing (inputId)
import Dom
import Task


type Msg
    = NoOp
    | FocusInput
    | FocusInputResult (Result Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FocusInput ->
            ( model
            , Dom.focus inputId
                |> Task.attempt FocusInputResult
            )

        FocusInputResult result ->
            update NoOp model

        NoOp ->
            ( model, Cmd.none )
