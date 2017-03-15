module Inc exposing (..)

import Html exposing (..)
import Html.Events exposing (..)


type alias Model = Int

type Msg
  = Inc
  | Dec

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Inc ->
      (model + 1) ! []
    Dec ->
      (model - 1) ! []

view : Model -> Html Msg
view model =
  div []
    [text (toString model)
    , button [onClick Inc] [text "inc"]
    , button [onClick Dec] [text "dec"]
    ]
