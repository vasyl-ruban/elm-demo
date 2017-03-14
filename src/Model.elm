module Model exposing (..)

-- Model

type alias Model =
  { foo: String
  , bar: Int
  , route: Route
  }

initMode : String -> Int -> Route -> Model
initMode foo bar route =
  Model foo bar route

-- Route

type Route
  = Home
  | About
  | NotFound
