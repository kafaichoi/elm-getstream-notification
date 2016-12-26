module GetStream exposing (..)

import Components.NotificationItem.Model exposing (..)
import Ports

markOneNotificationAsSeen : NotificationId -> Cmd msg
markOneNotificationAsSeen notificationId =
  Ports.markOneNotificationAsSeen(notificationId)