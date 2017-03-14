module Main exposing (..)

import Html exposing (..)


import Model exposing (..)
import View exposing (..)
import Update exposing (..)

main =
  Html.beginnerProgram {
    model = initMode "initValue" 0,
    view = view,
    update = update
  }
