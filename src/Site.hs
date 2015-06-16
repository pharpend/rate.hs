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
    writeCategory Nothing = writeBS "No category passed"

------------------------------------------------------------------------------
-- | Show a rating
handleShowRating :: Handler App App ()
handleShowRating = do
  showRating =<< getParam "rating"
  where
    showRating (Just r) = writeBS $ "Here should be your rating: " <> r
    showRating Nothing  = writeBS "No rating passed"

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/category/:category",  handleShowCategory)
         , ("/rating/:rating",      handleShowRating)
         , ("",                     serveDirectory "static")
         ]


------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    h <- nestSnaplet "" heist $ heistInit "templates"
    addRoutes routes
    return $ App h

