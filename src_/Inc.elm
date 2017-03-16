module Inc exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode

type alias Person =
  { name: String
  , height: String
  , mass: String
  }

initPerson: Person
initPerson =
  Person "" "" ""

type alias Model =
  { val: Int
  , person: Person
  }

initModel: Model
initModel =
  Model 0 initPerson

type Msg
  = Inc
  | Dec
  | ChangeVal String
  | LoadData
  | HandleData (Result Http.Error Person)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Inc ->
      ({model | val = model.val + 1}) ! []
    Dec ->
      ({model | val = model.val - 1}) ! []

    ChangeVal newVal ->
      case String.toInt newVal of
        Ok val ->
          ({model | val = val}, Cmd.none)
        Err val ->
          (model, Cmd.none)

    LoadData ->
      (model, getData model)

    HandleData (Ok person) ->
      (Model model.val person, Cmd.none)

    HandleData (Err _) ->
      (Model 0 initPerson, Cmd.none)

getData: Model -> Cmd Msg
getData model =
  let
    url = "http://swapi.co/api/people/" ++ toString model.val
  in
    Http.send HandleData (Http.get url decoder)

decoder: Decode.Decoder Person
decoder =
  Decode.map3 Person
    (Decode.field "name" Decode.string)
    (Decode.field "mass" Decode.string)
    (Decode.field "height" Decode.string)


view : Model -> Html Msg
view model =
  div []
    [text (toString model)
    , br [] []
    , input [ placeholder "person id", value (toString model.val), onInput ChangeVal ] []
    , button [onClick Inc] [text "inc"]
    , button [onClick Dec] [text "dec"]
    , button [onClick LoadData] [text "load"]
    ]
