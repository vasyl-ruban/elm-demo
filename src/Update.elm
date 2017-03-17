module Update exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)

import Model exposing (..)

import Person.Update as PersonUpdate

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    OnLocationChange location ->
      locationChangeHandler model location

    NavbarMsg state ->
      { model | navbarState = state } ! []

    PersonMsg personMsg ->
      let
        (personModel, cmd) =
          PersonUpdate.update personMsg model.personModel
      in
        {model | personModel = personModel } ! [Cmd.map PersonMsg cmd]

locationChangeHandler : Model -> Location -> (Model, Cmd Msg)
locationChangeHandler model location =
  let
    newRoute =
        parseLocation location
  in
    case newRoute of
      PersonRoute route ->
        let
          (personModel, personMsg) =
            PersonUpdate.changeRouteHandler model.personModel route
        in
          {model |
            route = newRoute,
            personModel = personModel
          } ! [Cmd.map PersonMsg personMsg]
      _ ->
        {model | route = newRoute} ! []


parseLocation: Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route
    Nothing ->
      NotFound
