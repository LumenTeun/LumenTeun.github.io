module Model
    exposing
        ( Model
        , init
        )


type alias Model =
    { commandHistory : List String
    , input : String
    }


init : ( Model, Cmd msg )
init =
    ( { commandHistory = []
      , input = ""
      }
    , Cmd.none
    )
