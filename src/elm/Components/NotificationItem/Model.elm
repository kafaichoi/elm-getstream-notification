module Components.NotificationItem.Model exposing (..)

type alias NotificationId = String
type alias Notification =
  {
    id: NotificationId
  , isSeen: Bool
  , isRead: Bool
  , message: String
  }

type alias Model =
  {
    notification: Notification
  }

type Msg =
  MarkAsSeen NotificationId