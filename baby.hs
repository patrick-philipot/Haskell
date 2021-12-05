-- HASKELL mini doc

-- GHCI
-- changer le prompt
-- |	:set prompt "ghci> "
-- |	sous MAc le caractère | s'obtient avec les touches Shift+Option+L

-- Exemples de foncions

doubleUs x y = doubleMe x + doubleMe y
doubleMe x = x + x
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

--  LISTS
--  Tous les éléments sont du même type

lostNumbers = [4,8,15,16,23,42]

-- |	head lostNumbers
-- |	tail lostNumbers
-- |	last lostNumbers
-- |	init lostNumbers
-- |	take 3 lostNumbers
-- |	drop 3 lostNumbers
-- |	sum lostNumbers
-- |	product lostNumbers
-- |	elem 16 lostNumbers

-- RANGES

the20first = [1 .. 20]
-- |	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

-- Range permet de créer des listes infinies
-- |	[ 1 ..]					attention elle est vraiment infinie et peut planter Ghci
-- cycle et repeat créent des listes infinies
-- take 10 (cycle [1,2,3])
-- take 10 (repeat 5)

-- LIST COMPREHENSION

-- |	une liste de doubles
doubleList = [x*2 | x <- [1..10]]

-- |	la même avec seulement ceux > 12
doubleList' = [x*2 | x <- [1..10], x*2 >= 12]

-- |	recréation de la fonction length
length' xs = sum [1 | _ <- xs]

-- | 	le caractère _ remplace une variable qui ne sera pas utilisée
-- |	ici on obtient une liste de 1  : [1,1,1,1,1]
cinqUN = [1 | _ <- [1..5]]

-- |	les chaines sont des listes de caractères
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- removeNonUppercase "Hello World!"		-> "HW"

-- TUPLES (x, y)
-- x et y ne sont pas nécessairement du même type

-- fst(1, "Hello")							-> 1
-- snd(1, "Hello")							-> "Hello"

-- ZIP contruit une liste de tuples à partir de 2 listes
fruits = zip [1 ..]["apple", "orange", "cherry", "mango"]

-- | [(1,"apple"),(2,"orange"),(3,"cherry"),(4,"mango")]

rightTriangles = [ (a,b,c) | c <- [1..10] , b <- [1..c] , a <- [1..b] , a^2 + b^2 == c^2, a+b+c == 24]

-- recherche des triangles rectangles avec c hypothénuse, coté dans 1..10 et somme des cotés = 24
-- [(6,8,10)]

-- TYPES AND TYPES CLASSES p20







