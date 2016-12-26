module Model exposing (..)
import Components.NotificationItem.Model as NotificationItem

-- MODEL
type alias Model =
  {
    notifications : List NotificationItem.Model
  , userId: Maybe String
  }

-- UPDATE
type Msg = NoOp
         | LoadMoreNotifications
         | NewNotifications (List NotificationItem.Notification)
         | NotificationItemMsg NotificationItem.Msg
