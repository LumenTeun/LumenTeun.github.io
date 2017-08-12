module Model
    exposing
        ( Model
        , init
        )

import Array.Hamt as Array exposing (Array)


type alias Model =
    { commandHistory : Array String
    , commandHistoryIndex : Int
    , terminalOutput : List String
    , terminalInput : String
    }


init : ( Model, Cmd msg )
init =
    ( { commandHistory = Array.empty
      , commandHistoryIndex = -1
      , terminalOutput = []
      , terminalInput = ""
      }
    , Cmd.none
    )
