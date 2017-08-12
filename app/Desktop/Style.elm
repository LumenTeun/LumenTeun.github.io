module Desktop.Style exposing (namespace, css, CssClasses(..))

import Css exposing (..)
import Css.Elements exposing (html, body, a)
import Css.Namespace
import Constants exposing (blue, black)


type CssClasses
    = Desktop
    | Window
    | WindowTop
    | WindowCloseButton
    | WindowChildren


namespace =
    "desktop"


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

        windowBorderRadius =
            (rem 0.2)

        windowBorderWidth =
            (rem 0.2)
    in
        (stylesheet << Css.Namespace.namespace namespace)
            [ everything
                [ boxSizing borderBox
                , before [ boxSizing borderBox ]
                , after [ boxSizing borderBox ]
                ]
            , html
                [ fontSize (px 16) ]
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
                , backgroundImage <| url "/images/background.png"
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
                , alignItems baseline
                , border3 windowBorderWidth solid windowBorderColor
                , borderRadius4 windowBorderRadius windowBorderRadius (px 0) (px 0)
                , padding2 (rem 0) (rem 0.2)
                , height (rem 1.3)
                , fontSize (rem 0.9)
                , color black
                , fontFamily sansSerif
                ]
            , class WindowCloseButton
                [ borderRadius (pct 50)
                , backgroundColor (hex "ff0000")
                , height (rem 0.5)
                , width (rem 0.5)
                ]
            , class WindowChildren
                [ displayFlex
                , border3 windowBorderWidth solid windowBorderColor
                , borderTop (px 0)
                , flexGrow (num 1)
                , borderRadius4 (px 0) (px 0) windowBorderRadius windowBorderRadius
                , overflowY auto
                ]
            ]
