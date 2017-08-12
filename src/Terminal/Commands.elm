module Terminal.Commands exposing (getOutput, handleKeyCombination)

import Html exposing (Html, text)
import Html.Events exposing (on)
import Json.Decode as Json
import Regex exposing (regex, HowMany(AtMost))
import Update exposing (Msg(..))
import Helpers exposing (line, link)


getOutput : String -> List (Html Msg)
getOutput command =
    let
        ( cmd, tail ) =
            case splitAtFirstWhitespace command of
                cmd :: tail :: _ ->
                    ( cmd, tail )

                cmd :: _ ->
                    ( cmd, "" )

                _ ->
                    ( "", "" )
    in
        case cmd of
            "about" ->
                getAboutOutput tail

            "help" ->
                [ line [ text "Here are some available commands:" ]
                , line [ text "about" ]
                , line [ text "echo" ]
                , line [ text "clear" ]
                ]

            "echo" ->
                [ text tail ]

            "hello" ->
                [ text "hi :)" ]

            "" ->
                []

            _ ->
                [ line [ text <| "ash: command not found: " ++ command ]
                , line [ text "Try 'help' if you're lost" ]
                ]


type alias KeyCombination =
    { key : String
    , ctrlKey : Bool
    }


handleKeyCombination : Html.Attribute Msg
handleKeyCombination =
    (Json.map2 KeyCombination
        (Json.field "key" Json.string)
        (Json.field "ctrlKey" Json.bool)
    )
        |> Json.andThen
            (\{ ctrlKey, key } ->
                if ctrlKey then
                    Json.succeed <| getCtrlKeyBinding key
                else
                    Json.succeed <| getKeyBinding key
            )
        |> on "keydown"


getCtrlKeyBinding : String -> Msg
getCtrlKeyBinding key =
    case (String.toLower key) of
        "l" ->
            ClearTerminalOutput

        "u" ->
            ClearTerminalInput

        "p" ->
            ScrollTerminalInputBack

        "n" ->
            ScrollTerminalInputForward

        _ ->
            NoOp


getKeyBinding : String -> Msg
getKeyBinding key =
    case (String.toLower key) of
        "arrowup" ->
            ScrollTerminalInputBack

        "arrowdown" ->
            ScrollTerminalInputForward

        _ ->
            NoOp


splitAtFirstWhitespace : String -> List String
splitAtFirstWhitespace =
    Regex.split (AtMost 1) (regex "\\s+")


getAboutOutput : String -> List (Html Msg)
getAboutOutput args =
    case args of
        "ahstro" ->
            [ text "I'm ahstro or Anton Strömkvist. I like coding, psychedelics, rock climbing, and loads of other stuff. I also made this website. Nice meeting you!" ]

        "coding" ->
            [ text "I have no idea when I started coding. I remember trying to figure out a C++ compiler (with no success) when I was around 10, as well as making some crude websites. For me, coding isn't simply about software though; coding is just a symptom of my fascination with everything and an almost innate desire to tinker and help out with stuff. Naturally, I've been a huge fan of open source software since I first came into contact with (and comprehended) the concept. If you're curious, you can check out what I've done on my "
            , github "GitHub"
            , text " and "
            , gitlab "GitLab"
            , text " accounts."
            ]

        "psychedelics" ->
            [ text "I first read about psychedelics in my mid-teens, and even though my interest was instant and definite, it took a few years of consuming every piece of information I could find before I would actually consume my first psychedelic. Contrary to popular belief, they are not simply drugs of abuse - although they certainly can be misused - but, used with the right set and setting, they can - and did with me - help people with mental health issues such as depression, let terminal people confront and come to terms with death, or build trust and strengthen bonds within yourself and between you and friends. If reading this made you either highly uncomfortable or dimiss me as a junkie, I highly recommend you try to ignore that feeling for just a couple of minutes and either watch "
            , link "https://www.newyorker.com/magazine/2015/02/09/trip-treatment" "this TEDx"
            , text " by Imperial College London researcher Robin Carhart-Harris or read the excellent article "
            , link "https://www.newyorker.com/magazine/2015/02/09/trip-treatment" "The Trip Treatment"
            , text " by Michael Pollan. Also feel free to contact me if you have any questions."
            ]

        "contact" ->
            [ line
                [ text " email: "
                , link "mailto:anton@stromkvist.com" "anton@stromkvist.com"
                ]
            , line
                [ text "github: "
                , github "github.com/ahstro"
                ]
            , line
                [ text "gitlab: "
                , gitlab "gitlab.com/ahstro"
                ]
            , line
                [ text "   pgp: "
                , link
                    "https://pgp.mit.edu/pks/lookup?op=vindex&search=0x50A3573EFBFA9867"
                    "0x50A3573EFBFA9867"
                ]
            ]

        _ ->
            [ line [ text "usage: about [topic]" ]
            , line [ text "Topics:" ]
            , line [ text " ahstro" ]
            , line [ text " coding" ]
            , line [ text " psychedelics" ]
            , line [ text " contact" ]
            ]


gitlab : String -> Html Msg
gitlab =
    link "https://gitlab.com/ahstro"


github : String -> Html Msg
github =
    link "https://github.com/ahstro"
