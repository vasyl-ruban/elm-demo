module Model exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import Bootstrap.Navbar as Navbar

import Person.Model as PersonModel


type Route
  = Main
  | PersonRoute PersonModel.Route
  | ParamPage Int
  | NotFound

type alias Model =
  {
    navbarState: Navbar.State,
    route: Route,
    personModel: PersonModel.Model
  }

type Msg
  = OnLocationChange Location
  | PersonMsg PersonModel.Msg
  | NavbarMsg Navbar.State


initModel : Route -> (Model, Cmd Msg)
initModel route =
  let
    (navbarState, navbarCmd) =
      Navbar.initialState NavbarMsg
  in
    Model navbarState route PersonModel.initPersonModel ! [navbarCmd]


matchers: Parser (Route -> a) a
matchers =
  oneOf
    [ UrlParser.map Main top
    , UrlParser.map ParamPage (UrlParser.s "param" </> UrlParser.int)
    , UrlParser.map PersonRoute PersonModel.matchers
    ]
