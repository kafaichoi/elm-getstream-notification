port module Ports exposing (..)

import Components.NotificationItem.Model as NotificationItem

port loadMoreNotifications : () -> Cmd msg

port notifications : (List NotificationItem.Notification -> msg) -> Sub msg

port markOneNotificationAsSeen : NotificationItem.NotificationId -> Cmd msg

port setVisibility : (Bool -> msg ) -> Sub msg