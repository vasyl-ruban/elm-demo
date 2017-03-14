module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)

main =
  Html.beginnerProgram {
    model = initMode "initValue" 0,
    view = view,
    update = update
  }

-- Model

type alias Model =
  { foo: String
  , bar: Int
  }

initMode : String -> Int -> Model
initMode foo bar =
  Model foo bar

-- Messages

type Msg
  = Click

-- Update

update : Msg -> Model -> Model
update msg model =
  case msg of
    Click -> { model | foo = "afterClick" }

-- View
view : Model -> Html Msg
view model =
  div []
  [text model.foo
  , button [ onClick Click] [text "btn"]
  ]
