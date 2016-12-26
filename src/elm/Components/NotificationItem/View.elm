module Components.NotificationItem.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.NotificationItem.Model exposing (..)

view : Model -> Html Msg
view model =
  let
    containerClass = if model.notification.isSeen then "c-feed-item" else "c-feed-item u-highlight-info"
  in 
    li [ class containerClass, onClick(MarkAsSeen model.notification.id) ]
      [
        a [ class "c-feed-item-link o-media-block u-padding-small" ]
          [
            img [ class "o-media-block-media c-avatar", src "http://lorempixel.com/24/24"] []
          , div [ class "o-media-block-body" ]
            [
              span [ class "u-type-small u-margin-bottom-x-small u-display-block"]
                [ text model.notification.message]
            , span [ class "u-type-hint u-type-mute u-type-small"]
              [ text "9:00am (a moment ago)"]
            ]
      ]
    ]
  