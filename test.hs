-- | qs :: (Ord a) => [a] -> [a]
-- | qs [] = []
-- | qs (x:xs) = smallerSorted ++ [x] ++ biggerSorted
-- |   where smallerSorted = qs (filter (<=x) xs)
-- |         biggerSorted = qs (filter (>x) xs)

-- chain :: (Integral a) => a -> [a]
-- chain 1 = [1]
-- chain n
--   | even n = n:chain (n `div` 2)
--   | odd n = n:chain (n*3 + 1)
-- 
-- numLongChains :: Int
-- numLongChains = length (filter isLong (map chain [1..100]))
--   where isLong xs = length xs > 15

phoneBook =
  [("betty","555-2938")
  ,("bonnie","452-2928")
  ,("patsy","493-2928")
  ,("lucille","205-2928")
  ,("wendy","939-8282")
  ,("penny","853-2492")
  ]


-- findKey :: (Eq k) => k -> [(k,v)] -> Maybe v
-- findKey key [] = Nothing
-- findKey key ((k,v):xs) = if key == k
--                             then Just v
--                             else findKey key xs


findKey :: (Eq k) => k -> [(k,v)] -> Maybe v
findKey key = foldr (\(k,v) acc -> if key == k then Just v else acc) Nothing                            