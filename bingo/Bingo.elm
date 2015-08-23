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
    wasSpoken = False,
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
  | Mark Int

update action model =
  case action of
    NoOp -> model
    Sort -> { model | entries <- List.sortBy .points model.entries }
    Delete id ->
      let
        remainingEntries = List.filter (\entry -> entry.id /= id ) model.entries
      in
        { model | entries <- remainingEntries }
    Mark id ->
      let
        updateEntry e =
          if e.id == id then { e | wasSpoken <- (not e.wasSpoken) } else e
      in
        { model | entries <- List.map updateEntry model.entries }


title message times =
  message ++ " "
    |> toUpper
    |> repeat 3
    |> trimRight
    |> text

pageHeader =
  h1 [] [ title "bingo!" 3 ]

totalPoints entries =
  let
    spokenEntries = List.filter .wasSpoken entries
  in
    List.sum (List.map .points spokenEntries)

totalItem total =
  li [ class "total" ] [
    span [ class "label" ] [ text "Total" ],
    span [ class "points" ] [ text (toString total) ]
  ]

entryItem address entry =
  li [ classList [ ("highlight", entry.wasSpoken) ], onClick address (Mark entry.id) ]
    [ span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ],
      button [ class "delete", onClick address (Delete entry.id) ] [ ]
    ]

entryList address entries =
  let
    entryItems = List.map (entryItem address) entries
    items = entryItems ++ [ totalItem (totalPoints entries) ]
  in
    ul [] items

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





