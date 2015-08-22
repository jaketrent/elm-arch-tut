module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import StartApp.Simple as StartApp
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

type Action
  = NoOp
  | Sort
  | Delete Int

update action model =
  case action of
    NoOp -> model
    Sort -> { model | entries <- List.sortBy .points model.entries }
    Delete id ->
      let
        remainingEntries = List.filter (\entry -> entry.id /= id ) model.entries
      in
        { model | entries <- remainingEntries }

title message times =
  message ++ " "
    |> toUpper
    |> repeat 3
    |> trimRight
    |> text

pageHeader =
  h1 [] [ title "bingo!" 3 ]

entryItem address entry =
  li [ ]
    [ span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ],
      button [ class "delete", onClick address (Delete entry.id) ] [ ]
    ]

entryList address entries =
  ul [] (List.map (entryItem address) entries)

pageFooter =
  footer [] [ a [ href "http://jaketrent.com" ] [ text "JakeTrent.com" ] ]

view address model =
  div [ id "container" ] [
    pageHeader,
    entryList address model.entries,
    pageFooter
  ]

main =
  StartApp.start { model = initialModel, update = update, view = view }





