module Terminal.Commands exposing (getOutput, handleKeyCombination)

import Html
import Html.Events exposing (on)
import Json.Decode as Json
import Regex exposing (regex, HowMany(AtMost))
import Update exposing (Msg(..))


getOutput : String -> List String
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

            "echo" ->
                [ tail ]

            "hello" ->
                [ "hi :)" ]

            "" ->
                []

            _ ->
                [ "ash: command not found: " ++ command ]


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


getAboutOutput : String -> List String
getAboutOutput args =
    case args of
        "ahstro" ->
            [ "I'm ahstro or Anton Strömkvist. I like coding, psychedelics, rock climbing, and loads of other stuff. I also made this website. Nice meeting you!" ]

        "coding" ->
            [ "I have no idea when I started coding. I remember trying to figure out a C++ compiler (with no success) when I was around 10, as well as making some crude websites. For me, coding isn't simply about software though; coding is just a symptom of my fascination with everything and an almost innate desire to tinker and help out with stuff. Naturally, I've been a huge fan of open source software since I first came into contact with (and comprehended) the concept. If you're curious, you can check out what I've done on my GitHub and GitLab accounts." ]

        "psychedelics" ->
            [ "I first read about psychedelics in my mid-teens, and even though my interest was instant and definite, it took a few years of consuming every piece of information I could find before I would actually consume my first psychedelic. Contrary to popular belief, they are not simply drugs of abuse - although they certainly can be misused - but, used with the right set and setting, they can - and did with me - help people with mental health issues such as depression, let terminal people confront and come to terms with death, or build trust and strengthen bonds within yourself and between you and friends. If reading this made you either highly uncomfortable or dimiss me as a junkie, I highly recommend you try to ignore that feeling for just a couple of minutes and either watch this TEDx by Imperial College London researcher Robin Carhart-Harris or read the excellent article 'The Trip Treatment' by Michael Pollan. Also feel free to contact me if you have any questions." ]

        "contact" ->
            [ " email: anton@stromkvist.com"
            , "github: github.com/ahstro"
            , "gitlab: gitlab.com/ahstro"
            ]

        _ ->
            [ "What do you want to know stuff about?"
            , "- ahstro"
            , "- coding"
            , "- psychedelics"
            , "- contact"
            ]
