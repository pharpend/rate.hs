{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs, TypeFamilies, QuasiQuotes, StandaloneDeriving #-}

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

import Database.Groundhog.TH
import Database.Groundhog.Sqlite
import Control.Monad.IO.Class (liftIO)

import Data.Text (Text)
import qualified Data.Text as T

------------------------------------------------------------------------------
data App = App
    { _heist :: Snaplet (Heist App)
    }

makeLenses ''App

instance HasHeist App where
    heistLens = subSnaplet heist

------------------------------------------------------------------------------
type AppHandler = Handler App App

------------------------------------------------------------------------------

data Category = Category { cName :: String
                         , cDesc :: Text
                         }
                         deriving Show

data Rating = Rating { rName :: String
                     , rDesc :: Text
                     , cat  :: DefaultKey Category
                     }
