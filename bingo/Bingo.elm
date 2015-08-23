module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String exposing (toUpper, repeat, trimRight)

import BingoUtils as Utils

type alias Entry = {
  phrase: String,
  points: Int,
  wasSpoken: Bool,
  id: Int
}

type alias Model = {
  entries: List Entry,
  phraseInput: String,
  pointsInput: String,
  nextID: Int
}

type Action
  = NoOp
  | Sort
  | Delete Int
  | Mark Int
  | UpdatePhraseInput String
  | UpdatePointsInput String
  | Add

initialModel : Model
initialModel =
  {
    entries = [
      newEntry "Doing Agile" 200 2,
      newEntry "In the Cloud" 300 3,
      newEntry "Future Proof" 100 1
    ],
    phraseInput = "",
    pointsInput = "",
    nextID = 4
  }

newEntry : String -> Int -> Int -> Entry
newEntry phrase points id =
  {
    phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
  }

totalPoints : List Entry -> Int
totalPoints entries =
  let
    spokenEntries = List.filter .wasSpoken entries
  in
    List.sum (List.map .points spokenEntries)


update : Action -> Model -> Model
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
    UpdatePhraseInput contents -> { model | phraseInput <- contents }
    UpdatePointsInput contents -> { model | pointsInput <- contents }
    Add ->
      let
        entryToAdd =
          newEntry model.phraseInput (Utils.parseInt model.pointsInput) model.nextID
        isInvalid model =
          String.isEmpty model.phraseInput || String.isEmpty model.pointsInput
      in
        if isInvalid model
        then model
        else {
          model |
            phraseInput <- "",
            pointsInput <- "",
            entries <- entryToAdd :: model.entries,
            nextID <- model.nextID + 1
        }

title : String -> Int -> Html
title message times =
  message ++ " "
    |> toUpper
    |> repeat 3
    |> trimRight
    |> text

pageHeader : Html
pageHeader =
  h1 [] [ title "bingo!" 3 ]

totalItem : Int -> Html
totalItem total =
  li [ class "total" ] [
    span [ class "label" ] [ text "Total" ],
    span [ class "points" ] [ text (toString total) ]
  ]

entryForm : Address Action -> Model -> Html
entryForm address model =
  div [] [
    input [
      type' "text",
      placeholder "Phrase",
      value model.phraseInput,
      name "phrase",
      autofocus True,
      Utils.onInput address UpdatePhraseInput
    ] [],
    input [
      type' "number",
      placeholder "Points",
      value model.pointsInput,
      name "points",
      Utils.onInput address UpdatePointsInput
    ] [],
    button [
      class "add",
      onClick address Add
    ] [
      text "Add"
    ],
    h2 [] [ text (model.phraseInput ++ " " ++ model.pointsInput) ]
  ]


entryItem : Address Action -> Entry -> Html
entryItem address entry =
  li [ classList [ ("highlight", entry.wasSpoken) ], onClick address (Mark entry.id) ]
    [ span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ],
      button [ class "delete", onClick address (Delete entry.id) ] [ ]
    ]

entryList : Address Action -> List Entry -> Html
entryList address entries =
  let
    entryItems = List.map (entryItem address) entries
    items = entryItems ++ [ totalItem (totalPoints entries) ]
  in
    ul [] items

pageFooter : Html
pageFooter =
  footer [] [ a [ href "http://jaketrent.com" ] [ text "JakeTrent.com" ] ]

view : Address Action -> Model -> Html
view address model =
  div [ id "container" ] [
    pageHeader,
    entryForm address model,
    entryList address model.entries,
    pageFooter
  ]

main : Signal Html
main =
  StartApp.start { model = initialModel, update = update, view = view }





