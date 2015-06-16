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
    , _gh    :: Pool Sqlite
    }

makeLenses ''App

instance HasHeist App where
    heistLens = subSnaplet heist

instance ConnectionManager App Sqlite where
  withConn f app = withConn f (_gh app)
  withConnNoTransaction f app = withConnNoTransaction f (_gh app)

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

mkPersist defaultCodegenConfig [groundhog|
- entity: Category
  constructors:
    - name: Category
      fields:
        - name: cName
      uniques:
        - name: NameConstraint
          fields: [cName]
- entity: Rating
  constructors:
    - name: Rating
      fields:
        - name: rName
      uniques:
        - name: NameConstraint
          fields: [rName]
|]

