module App exposing (..)

import Navigation exposing (Location)

import Model exposing (..)
import Update exposing (..)
import View exposing (..)

-- Main

init : Location -> (Model, Cmd Msg)
init location =
  let
    currentRoute =
      parseLocation location
  in
    initModel currentRoute

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
  Navigation.program OnLocationChange
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }
