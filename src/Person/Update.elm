module Person.Update exposing (..)

import Http
import Json.Decode as Decode

import Person.Model exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    LoadPersonList pageId ->
      (model, getPersonList pageId)

    HandlePersonList (Ok personList) ->
      {model | personList = (List.append model.personList personList), personListPageId = (model.personListPageId+1)} ! []

    HandlePerson (Ok person) ->
      {model | person = person} ! []

    _ -> (model, Cmd.none)


changeRouteHandler : Model -> Route -> (Model, Cmd Msg)
changeRouteHandler model route =
  case route of
    PersonRoute personId ->
      model ! [getPerson personId]
    PersonListRoute ->
      {model
        | personListPageId = 1
        , personList = []
      } ! [getPersonList 1]


getPerson : PersonId -> Cmd Msg
getPerson personId =
  let
    url = "http://swapi.co/api/people/" ++ (toString personId)
  in
    Http.send HandlePerson (Http.get url personDecoder)

getPersonList : Int -> Cmd Msg
getPersonList pageId =
  let
    url = "http://swapi.co/api/people/?page=" ++ (toString pageId)
  in
    Http.send HandlePersonList (Http.get url personListDecoder)

personListDecoder : Decode.Decoder (List Person)
personListDecoder =
  Decode.at ["results"] (Decode.list personDecoder)

personDecoder : Decode.Decoder Person
personDecoder =
  Decode.map3 Person
    (Decode.field "name" Decode.string)
    (Decode.field "height" Decode.string)
    (Decode.field "mass" Decode.string)
