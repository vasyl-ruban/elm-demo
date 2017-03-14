module Routing exposing (..)

import Navigation exposing (Location)
import Model exposing (Route(..))
import UrlParser exposing (..)


matchers: Parser (Route -> a) a
matchers =
  oneOf
    [ map Home top
    , map About (s "about")
    ]


parseLocation: Location -> Route
parseLocation location =
  case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound
