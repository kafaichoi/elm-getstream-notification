module Components.NotificationItem.Update exposing (update)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.NotificationItem.Model exposing (..)
-- import Ports

update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
    MarkAsSeen notificationId -> (model, Cmd.none)
    -- MarkAsSeen notificationId -> (model, Ports.markOneNotificationAsSeen(notificationId))