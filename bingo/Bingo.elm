module Bingo where

import Html
import String

title message times =
  message ++ " "
    |> String.toUpper
    |> String.repeat 3
    |> String.trimRight
    |> Html.text

main =
  title "bingo!" 3
