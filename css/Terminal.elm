module Terminal exposing (..)

import Css exposing (..)
import Css.File exposing (uniqueClass, UniqueClass)
import Css.Elements exposing (a)
import Constants exposing (blue, black)


-- Constants


rem : Float -> Rem
rem =
    Css.rem


fgColor : Color
fgColor =
    (hex "d5d3a5")



--Classes


terminal : UniqueClass
terminal =
    uniqueClass
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


input : UniqueClass
input =
    uniqueClass
        [ displayFlex
        , alignItems center
        ]


outputLine : UniqueClass
outputLine =
    uniqueClass
        [ displayFlex
        ]


prompt : UniqueClass
prompt =
    uniqueClass
        [ displayFlex
        , color blue
        ]


inputInput : UniqueClass
inputInput =
    uniqueClass
        [ flexGrow (num 1)
        , backgroundColor transparent
        , padding (rem 0)
        , border (rem 0)
        , color inherit
        , fontFamily inherit
        , outlineStyle none
        ]
