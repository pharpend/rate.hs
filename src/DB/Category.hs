module DB.Category
( Category
, Entity
) where

import Data.Function (on)
import DB.Rate (Rate)
import qualified Data.Text as T
import Control.Applicative
import Database.PostgreSQL.Simple.FromRow

type Entity = Either Category Rate

data Category = Category { title :: String
                         , description :: T.Text
                         , entries :: [Entity] }

instance Ord Category where
  compare = compare `on` title

instance Eq Category where
  (==) = (==) `on` title

instance FromRow Category where
  fromRow = Category <$> field <*> field <*> field

