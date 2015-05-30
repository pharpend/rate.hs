{-# Language RecordWildCards #-}

module DB.Category
( Category
) where

import Prelude hiding (id)
import Data.Function (on)
import qualified Data.Text as T
import Control.Applicative
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.ToField

data Category = Category { id :: Int
                         , title :: String
                         , description :: T.Text
                         }

instance Ord Category where
  compare = compare `on` title

instance Eq Category where
  (==) = (==) `on` title

instance FromRow Category where
  fromRow = Category <$> field <*> field <*> field

instance ToRow Category where
  toRow Category{..} = [ toField id
                       , toField title
                       , toField description
                       ]

