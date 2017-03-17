module Person.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Table as Table
import Bootstrap.Form as Form
import Bootstrap.Button as Button

import Person.Model exposing (..)

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
    , Grid.col [Col.xs12] [personForm model.person]
    ]

personForm : Person -> Html Msg
personForm person =
  Form.form []
  [ Form.row []
    [ Form.colLabel [Col.xs3] [text "Name"]
    , Form.colLabel [Col.xs3] [text person.name]
    ]
  , Form.row []
    [ Form.colLabel [Col.xs3] [text "Height"]
    , Form.colLabel [Col.xs3] [text person.height]
    ]
  , Form.row []
    [ Form.colLabel [Col.xs3] [text "Mass"]
    , Form.colLabel [Col.xs3] [text person.mass]
    ]
  ]

personPaginator : PersonId -> Html Msg
personPaginator personId =
  Grid.row []
    [ Grid.col [Col.xs6] [a [class "btn btn-primary", href ("#person/" ++ toString (personId-1))] [text ("Person " ++ toString (personId-1))]]
    , Grid.col [Col.xs6] [a [class "btn btn-primary", href ("#person/" ++ toString (personId+1))] [text ("Person " ++ toString (personId+1))]]
    ]

personRow : Int -> Person -> Table.Row Msg
personRow index person =
  Table.tr []
    [ Table.td [] [text person.name]
    , Table.td [] [text person.height]
    , Table.td [] [text person.mass]
    , Table.td [] [
        a [href ("#person/" ++ (toString (index+1))) ] [text "details"]
      ]
    ]


personListView : Model -> Html Msg
personListView model =
  Grid.row []
    [ Grid.col [Col.xs12] [h1 [] [text "Person list"]]
    , Grid.col [Col.xs12] [
        Table.table
        { options = [ Table.striped ]
        , thead = Table.simpleThead
                  [ Table.th [] [text "name"]
                  , Table.th [] [text "height"]
                  , Table.th [] [text "mass"]
                  ]
        , tbody = Table.tbody [] (List.indexedMap personRow model.personList)
        }
      ]
    , Grid.col [Col.xs12]
      [ Button.button
          [ Button.primary
          , Button.attrs [onClick (LoadPersonList model.personListPageId)]
          ] [text "Load more"]
      ]
    ]
