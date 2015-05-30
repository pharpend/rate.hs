{-# Language FlexibleInstances #-}
{-# Language OverloadedStrings #-}

module DB.Query
where

import Snap
import Snap.Snaplet.PostgresqlSimple
import Control.Monad.IO.Class (liftIO)
import Application
import DB.Category
import DB.Rate

getAllCategories :: AppHandler ()
getAllCategories = do
  cats <- query_ "SELECT * FROM categories"
  liftIO $ print (cats :: [Category])

getAllRates :: AppHandler ()
getAllRates = do
  rates <- query_ "SELECT * FROM rates"
  liftIO $ print (rates :: [Rate])

