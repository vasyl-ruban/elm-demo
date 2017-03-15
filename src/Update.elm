module Update exposing (..)

import Html
import Http
import Json.Decode as Decode

import Model exposing (..)
import Routing exposing (..)

import Inc

-- Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Click -> { model | foo = "afterClick" } ! []
    OnLocationChange location ->
      let
        newRoute =
          parseLocation location
      in
        {model | route = newRoute} !
          [ case parseLocation location of
              PersonRoute personId -> queryPerson personId
              _ -> Cmd.none
          ]

    None -> model ! []

    Inc m ->
      let
        (incModel, cmd) =
          Inc.update m model.incModel
      in
        ({model | incModel = incModel}, Cmd.map Inc cmd)

    HandlePerson (Ok person) ->
      {model | person = person} ! []
    HandlePerson (Err _) -> model ! []

    NavbarMsg state ->
      ( { model | navbarState = state }, Cmd.none )

queryPerson: String -> Cmd Msg
queryPerson personId =
    let
      url = "http://swapi.co/api/people/" ++ personId
    in
      Http.send HandlePerson (Http.get url decoder)

decoder: Decode.Decoder Person
decoder =
  Decode.map3 Person
    (Decode.field "name" Decode.string)
    (Decode.field "mass" Decode.string)
    (Decode.field "height" Decode.string)
