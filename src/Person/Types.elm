module Person.Types exposing (..)

type alias PersonId = String

type alias Model =
  {

  }

type Msg
  = PersonMsg

type Route
  = PersonListRoute
  | PersonRoute PersonId
