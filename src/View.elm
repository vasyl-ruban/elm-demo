module View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.CDN as CDN
import Bootstrap.Navbar as Navbar

import Model exposing (..)

import Inc

-- View
view : Model -> Html Msg
view model =
  Grid.containerFluid []
    [
       CDN.stylesheet
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
      , Navbar.itemLink [href "#person/1"] [ text "person"]
      , Navbar.itemLink [href "#asdf"] [ text "not found"]
      ]
    |> Navbar.view model.navbarState

footer : Model -> Html Msg
footer model =
  Grid.row [] [
    Grid.col [Col.xs12] [text "footer"]
  ]

page : Model -> Html Msg
page model =
  case model.route of
    Home -> home model
    About -> about model
    PersonRoute personId -> person model personId
    NotFound -> notFound model

home : Model -> Html Msg
home model =
  Grid.row []
    [ Grid.col [Col.xs12] [
        h1 [] [text "Home page"]
      ]
    , Grid.col [Col.xs12] [Html.map Inc (Inc.view model.incModel)]
    ]

about : Model -> Html Msg
about model =
  Grid.row []
    [ Grid.col [Col.xs12] [
        h1 [] [text "About"]
      ]
    , Grid.col [Col.xs12] [Html.map Inc (Inc.view model.incModel)]
    ]

person : Model -> String -> Html Msg
person model personId =
  Grid.row []
    [ Grid.col [Col.xs12] [
        h1 [] [text "Person"]
      ]
    , Grid.col [Col.xs12] [renderPerson model.person]
    , Grid.col [Col.xs12] [renderPaginator model]
    ]

renderPaginator : Model -> Html Msg
renderPaginator model =
    case model.route of
      PersonRoute personId ->
        Grid.row [] [
          Grid.col [Col.xs6] [a [class "btn btn-primary", href ("#person/" ++ getPrevId personId)] [text (getPrevId personId)]],
          Grid.col [Col.xs6] [a [class "btn btn-primary", href ("#person/" ++ getNextId personId)] [text (getNextId personId)]]
        ]

      _ -> span [] []

getNextId : String -> String
getNextId strId =
  case String.toInt strId of
    Ok intId ->
      toString (intId + 1)
    Err _ ->
      strId

getPrevId : String -> String
getPrevId strId =
  case String.toInt strId of
    Ok intId ->
      toString (intId - 1)
    Err _ ->
      strId

renderPerson : Person -> Html Msg
renderPerson person =
  table []
  [ tr []
    [ td [] [text "name"]
    , td [] [text person.name]
    ]
  , tr []
    [ td [] [text "height"]
    , td [] [text person.height]
    ]
  , tr []
    [ td [] [text "mass"]
    , td [] [text person.mass]
    ]
  ]

notFound : Model -> Html Msg
notFound model =
  Grid.row [] [
    Grid.col [Col.xs12] [h1 [] [text "Not found"]]
  ]
