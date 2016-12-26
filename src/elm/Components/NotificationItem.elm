module Components.NotificationItem exposing (Model, view, Notification)

import Html exposing (..)
import Html.Attributes exposing (..)

type alias Notification =
  {
    id: String
  , isSeen: Bool
  , isRead: Bool
  , message: String
  }

type alias Model =
  {
    notification: Notification
  }

-- view : Model -> Html Msg
view model =
  li [ class "c-feed-item" ]
    [
      a [ class "c-feed-item-link o-media-block u-padding-small" ]
        [
          img [ class "o-media-block-media c-avatar", src "http://lorempixel.com/24/24"] []
        , div [ class "o-media-block-body" ]
          [
            span [ class "u-type-small u-margin-bottom-x-small u-display-block"]
              [ text model.message]
          , span [ class "u-type-hint u-type-mute u-type-small"]
            [ text "9:00am (a moment ago)"]
          ]
    ]
  ]
  