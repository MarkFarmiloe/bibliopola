module Atom.Index exposing (..)

import Atom.Ban as Ban
import Atom.Caret as Caret
import Atom.File as File
import Atom.Folder as Folder
import Atom.LogLine as LogLine
import Atom.SelectBox as SelectBox
import Atom.Tab as Tab
import Atom.Toggle as Toggle
import Bibliopola exposing (..)
import Color.Pallet as Pallet exposing (Pallet(..))
import Styles exposing (styles)
import Types exposing (..)


tree : ViewTree (Styles s) (Variation v)
tree =
    createEmptyViewTree "Atom"
        |> insertViewTree
            (createEmptyViewTree "Icon"
                |> insertViewItem caret
                |> insertViewItem file
                |> insertViewItem folder
                |> insertViewItem ban
            )
        |> insertViewTree
            (createEmptyViewTree "Form"
                |> insertViewItem selectBox
                |> insertViewItem toggle
            )
        |> insertViewItem tab
        |> insertViewItem logLine


caret : ViewItem (Styles s) (Variation v)
caret =
    let
        config pallet =
            { pallet = pallet
            , onClick = Just (\dir -> toString dir ++ " clicked!")
            , size = 256
            }
    in
    createViewItem2 "Caret"
        Caret.view
        ( "pallet"
        , List.map (\p -> toString p => config p) Pallet.pallets
        )
        ( "direction"
        , List.map (\dir -> toString dir => dir) Caret.directions
        )
        |> withDefaultVariation (Caret.view (config Black) Caret.Up)


file : ViewItem (Styles s) (Variation v)
file =
    let
        config pallet =
            { pallet = pallet
            , onClick = Just "File clicked!"
            , size = 256
            }
    in
    createViewItem "File"
        File.view
        ( "pallet"
        , List.map (\p -> toString p => config p) Pallet.pallets
        )
        |> withDefaultVariation (File.view <| config Black)


folder : ViewItem (Styles s) (Variation v)
folder =
    let
        config pallet =
            { pallet = pallet
            , onClick = Just "Folder clicked!"
            , size = 256
            }
    in
    createViewItem "Folder"
        Folder.view
        ( "pallet"
        , List.map (\p -> toString p => config p) Pallet.pallets
        )
        |> withDefaultVariation (Folder.view <| config Black)


ban : ViewItem (Styles s) (Variation v)
ban =
    let
        config pallet =
            { pallet = pallet
            , onClick = Just "Ban clicked!"
            , size = 256
            }
    in
    createViewItem "Ban"
        Ban.view
        ( "pallet"
        , List.map (\p -> toString p => config p) Pallet.pallets
        )
        |> withDefaultVariation (Ban.view <| config Black)


selectBox : ViewItem (Styles s) (Variation v)
selectBox =
    createViewItem3 "SelectBox"
        SelectBox.view_
        ( "options"
        , [ "one" => [ "a", "b", "c", "d", "e", "f", "g" ]
          , "long" => [ "hogehogehogehogehoge", "miyamiyamiyamiya" ]
          ]
        )
        ("selected"
            => [ "a" => "a"
               , "c" => "c"
               , "e" => "e"
               , "g" => "g"
               , "miyamiyamiyamiya" => "miyamiyamiyamiya"
               ]
        )
        ( "disabled", [ "False" => False, "True" => True ] )
        |> withDefaultVariation
            (SelectBox.view_
                [ "a", "b", "c", "d", "e", "f", "g" ]
                "e"
                False
            )


toggle : ViewItem (Styles s) (Variation v)
toggle =
    createViewItem "Toggle"
        (Toggle.view { name = "On", onClick = "Clicked" })
        ( "on", [ "True" => True, "False" => False ] )
        |> withDefaultVariation (Toggle.view { name = "On", onClick = "Clicked" } True)


tab : ViewItem (Styles s) (Variation v)
tab =
    createViewItem2 "Tab"
        (\selected label ->
            Tab.view { selected = selected, onClick = identity } label
        )
        ( "selected"
        , [ "True" => True, "False" => False ]
        )
        ( "label"
        , [ "short" => "s", "middle" => "Middle", "long" => "Hogehogehogehoge" ]
        )
        |> withDefaultVariation
            (Tab.view { selected = True, onClick = identity } "Tab Label")


logLine : ViewItem (Styles s) (Variation v)
logLine =
    createViewItem2 "LogLine"
        (\id message ->
            LogLine.view { id = id, message = message }
        )
        ( "id"
        , [ "1" => 1, "99" => 99, "999" => 999, "9999" => 9999 ]
        )
        ( "message"
        , [ "empty" => ""
          , "one" => "s"
          , "middle" => "mmmmmmmmmmmmmmmmmmmmmmmm"
          , "long" => "HogehogehogehogeHogehogehogehogeHogehogehogehogeHogeh ogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogeho geHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehogeHogehogehogehoge HogehogehogehogeHogehogehogehogeHogehogehogehoge"
          ]
        )
        |> withDefaultVariation
            (LogLine.view { id = 0, message = "dummy message" })


main : MyProgram (Styles s) (Variation v)
main =
    createMainFromViewTree styles tree
