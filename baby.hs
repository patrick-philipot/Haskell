-- HASKELL mini doc

-- GHCI
-- changer le prompt
-- |	:set prompt "ghci> "
-- |	sous MAc le caractère | s'obtient avec les touches Shift+Option+L
-- |	:quit pour sortir

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

-- | la commande :t variable affiche le type d'une variable
-- | :t rightTriangles
-- | rightTriangles :: [(Integer, Integer, Integer)]

-- | Fonctionne aussi sur les fonctions
-- | ghci> :t removeNonUppercase
-- | removeNonUppercase :: [Char] -> [Char]

-- | La définition d'une fonction peut inclure une déclaration explicite des types
-- | removeNonUppercase :: [Char] -> [Char]
-- | removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- TYPES VARIABLES (généric)

-- La commande head fonctionne avec une liste de tous types
-- ici a désigne une valeur de tout type

-- | ghci> :t head
-- | head :: [a] -> a

-- On utilise des lettres minuscules pour désigner les types

-- | fst :: (a, b) -> a

-- LE TYPECLASSE précise les propriétés d'un élément
-- | Eq décrit qu'une valeur supporte l'égalité
-- ghci> :t (==)
-- (==) :: Eq a => a -> a -> Bool

-- Quelques typeclasses
-- Ord décrit des membres comparables avec <, >, >=, ...
-- Show des membres affichables sous forme de chaine

-- | ghci> show 1
-- | "1"

-- Read est le réciproque de show
-- | read "5" - 2
-- | 3

-- Num désigne les numériques, un Num est forcément un Show et un Eq
-- Exemple de la multiplication
-- | ghci> :t (*)
-- | (*) :: (Num a) => a -> a -> a

-- SYNTAX IN FUNCTIONS
-- La définition d'une fonction peut définir plusieurs patterns
-- L'ordre est important
-- | sayMe :: (Integral a) => a -> String
-- | sayMe 1 = "One!"
-- | sayMe 2 = "Two!"
-- | sayMe 3 = "Three!"
-- | sayMe 4 = "Four!"
-- | sayMe 5 = "Five!"
-- | sayMe x = "Not between 1 and 5"

sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

-- FONCTION Définie par récursion

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- GUARDS testent certaines propriétés p31

bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"










