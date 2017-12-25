{-
 - Picking random people from a list
 -
 -  1. Add people registration
 -  2. Pick a random person from the record list
 -
 -  All of it using a graphical interface
 - -}
module Main where

import Graphics.UI.Gtk

main :: IO()
main = do
    initGUI -- inits graphical interface

    -- Creates a window
    window <- windowNew

    -- window settings
    set window [ windowTitle := "Person Picker",
                 windowDefaultWidth := 400,
                 windowDefaultHeight := 200,
                 containerBorderWidth := 10 ]

    -- `onDestroy` receives a widget and a instruction
    onDestroy window mainQuit

    -- show all windows with its own widgets
    widgetShowAll window

    -- main loop
    mainGUI

