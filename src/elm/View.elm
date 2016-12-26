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

view : Model -> Html Msg
view model =
  let
    notificationItems =
      model.notifications
        -- |> (List.map (\noti -> Html.map(\_ -> (noti))))
        |>(List.map renderNotficationItem)
  in
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
        , ol [ class "u-unstyle c-feed c-feed--line u-display-block"] notificationItems
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
