module Person.Model exposing (..)

import UrlParser exposing (..)
import Http

type alias PersonId = Int

type alias Person =
  {
    name: String,
    height: String,
    mass: String
  }

type alias Model =
  { personList: List Person
  , personListPageId: Int
  , person: Person
  }

type Msg
  = LoadPersonList Int
  | HandlePersonList (Result Http.Error (List Person))
  | LoadPerson Int
  | HandlePerson (Result Http.Error Person )

type Route
  = PersonRoute PersonId
  | PersonListRoute



initPersonModel : Model
initPersonModel =
  Model [] 1 initPerson

initPerson : Person
initPerson =
  Person "" "" ""

matchers : Parser (Route -> a) a
matchers =
  oneOf
    [ UrlParser.map PersonListRoute (UrlParser.s "persons")
    , UrlParser.map PersonRoute (UrlParser.s "person" </> UrlParser.int)
    ]
