module Terminal.Style exposing (namespace, css, CssClasses(..))

import Css exposing (..)
import Css.Elements exposing (a)
import Css.Namespace
import Constants exposing (blue, black)


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
    in
        (stylesheet << Css.Namespace.namespace namespace)
            [ class Terminal
                [ displayFlex
                , flexDirection column
                , flexGrow (num 1)
                , backgroundColor black
                , color fgColor
                , fontFamily monospace
                , overflowY auto
                , padding2 (rem 0) (rem 0.3)
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
                , padding (rem 0)
                , border (rem 0)
                , color inherit
                , fontFamily inherit
                , outlineStyle none
                ]
            ]
