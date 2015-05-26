module DB.Category
( Category
, putEntity
) where

import DB.Entity
import Data.Function (on)

data Category = Category { title :: String
                         , entries :: [Entity] }

instance Ord Category where
  compare = compare `on` title

instance Eq Category where
  (==) = (==) `on` title

instance Show Category where
  show (Category t []) = show t
  show (Category t es) = show t ++ "\n" ++ treeShow 0 es
    where
      treeShow n [] = ""
      treeShow n ((Category t es),xs) =indent ++ thisTree ++ restTree
      where
        indent = replicate n "\t"
        thisTree = treeShow (succ n) es
        restTree = treeShow n xs

instance Read Category where
  read title = Category title []

putEntity :: Category -> Entity -> Category
putEntity (Category title xs) e = Category title (e : xs)

