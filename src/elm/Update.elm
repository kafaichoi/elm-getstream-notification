module Update exposing (init, update, subscriptions)

import Model exposing (..)
import Ports
import Components.NotificationItem.Update as NotificationItem
import Components.NotificationItem.Model as NotificationItemModel

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
    _ -> (model, Cmd.none)
    -- NotificationItemMsg id -> NotificationItem.update id

-- Subscription
subscriptions : Model -> Sub Msg
subscriptions model =
  Ports.notifications (\notifications -> NewNotifications notifications)

