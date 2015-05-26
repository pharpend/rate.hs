module DB.Category
( Category
, Entity
) where

import Data.Function (on)
import DB.Rate (Rate)
import qualified Data.Text as T

type Entity = Either Category Rate

data Category = Category { title :: String
                         , description :: T.Text
                         , entries :: [Entity] }

instance Ord Category where
  compare = compare `on` title

instance Eq Category where
  (==) = (==) `on` title

