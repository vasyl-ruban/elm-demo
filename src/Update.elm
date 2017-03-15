module Update exposing (..)

import Html

import Model exposing (..)
import Messages exposing (..)
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
        {model | route = newRoute} ! []

    None -> model ! []

    Inc m ->
      let
        (incModel, cmd) =
          Inc.update m model.incModel
      in
        ({model | incModel = incModel}, Cmd.map Inc cmd)
