module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import String exposing (toUpper, repeat, trimRight)

newEntry phrase points id =
  {
    phrase = phrase,
    points = points,
    wasSpoke = False,
    id = id
  }

initialModel =
  {
    entries =
      [ newEntry "Doing Agile" 200 2,
        newEntry "In the Cloud" 300 3,
        newEntry "Future Proof" 100 1
      ]
  }

title message times =
  message ++ " "
    |> toUpper
    |> repeat 3
    |> trimRight
    |> text

pageHeader =
  h1 [] [ title "bingo!" 3 ]

entryItem entry =
  li [ ]
    [ span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ]
    ]

entryList entries =
  ul [] (List.map entryItem entries)

pageFooter =
  footer [] [ a [ href "http://jaketrent.com" ] [ text "JakeTrent.com" ] ]

view model =
  div [ id "container" ] [
    pageHeader,
    entryList model.entries,
    pageFooter
  ]

main =
  view initialModel