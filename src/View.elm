module View exposing (view)

import Html exposing (Html, label, input, span, div, text, a)
import Html.Attributes exposing (checked, title, href, type_)
import Html.Events exposing (onMouseEnter, onMouseLeave, onClick)
import Html.CssHelpers
import Model exposing (Model)
import Update exposing (Msg(..))
import Style
import Terminal.View exposing (terminal)


{ class } =
    Html.CssHelpers.withNamespace Style.namespace


view : Model -> Html Msg
view model =
    div
        [ class [ Style.Desktop ] ]
        [ window []
            [ terminal model
            ]
        ]


window attr children =
    div (class [ Style.Window ] :: attr)
        [ div [ class [ Style.WindowTop ] ]
            [ text "Terminal"
            , div [ class [ Style.WindowCloseButton ] ] []
            ]
        , div
            [ class [ Style.WindowChildren ] ]
            children
        ]
