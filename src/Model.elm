module Model
    exposing
        ( Model
        , init
        )


type alias Model =
    { commandHistory : List String
    }


init : ( Model, Cmd msg )
init =
    ( { commandHistory = [] }
    , Cmd.none
    )
