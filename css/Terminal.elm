module Terminal exposing (..)

import Css exposing (..)
import Css.Class exposing (class)
import Css.Elements exposing (a)
import Constants exposing (blue, black)


-- Constants


rem =
    Css.rem


fgColor =
    (hex "d5d3a5")



-- Classes


terminal =
    class
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


input =
    class
        [ displayFlex
        , alignItems center
        ]


outputLine =
    class
        [ displayFlex
        ]


prompt =
    class
        [ displayFlex
        , color blue
        ]


inputInput =
    class
        [ flexGrow (num 1)
        , backgroundColor transparent
        , padding (rem 0)
        , border (rem 0)
        , color inherit
        , fontFamily inherit
        , outlineStyle none
        ]
