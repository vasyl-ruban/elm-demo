module Model exposing (..)

import Inc

-- Model

type alias Model =
  { foo: String
  , bar: Int
  , route: Route
  , incModel: Inc.Model
  }

initMode : String -> Int -> Route -> Model
initMode foo bar route =
  Model foo bar route Inc.initModel

-- Route

type Route
  = Home
  | About
  | NotFound
