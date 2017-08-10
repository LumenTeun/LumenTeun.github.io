module Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (html, body, a)
import Css.Namespace


type CssClasses
    = Desktop
    | Terminal
    | Window
    | WindowTop
    | WindowCloseButton
    | WindowChildren


namespace =
    "ahstro"


webkitScrollbar =
    pseudoElement "-webkit-scrollbar"


css =
    let
        rem =
            Css.rem

        fgColor =
            (hex "252525")

        bgColor =
            (hex "0645ad")

        windowBorderColor =
            (hex "bbc8dd")
    in
        (stylesheet << Css.Namespace.namespace namespace)
            [ everything
                [ boxSizing borderBox
                , before [ boxSizing borderBox ]
                , after [ boxSizing borderBox ]
                ]
            , html
                [ fontSize (px 14) ]
            , body
                [ backgroundColor (hex "f6f6f6")
                , displayFlex
                , height (vh 100)
                ]
            , a
                [ textDecoration none
                ]
            , class Desktop
                [ displayFlex
                , height (vh 100)
                , width (vw 100)
                , justifyContent center
                , alignItems center
                ]
            , class Window
                [ displayFlex
                , flexDirection column
                , height (rem 20)
                , width (rem 30)
                ]
            , class WindowTop
                [ displayFlex
                , backgroundColor windowBorderColor
                , justifyContent spaceBetween
                , alignItems center
                , border3 (px 2) solid windowBorderColor
                , borderRadius4 (px 3) (px 3) (px 0) (px 0)
                , padding2 (em 0) (em 0.2)
                ]
            , class WindowCloseButton
                [ borderRadius (pct 50)
                , backgroundColor (hex "ff0000")
                , height (em 0.5)
                , width (em 0.5)
                ]
            , class WindowChildren
                [ displayFlex
                , border3 (px 2) solid windowBorderColor
                , borderTop (px 0)
                , flexGrow (num 1)
                , borderRadius4 (px 0) (px 0) (px 3) (px 3)
                ]
            , class Terminal
                [ backgroundColor bgColor
                , flexDirection column
                , displayFlex
                , maxWidth (rem 64)
                , flexGrow (int 1)
                , padding (rem 2)
                , margin2 (rem 4) auto
                , border3 (px 1) solid (hex "a7d7f9")
                ]
            ]
