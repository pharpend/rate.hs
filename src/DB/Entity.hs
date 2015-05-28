module DB.Entity where

import DB.Rate (Rate)
import DB.Category (Category)
import Database.PostgreSQL.Simple.FromRow

data Entity = Category | Rate deriving (Show, Eq, Ord, FromRow)


