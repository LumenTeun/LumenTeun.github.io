module Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (html, body, a)


type CssIds
    = Loading
    | Main


everythingSnippet =
    everything
        [ boxSizing borderBox
        , before [ boxSizing borderBox ]
        , after [ boxSizing borderBox ]
        ]


htmlSnippet =
    html
        [ fontSize (px 16) ]


bodySnippet =
    body
        [ backgroundColor (hex "7070aa")
        , backgroundImage <| url "/images/background.png"
        , displayFlex
        , height (vh 100)
        ]


aSnippet =
    a
        [ textDecoration none
        ]


idSnippet =
    id Main
        [ displayFlex
        , justifyContent center
        , alignItems center
        , flexGrow (num 1)
        ]
idSnippet =
    id Loading
        [ fontSize (Css.rem 2)
        , fontFamily sansSerif
        ]
