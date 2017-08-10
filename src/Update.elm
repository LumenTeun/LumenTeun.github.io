module Update
    exposing
        ( Msg(..)
        , update
        )

import Model exposing (Model)


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
