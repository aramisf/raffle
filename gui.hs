{-
 - Picking random people from a list
 -
 -  1. Add people registration
 -  2. Pick a random person from the record list
 -
 -  All of it using a graphical interface
 -  - `cabal install gtk`
 -  (if you get error like "(fromNativeWindowId windowId)", try this commandline:
 -  `cabal install gtk -fhave-quartz-gtk`)
 - -}
module Main where

import Graphics.UI.Gtk
import MyData

submit_entry :: Entry -> Label -> IO()
submit_entry entry label = do
    name <- entryGetText entry
    if (name == "") then do
        labelSetText label ("Empty name, please try again")

    else do

      if ((length name) > 78) then do
          labelSetText label ("Maximum name lenght is 78 characters")

      else do
          name_exists_bool <- name_exists name

          if not (name_exists_bool) then do
              write_file name
              labelSetText label ("\"" ++ name ++ "\" successfully recorded")

          else do
              labelSetText label ("\"" ++ name ++ "\" found on my record")

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

    -- Adds a label to the window
    label_name <- labelNew (Just "Type in the person's name: ")
    -- set a font for the label
    label_name_font <- fontDescriptionFromString "Arial 18"
    widgetModifyFont label_name (Just label_name_font)
    -- set color
    widgetModifyFg label_name StateNormal (Color 0 0 0xffff)


    -- Label to warn on successfull registration
    label_succ_reg <- labelNew (Just "")
    label_succ_reg_font <- fontDescriptionFromString "Arial Bold 13"
    widgetModifyFont label_succ_reg (Just label_succ_reg_font)
    widgetModifyFg label_succ_reg StateNormal (Color 0 0x8888 0)


    -- Add an input
    input_name <- entryNew

    -- And a button
    btn_submit <- buttonNewWithLabel "Submit!"
    -- binds the click event to a call to `submit_entry` function
    btn_submit `onClicked` submit_entry input_name label_succ_reg

    -- creating a new layout
    -- VBox is a container that organises window child widgets in a single column
    -- vBoxNew creates a new VBox with the following parameters:
    --   - True -> if all children will have the same size
    --   - Int -> number of pixels between children
    myLayout <- vBoxNew False 0

    -- Putting all pieces together
    containerAdd myLayout label_name
    containerAdd myLayout input_name
    containerAdd myLayout btn_submit
    containerAdd myLayout label_succ_reg
    containerAdd window myLayout


    -- show all windows with its own widgets
    widgetShowAll window

    -- main loop
    mainGUI

