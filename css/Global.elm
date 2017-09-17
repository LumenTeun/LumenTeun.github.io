module Global exposing (..)

import Css exposing (..)
import Css.Elements exposing (html, body, a)


type CssIds
    = Main
    | Loading


everythingSnippet : Snippet
everythingSnippet =
    everything
        [ boxSizing borderBox
        , before [ boxSizing borderBox ]
        , after [ boxSizing borderBox ]
        ]


htmlSnippet : Snippet
htmlSnippet =
    html
        [ fontSize (px 16) ]


bodySnippet : Snippet
bodySnippet =
    body
        [ backgroundColor (hex "7070aa")
        , backgroundImage <| url "/images/background.png"
        , displayFlex
        , height (vh 100)
        ]


aSnippet : Snippet
aSnippet =
    a
        [ textDecoration none
        ]


mainSnippet : Snippet
mainSnippet =
    id Main
        [ displayFlex
        , justifyContent center
        , alignItems center
        , flexGrow (num 1)
        ]


loadingSnippet : Snippet
loadingSnippet =
    id Loading
        [ fontSize (Css.rem 2)
        , fontFamily sansSerif
        ]
