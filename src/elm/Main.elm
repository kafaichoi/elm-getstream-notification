port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick )

-- APP
main : Program Never Model Msg
main =
  Html.program
    {
      init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

port loadMoreNotifications : () -> Cmd msg

port notifications : (List Notification -> msg) -> Sub msg

-- MODEL
type alias Model =
  {
    notifications : List Notification
  , userId: Maybe String
  }

type alias Notification =
  {
    id: String
  , isSeen: Bool
  , isRead: Bool
  , message: String
  }

init : (Model, Cmd Msg)
init =
  (
    {
      notifications = [
        {
          id = "id1"
        , isSeen = True
        , isRead = True
        , message = "Yoooo"
        }
      ]
    , userId = Nothing
    },
    Cmd.none
  )
model : number
model = 0


-- UPDATE
type Msg = NoOp
         | LoadMoreNotifications
         | NewNotifications (List Notification)

update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
    NoOp -> (model, Cmd.none)
    LoadMoreNotifications -> (model, loadMoreNotifications())
    NewNotifications notifications -> ({model | notifications = notifications}, Cmd.none)

-- Subscription
subscriptions : Model -> Sub Msg
subscriptions model =
  notifications (\notifications -> NewNotifications notifications)


-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
  div [ class "container", style [("margin-top", "30px"), ( "text-align", "center" )] ][    -- inline CSS (literal)
    div [ class "row" ][
      div [ class "col-xs-12" ][
        div [ class "jumbotron" ] (List.map (\noti -> span [] [text noti.message]) model.notifications),
        div [ class "jumbotron" ] [
          button [onClick LoadMoreNotifications] [text "yooo"]
        ]
      ]
    ]
  ]


-- CSS STYLES
styles : { img : List ( String, String ) }
styles =
  {
    img =
      [ ( "width", "33%" )
      , ( "border", "4px solid #337AB7")
      ]
  }
