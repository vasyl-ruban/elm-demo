module Update exposing (..)

import Model exposing (..)
import Messages exposing (..)
import Routing exposing (..)


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
