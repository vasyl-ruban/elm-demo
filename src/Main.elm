module Main exposing (..)

import Html exposing (..)
import Navigation exposing (Location)


import Model exposing (..)
import Messages exposing (..)
import View exposing (..)
import Update exposing (..)
import Routing exposing (..)

init : Location -> ( Model, Cmd Msg )
init location =
  let
        currentRoute =
            Routing.parseLocation location
  in (initMode "initVal" 0 currentRoute, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
  Navigation.program Messages.OnLocationChange
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }
