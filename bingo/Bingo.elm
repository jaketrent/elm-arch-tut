module Bingo where

import Html exposing (..)
import String exposing (toUpper, repeat, trimRight)

title message times =
  message ++ " "
    |> toUpper
    |> repeat 3
    |> trimRight
    |> text

main =
  title "bingo!" 3
