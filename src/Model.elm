module Model exposing (..)

import Bootstrap.Navbar as Navbar
import Http
import Navigation exposing (Location)


import Inc

-- Model

type alias Person =
  { name: String
  , mass: String
  , height: String
  }

initPerson : String -> String -> String -> Person
initPerson name mass height =
  Person name mass height

initEmptyPerson : Person
initEmptyPerson =
  Person "" "" ""


type alias Model =
  { foo: String
  , bar: Int
  , route: Route
  , incModel: Inc.Model
  , person: Person
  , navbarState: Navbar.State
  }

initMode : String -> Int -> Route -> Model
initMode foo bar route =
  let
    (navbarState, navbarCmd)
      = Navbar.initialState NavbarMsg
  in
    Model foo bar route Inc.initModel initEmptyPerson navbarState

-- Route

type Route
  = Home
  | About
  | PersonRoute String
  | NotFound


-- Msg

type Msg
  = Click
  | Inc Inc.Msg
  | OnLocationChange Location
  | None
  | HandlePerson (Result Http.Error Person)
  | NavbarMsg Navbar.State
