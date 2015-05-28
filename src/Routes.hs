module Routes
( routes
) where

import Snap ( Method
            , method
            , MonadSnap
            , GET
            , POST
            )

import DB.Query ( allCategories
                , newCategory
                )

get :: MonadSnap Get
get = method GET

post :: MonadSnap POST
post = method POST

routes :: Method a => (String, MonadSnap a)
routes = [ ("/category/list/all", get allCategories)
         , ("/category/new", post newCategory)
         , ("/category/del", post delCategory)
         ]


