module DB.Rate
( Rate
, mkRate
) where

import Data.Text
import Data.Function (on)
import Database.PostgreSQL.Simple.FromRow

type Rating = Maybe Int

data Rate = Rate { id :: Int
                 , categoryId :: Int
                 , title :: String
                 , text :: Text
                 , rating :: Rating
                 }

instance Eq Rate where
  (==) = (==) `on` title

instance Ord Rate where
  compare = compare `on` rating

instance Show Rate where
 show (Rate t _ Nothing)  = t ++ " [<no rating>]"
 show (Rate t _ (Just r)) = t ++ " [" ++ show r ++ "]"

instance FromRow Rate where
  fromRow = Rate <$> field <*> field <*> field <*> field <*> field

instance ToRow Rate where
  toRow Rate{..} = [ toField id
                   , toField categoryId
                   , toField title
                   , toField text
                   , toField rating
                   ]

mkRate :: String -> Text -> Rate
mkRate t x = Rate t x Nothing

