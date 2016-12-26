module Main exposing (..)

import Html exposing (..)
import Update
import View
import Model


-- APP
main : Program Never Model.Model Model.Msg
main =
  Html.program
    {
      init = Update.init
    , view = View.view
    , update = Update.update
    , subscriptions = Update.subscriptions
    }
