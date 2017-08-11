module Desktop.View exposing (desktop, window)

import Html exposing (div, text)
import Html.Attributes exposing (checked, title, href, type_)
import Desktop.Style as Style
import Html.CssHelpers


{ class } =
    Html.CssHelpers.withNamespace Style.namespace


desktop children =
    div
        [ class [ Style.Desktop ] ]
        children


window name children =
    div [ class [ Style.Window ] ]
        [ div [ class [ Style.WindowTop ] ]
            [ text name
            , div [ class [ Style.WindowCloseButton ] ] []
            ]
        , div
            [ class [ Style.WindowChildren ] ]
            children
        ]
