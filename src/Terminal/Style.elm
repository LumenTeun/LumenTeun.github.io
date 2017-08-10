module Terminal.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (html, body, a)
import Css.Namespace


type CssClasses
    = Terminal
    | Input
    | Prompt
    | InputInput
    | Output
    | OutputLine


namespace =
    "terminal"


css =
    let
        rem =
            Css.rem

        fgColor =
            (hex "d5d3a5")

        bgColor =
            (hex "18202c")
    in
        (stylesheet << Css.Namespace.namespace namespace)
            [ class Terminal
                [ displayFlex
                , flexDirection column
                , flexGrow (num 1)
                , backgroundColor bgColor
                , color fgColor
                , fontFamily monospace
                ]
            , class Input
                [ displayFlex
                , alignItems center
                ]
            , class OutputLine
                [ displayFlex
                ]
            , class Prompt
                [ displayFlex
                , margin2 (em 0) (em 0.2)
                ]
            , class InputInput
                [ flexGrow (num 1)
                , backgroundColor transparent
                , padding (em 0)
                , border (em 0)
                , color inherit
                , fontFamily inherit
                ]
            ]
