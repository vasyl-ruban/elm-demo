module View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Model exposing (..)
import Messages exposing (..)

-- View
view : Model -> Html Msg
view model =
  div []
  [ div []
        [ a [style [("margin", "0 10px 0 0")], href ""] [text "home"]
        , a [style [("margin", "0 10px 0 0")], href "#about"] [text "about"]
        , a [style [("margin", "0 10px 0 0")], href "#asdf"] [text "not found"]
        ]
  , page model
  ]

page : Model -> Html Msg
page model =
  case model.route of
    Home -> home model
    About -> about model
    NotFound -> notFound model

home : Model -> Html Msg
home model =
  div [] [text "home page"]

about : Model -> Html Msg
about model =
  div [] [text "about"]

notFound : Model -> Html Msg
notFound model =
  div [] [text "not found"]
