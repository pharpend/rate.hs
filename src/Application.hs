{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FlexibleInstances #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application
( App(..)
, heist
, AppHandler
) where

------------------------------------------------------------------------------
import Control.Lens
import Snap
import Snap.Snaplet.Heist

------------------------------------------------------------------------------
data App = App
    { _heist :: Snaplet (Heist App)
    }

makeLenses ''App

instance HasHeist App where
    heistLens = subSnaplet heist

------------------------------------------------------------------------------
type AppHandler = Handler App App


