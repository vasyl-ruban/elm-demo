module View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)

import Model exposing (..)
import Messages exposing (..)

-- View
view : Model -> Html Msg
view model =
  div []
  [text model.foo
  , button [ onClick Click] [text "btn"]
  ]
