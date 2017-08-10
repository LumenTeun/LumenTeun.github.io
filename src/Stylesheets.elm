port module Stylesheets exposing (main)

import Css.File exposing (CssCompilerProgram, CssFileStructure)
import Style


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    Css.File.toFileStructure
        [ ( "index.css", Css.File.compile [ Style.css ] )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files cssFiles
