module DB.Category
( Category
, Entity
) where

import Control.Applicative
import DB.Rate (Rate)
import Data.Function (on)
import Database.PostgreSQL.Simple.FromRow
import qualified Data.Text as T

type Entity = Either Category Rate

data Category = Category { title :: String
                         , description :: T.Text
                         , entries :: [Entity] }

instance Ord Category where
  compare = compare `on` title

instance Eq Category where
  (==) = (==) `on` title

