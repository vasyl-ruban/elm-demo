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
    Inc m ->
      let
        (bar, cmd) =
          Inc.update m model.bar
      in
        {model | bar = bar} ! []
