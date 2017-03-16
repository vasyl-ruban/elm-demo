module Person.Person exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
-- Types

type alias PersonId = Int

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
      personView personId model
    PersonListRoute ->
      personListView model

personView : PersonId -> Model -> Html Msg
personView personId model =
  Grid.row []
    [ Grid.col [Col.xs12] [h1 [] [text ("Person " ++ toString personId)]]
    , Grid.col [Col.xs12] [personPaginator personId]
    ]

personPaginator : PersonId -> Html Msg
personPaginator personId =
  Grid.row []
    [ Grid.col [Col.xs6] [a [class "btn btn-primary", href ("#person/" ++ toString (personId-1))] [text ("Person " ++ toString (personId-1))]]
    , Grid.col [Col.xs6] [a [class "btn btn-primary", href ("#person/" ++ toString (personId+1))] [text ("Person " ++ toString (personId+1))]]
    ]

personListView : Model -> Html Msg
personListView model =
  Grid.row []
    [ Grid.col [Col.xs12] [h1 [] [text "Person list"]]
    ]
