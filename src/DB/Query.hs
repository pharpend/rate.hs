module DB.Query
( getAllCategories
, newCategory
) where

import DB.Category (Category)
import Snap
import Snap.Snaplet.PostgresqlSimple
import Control.Monad.IO.Class
import Application

allCategories :: Handler App App ()
allCategories = do
  cats <- query_ "SELECT * FROM Categories"
  liftIO $ print (cats :: [Category])

newCategory :: Handler App App ()
newCategory = do
  title <- getPostParam "title"
  descr <- getPostParam "description"
  newCat <- execute "INSERT INTO Categories VALUES (?, ?)" (title, descr)
  redirect "/category/list/all"

delCategory :: Handler App App ()
delCategory = do
  title <- getPostParam "title"
  deleteProject <- execute "DELETE FROM Categories WHERE title = ?" (Only title)
  redirect "/"

