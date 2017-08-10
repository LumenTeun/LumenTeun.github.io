module Main exposing (main)

import Html
import View exposing (view)
import Model exposing (init)
import Update exposing (update)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
