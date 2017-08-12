port module Stylesheets exposing (main)

import Css.File exposing (CssCompilerProgram, CssFileStructure)
import Terminal.Style
import Desktop.Style
import Style


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    Css.File.toFileStructure
        [ ( "app.css"
          , Css.File.compile
                [ Style.css
                , Desktop.Style.css
                , Terminal.Style.css
                ]
          )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files cssFiles
