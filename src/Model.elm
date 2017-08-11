module Model
    exposing
        ( Model
        , init
        )


type alias Model =
    { commandHistory : List String
    , terminalOutput : List String
    , terminalInput : String
    }


init : ( Model, Cmd msg )
init =
    ( { commandHistory = []
      , terminalOutput = []
      , terminalInput = ""
      }
    , Cmd.none
    )
