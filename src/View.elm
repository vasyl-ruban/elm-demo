module View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.Navbar as Navbar
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.CDN as CDN
import Bootstrap.Navbar as Navbar

import Model exposing (..)

import Person.View as PersonView

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
    |> Navbar.brand [ href "#"] [ text "Main"]
    |> Navbar.items
      [ Navbar.itemLink [href "#persons"] [ text "persons"]
      , Navbar.itemLink [href "#asdf"] [ text "not found"]
      ]
    |> Navbar.view model.navbarState

page : Model -> Html Msg
page model =
  case model.route of
    Main -> mainPage model
    ParamPage i -> mainPage model
    PersonRoute route -> Html.map PersonMsg (PersonView.view model.personModel route)
    NotFound -> notFound model

footer : Model -> Html Msg
footer model =
  -- div [] [text (toString model)]
  div [] []

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
