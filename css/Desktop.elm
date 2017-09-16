module Desktop exposing (..)

import Css exposing (..)
import Css.Class exposing (class)
import Constants exposing (blue, black)


-- Constants


rem =
    Css.rem


windowBorderColor =
    (hex "bbc8dd")


windowBorderRadius =
    (rem 0.2)


windowBorderWidth =
    (rem 0.2)



-- Classes


desktop =
    class
        [ displayFlex
        , height (vh 100)
        , width (vw 100)
        , justifyContent center
        , alignItems center
        ]


window =
    class
        [ displayFlex
        , flexDirection column
        , height (rem 20)
        , width (rem 30)
        , boxShadow4 (rem 0.4) (rem 0.4) (rem 0.3) (hex "0008")
        ]


windowTop =
    class
        [ displayFlex
        , backgroundColor windowBorderColor
        , justifyContent spaceBetween
        , alignItems baseline
        , border3 windowBorderWidth solid windowBorderColor
        , borderRadius4 windowBorderRadius windowBorderRadius (px 0) (px 0)
        , padding2 (rem 0) (rem 0.2)
        , height (rem 1.3)
        , fontSize (rem 0.9)
        , color black
        , fontFamily sansSerif
        ]


windowCloseButton =
    class
        [ borderRadius (pct 50)
        , backgroundColor (hex "ff0000")
        , height (rem 0.5)
        , width (rem 0.5)
        ]


windowChildren =
    class
        [ displayFlex
        , border3 windowBorderWidth solid windowBorderColor
        , borderTop (px 0)
        , flexGrow (num 1)
        , borderRadius4 (px 0) (px 0) windowBorderRadius windowBorderRadius
        , overflowY auto
        ]
