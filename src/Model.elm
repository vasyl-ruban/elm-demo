module Model exposing (..)

-- Model

type alias Model =
  { foo: String
  , bar: Int
  }

initMode : String -> Int -> Model
initMode foo bar =
  Model foo bar
