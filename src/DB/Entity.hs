module DB.Entity where

import DB.Rate (Rate)
import DB.Category (Category)

data Entity = Category | Rate deriving (Show, Eq, Ord)


