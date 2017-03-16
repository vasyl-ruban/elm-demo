module App exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.Navbar as Navbar
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.CDN as CDN
import Bootstrap.Navbar as Navbar
import Debug

import Person.Person as Person


-- Types


type Route
  = Main
  | PersonRoute Person.Route
  | ParamPage Int
  | NotFound

type alias Model =
  {
    navbarState: Navbar.State,
    route: Route,
    personModel: Person.Model
  }

type Msg
  = OnLocationChange Location
  | PersonMsg Person.Msg
  | NavbarMsg Navbar.State


-- State


initModel : Route -> (Model, Cmd Msg)
initModel route =
  let
    (navbarState, navbarCmd) =
      Navbar.initialState NavbarMsg
  in
    Model navbarState route Person.initPersonModel ! [navbarCmd]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    OnLocationChange location ->
      let
        newRoute =
            parseLocation location
      in
        { model | route = newRoute} ! []

    NavbarMsg state ->
      { model | navbarState = state } ! []

    PersonMsg personMsg ->
      model ! []

matchers: Parser (Route -> a) a
matchers =
  oneOf
    [ UrlParser.map Main top
    , UrlParser.map ParamPage (UrlParser.s "param" </> UrlParser.int)
    , UrlParser.map (PersonRoute Person.PersonListRoute) (UrlParser.s "persons")
    , UrlParser.map PersonRoute (UrlParser.map Person.PersonRoute (UrlParser.s "person" </> UrlParser.int))
    ]

parseLocation: Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route
    Nothing ->
      NotFound


-- View

view : Model -> Html Msg
view model =
  Grid.containerFluid []
    [ CDN.stylesheet
    , navbar model
    , page model
    , footer model
    ]

navbar : Model -> Html Msg
navbar model =
  Navbar.config NavbarMsg
    |> Navbar.brand [ href "#"] [ text "Brand"]
    |> Navbar.items
      [ Navbar.itemLink [href "#about"] [ text "about"]
      , Navbar.itemLink [href "#persons"] [ text "persons"]
      , Navbar.itemLink [href "#person/1"] [ text "person1"]
      , Navbar.itemLink [href "#asdf"] [ text "not found"]
      ]
    |> Navbar.view model.navbarState

page : Model -> Html Msg
page model =
  case model.route of
    Main -> mainPage model
    ParamPage i -> mainPage model
    PersonRoute route -> Html.map PersonMsg (Person.view model.personModel route)
    NotFound -> notFound model

footer : Model -> Html Msg
footer model =
  div [] [text (toString model)]

mainPage : Model -> Html Msg
mainPage model =
  Grid.row []
    [ Grid.col [Col.xs12] [h1 [] [text "Main page"]]
    ]

notFound : Model -> Html Msg
notFound model =
  Grid.row [] [
    Grid.col [Col.xs12] [h1 [] [text "Not found"]]
  ]

-- Main

init : Location -> (Model, Cmd Msg)
init location =
  let
    currentRoute =
      parseLocation location
  in
    initModel currentRoute

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
  Navigation.program OnLocationChange
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }
