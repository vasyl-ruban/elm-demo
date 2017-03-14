module Update exposing (..)

import Model exposing (..)
import Messages exposing (..)

-- Update

update : Msg -> Model -> Model
update msg model =
  case msg of
    Click -> { model | foo = "afterClick" }
