module Update exposing (init, update, subscriptions)

import Model exposing (..)
import Ports
import Components.NotificationItem.Model as NotificationItemModel
import GetStream

init : (Model, Cmd Msg)
init =
  (
    {
      notifications = []
    , userId = Nothing
    },
    Cmd.none
  )

update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
    NoOp -> (model, Cmd.none)
    LoadMoreNotifications -> (model, Ports.loadMoreNotifications())
    NewNotifications notifications -> ({model | notifications = notifications |> List.map(NotificationItemModel.Model)}, Cmd.none)
    NotificationItemMsg notificationItemMsg ->
      case notificationItemMsg of
        NotificationItemModel.MarkAsSeen notificationItemId -> (model, GetStream.markOneNotificationAsSeen(notificationItemId))

-- Subscription
subscriptions : Model -> Sub Msg
subscriptions model =
  Ports.notifications (\notifications -> NewNotifications notifications)

