module DB.Rate
( Rate
, mkRate
) where

import Data.Text
import Data.Function (on)
import Control.Applicative
import Database.PostgreSQL.Simple.FromRow

type Rating = Maybe Int

data Rate = Rate { title :: String
                 , text :: Text
                 , rating :: Rating
                 }

instance Eq Rate where
  (==) = (==) `on` title

instance Ord Rate where
  compare = compare `on` rating

instance Show Rate where
  show r = (title r) ++ " [" ++ (rating r) ++ "]"

instance FromRow Rate where
  fromRow = Rate <$> field <*> field <*> field

mkRate :: String -> Text -> Rate
mkRate title text = Rate title text Nothing

