module Inc exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode


type alias Model =
  { val: Int
  , name: String
  }

initModel: Model
initModel =
  Model 0 "foo"

type Msg
  = Inc
  | Dec
  | LoadData
  | HandleData (Result Http.Error String)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Inc ->
      ({model | val = model.val + 1}) ! []
    Dec ->
      ({model | val = model.val - 1}) ! []

    LoadData ->
      (model, getData)

    HandleData (Ok name) ->
      (Model 0 name, Cmd.none)

    HandleData (Err _) ->
      (Model 0 "", Cmd.none)

getData: Cmd Msg
getData =
  let
    url = "http://swapi.co/api/people/1/"
  in
    Http.send HandleData (Http.get url decoder)

decoder: Decode.Decoder String
decoder =
  Decode.at ["name"] Decode.string

view : Model -> Html Msg
view model =
  div []
    [text (toString model)
    , button [onClick Inc] [text "inc"]
    , button [onClick Dec] [text "dec"]
    , button [onClick LoadData] [text "load"]
    ]
