module Person.View exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Html exposing (..)

import Person.Types exposing (..)

personView: Model -> Html Msg
personView model =

  Grid.row []
    [ Grid.col [Col.xs12] [h1 [] [text "Person Page Main View"]]
    ]
