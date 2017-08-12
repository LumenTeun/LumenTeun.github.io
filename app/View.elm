module View exposing (view)

import Html exposing (Html)
import Model exposing (Model)
import Update exposing (Msg(..))
import Terminal.View exposing (terminal)
import Desktop.View exposing (desktop, window)


view : Model -> Html Msg
view model =
    desktop
        [ window "Terminal"
            [ terminal model
            ]
        ]
