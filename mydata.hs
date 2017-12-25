-- module for data handling

module MyData (write_file, name_exists) where

import Control.Exception
import System.IO
import System.IO.Error

fileName = fileName

write_file :: String -> IO()
write_file name = do
      f <- openFile fileName AppendMode
      hPutStrLn f name
      hClose f
      return ()


-- auxiliary function, not exported to outside modules
contains :: String -> [String] -> Bool
contains _ [] = False
contains name (x:xs)  | (name == x) = True
                      | otherwise = contains name xs


name_exists :: String -> IO Bool
name_exists name = do
    { catch (read_file) handle_error }
    where
      read_file = do
      {
        f <- openFile fileName ReadMode;
        names <- hGetContents f;
        if (contains name (lines names)) then do
          hClose f;
          return True
        else do
          hClose f;
          return False
      }
      handle_error err = if isDoesNotExistError err then do
      {
        f <- openFile fileName WriteMode;
        hClose f;
        return False
      }
      else
        ioError err


