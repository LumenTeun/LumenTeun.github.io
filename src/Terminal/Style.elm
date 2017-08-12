module Terminal.Style exposing (namespace, css, CssClasses(..))

import Css exposing (..)
import Css.Elements exposing (html, body, a)
import Css.Namespace
import Constants exposing (blue)


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
                , overflowY auto
                , padding2 (em 0) (em 0.3)
                , whiteSpace preWrap
                , descendants
                    [ a
                        [ color blue
                        , hover
                            [ textDecoration underline
                            ]
                        ]
                    ]
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
                , color blue
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
