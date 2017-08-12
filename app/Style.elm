module Style exposing (css, CssIds(..))

import Css exposing (..)
import Css.Elements exposing (html, body, a)


type CssIds
    = Loading
    | Main


css =
    stylesheet
        [ everything
            [ boxSizing borderBox
            , before [ boxSizing borderBox ]
            , after [ boxSizing borderBox ]
            ]
        , html
            [ fontSize (px 16) ]
        , body
            [ backgroundColor (hex "7070aa")
            , backgroundImage <| url "/images/background.png"
            , displayFlex
            , height (vh 100)
            ]
        , a
            [ textDecoration none
            ]
        , id Main
            [ displayFlex
            , justifyContent center
            , alignItems center
            , flexGrow (num 1)
            ]
        , id Loading
            [ fontSize (Css.rem 2)
            , fontFamily sansSerif
            ]
        ]
