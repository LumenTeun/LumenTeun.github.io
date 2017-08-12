module Style exposing (css)

import Css exposing (..)
import Css.Elements exposing (html, body, a)


css =
    stylesheet
        [ everything
            [ boxSizing borderBox
            , before [ boxSizing borderBox ]
            , after [ boxSizing borderBox ]
            ]
        , html
            [ fontSize (px 16) ]
        , body
            [ backgroundColor (hex "7070aa")
            , backgroundImage <| url "/images/background.png"
            , displayFlex
            , height (vh 100)
            ]
        , a
            [ textDecoration none
            ]
        ]
