module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick )
import Model exposing (..)
import Components.NotificationItem.View as NotificationItemView
import Components.NotificationItem.Model as NotificationItemModel

-- VIEW
renderNotficationItem : NotificationItemModel.Model -> Html Msg
renderNotficationItem notificationItemModel =
   notificationItemModel
    |> NotificationItemView.view
    |> (Html.map(\msg -> NotificationItemMsg msg))

renderToggleButtonsGroup : Bool -> Int -> Html Msg
renderToggleButtonsGroup isShowingAllNotificaions unreadCount =
  let
    (allButtonClass, unreadButtonClass) =
      if isShowingAllNotificaions then
        ("c-btn c-btn--medium c-btn--mute is-active", "c-btn c-btn--medium c-btn--mute")
      else
        ("c-btn c-btn--medium c-btn--mute", "c-btn c-btn--medium c-btn--mute is-active")
  in
    div [ class "c-btn-group" ]
      [ button [ class allButtonClass, onClick(SetShowAllNotification True)]
        [ text "All" ]
      , button [ class unreadButtonClass, onClick(SetShowAllNotification False)]
        [ text "Unread "
        , span [ class "c-badge c-badge--small c-badge--plain" ]
          [ text(toString unreadCount) ]
        ]
      ]

view : Model -> Html Msg
view model =
  let
    unreadCount =
      model.notifications
      |> List.filter(\n -> not n.isSeen)
      |> List.length
    containerStyle =
      if model.isVisible then
        []
      else
        styles.invisible
    notificationItems =
      model.notifications
        -- |> (List.map (\noti -> Html.map(\_ -> (noti))))
        |>(List.map renderNotficationItem)
  in
  div [ class "c-inbox js-close-inbox-with-bg-tint", style containerStyle]
    [ div [ class "o-container u-background-white u-padding-normal u-box-shadow-heavy u-border-radius-rounded" ]
      [ div [ class "o-row u-padding-bottom-large" ]
        [ div [ class "o-col-xs-6"]
          [renderToggleButtonsGroup model.isShowingAllNotificaions unreadCount]
        , div [ class "o-col-xs-6 u-type-align-right" ]
          [ button [ class "c-btn c-btn--medium c-btn--mute c-btn--mute--to-info" ]
            [ text "Mark all as read" ]
          ]
        ]
        , ol [ class "u-unstyle c-feed c-feed--line u-display-block"] notificationItems
        , div [ class "jumbotron" ] [ button [onClick LoadMoreNotifications] [text "load more"]]
      ]
    ]

-- CSS STYLES
styles : { invisible : List ( String, String ) }
styles =
  {
    invisible =
      [ ( "visibility", "hidden") ]
  }
