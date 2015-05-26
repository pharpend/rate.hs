module DB.Rate
( Rate
, mkRate
) where

import Data.Text
import Data.Function (on)

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

instance Read Rate where
  read title = Rate title "" Nothing

mkRate :: String -> Text -> Rate
mkRate title text = Rate title text Nothing

