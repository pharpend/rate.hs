{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FlexibleInstances #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application
( App(..)
, heist
, sess
, auth
, pg
, AppHandler
) where

------------------------------------------------------------------------------
import Control.Lens
import Snap
import Control.Monad.State
import Control.Monad.Reader
import Snap.Snaplet.Heist
import Snap.Snaplet.Auth
import Snap.Snaplet.Session
import Snap.Snaplet.PostgresqlSimple

------------------------------------------------------------------------------
data App = App
    { _heist :: Snaplet (Heist App)
    , _sess :: Snaplet SessionManager
    , _auth :: Snaplet (AuthManager App)
    , _pg    :: Snaplet Postgres
    }

makeLenses ''App

instance HasHeist App where
    heistLens = subSnaplet heist

instance HasPostgres (Handler b App) where
  getPostgresState = with pg get
  setLocalPostgresState s = local $ set (pg . snapletValue) s

------------------------------------------------------------------------------
type AppHandler = Handler App App


