module Main exposing (..)

import Atom.Index
import Bibliopola exposing (..)
import Molecule.Index
import Organism.Index
import Page.Index
import Styles exposing (styles)
import Types exposing ((=>), Styles, Variation)


shelf : Shelf (Styles s) (Variation v)
shelf =
    shelfWithoutBook "Bibliopola"
        |> addShelf Atom.Index.shelf
        |> addShelf Molecule.Index.shelf
        |> addShelf Organism.Index.shelf
        |> addShelf Page.Index.shelf


main : Bibliopola.Program (Styles s) (Variation v)
main =
    fromShelf styles shelf
