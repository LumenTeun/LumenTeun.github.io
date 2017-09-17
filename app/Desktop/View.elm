module Desktop.View exposing (desktop, window)

import Html exposing (div, text)
import Html.Attributes exposing (checked, title, href, type_)
import Desktop.Css as Css
import Html.CssHelpers


desktop children =
    div
        [ Css.desktop ]
        children


window name children =
    div [ Css.window ]
        [ div [ Css.windowTop ]
            [ text name
            , div [ Css.windowCloseButton ] []
            ]
        , div
            [ Css.windowChildren ]
            children
        ]
