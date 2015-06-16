{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  ) where

------------------------------------------------------------------------------
import           Data.ByteString (ByteString)
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Util.FileServe
------------------------------------------------------------------------------
import           Application ( App(..)
                             , heist
                             )

import Data.Monoid ((<>))

------------------------------------------------------------------------------
-- | Show a category
handleShowCategory :: Handler App App ()
handleShowCategory = do
  writeCategory =<< getParam "category"
  where
    writeCategory (Just c) = writeBS $ "Here should be your category: " <> c
    writeCategory Nothing = writeBS "Here should be a tree of categories"

------------------------------------------------------------------------------
-- | New category
handleNewCategory :: Handler App App ()
handleNewCategory = do
    writeBS "Here should be a form to create a new Category"

------------------------------------------------------------------------------
-- | Show a rating
handleShowRating :: Handler App App ()
handleShowRating = do
  showRating =<< getParam "rating"
  where
    showRating (Just r) = writeBS $ "Here should be your rating: " <> r
    showRating Nothing  = writeBS "Here should be a list of all ratings"

------------------------------------------------------------------------------
-- | New Rating
handleNewRating :: Handler App App ()
handleNewRating = do
    writeBS "Here should be a form to create a new Rating"

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/category/:category",  handleShowCategory)
         , ("/category/",           handleShowCategory)
         , ("/category/new",        handleNewCategory)
         , ("/rating/",             handleShowRating)
         , ("/rating/:rating",      handleShowRating)
         , ("/rating/new",          handleNewRating)
         , ("",                     serveDirectory "static")
         ]


------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    h <- nestSnaplet "" heist $ heistInit "templates"
    addRoutes routes
    return $ App h

