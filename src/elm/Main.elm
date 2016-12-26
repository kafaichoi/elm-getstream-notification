port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick )
import Components.NotificationItem as NotificationItem

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

port notifications : (List NotificationItem.Notification -> msg) -> Sub msg

-- MODEL
type alias Model =
  {
    notifications : List NotificationItem.Notification
  , userId: Maybe String
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
         | NewNotifications (List NotificationItem.Notification)

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
  div [ class "c-inbox js-close-inbox-with-bg-tint" ]
    [ div [ class "o-container u-background-white u-padding-normal u-box-shadow-heavy u-border-radius-rounded" ]
      [ div [ class "o-row u-padding-bottom-large" ]
        [ div [ class "o-col-xs-6" ]
          [ div [ class "c-btn-group" ]
            [ button [ class "c-btn c-btn--medium c-btn--mute"]
              [ text "All" ]
            , button [ class "c-btn c-btn--medium c-btn--mute is-active"]
              [ text "Unread "
              , span [ class "c-badge c-badge--small c-badge--plain" ]
                [ text "20" ]
              ]
            ]
          ]
        , div [ class "o-col-xs-6 u-type-align-right" ]
          [ button [ class "c-btn c-btn--medium c-btn--mute c-btn--mute--to-info" ]
            [ text "Mark all as read" ]
          ]
        ]
        , ol [ class "u-unstyle c-feed c-feed--line u-display-block"]
          (List.map (\noti -> NotificationItem.view noti) model.notifications)
        , div [ class "jumbotron" ] [ button [onClick LoadMoreNotifications] [text "load more"]]
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
