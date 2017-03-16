module Person.Person exposing (..)

import Html exposing (..)

-- Types

type alias PersonId = String

type alias Model =
  {

  }



type Msg
  = PersonMsg

type Route
  = PersonRoute PersonId
  | PersonListRoute


-- State

initPersonModel : Model
initPersonModel =
  Model

-- View

view : Model -> Route -> Html Msg
view model route =
  case route of
    PersonRoute personId ->
      div [] [text "person"]
    PersonListRoute ->
      div [] [text "person list"]
