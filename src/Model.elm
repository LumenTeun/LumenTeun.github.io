module Model
    exposing
        ( Model
        , init
        )


type alias Model =
    { commandHistory : List String
    , renderedCommands : List String
    , input : String
    }


init : ( Model, Cmd msg )
init =
    ( { commandHistory = []
      , renderedCommands = []
      , input = ""
      }
    , Cmd.none
    )
