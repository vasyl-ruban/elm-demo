module Messages exposing (..)

import Navigation exposing (Location)

import Inc

-- Messages

type Msg
  = Click
  | Inc Inc.Msg
  | OnLocationChange Location
  | None
