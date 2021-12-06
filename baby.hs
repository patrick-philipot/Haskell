-- HASKELL mini doc

-- GHCI
-- changer le prompt
-- |	:set prompt "ghci> "
-- |	sous MAc le caractère | s'obtient avec les touches Shift+Option+L
-- |	:quit pour sortir
-- |	sous Windows :! cls vide la console

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

-- Le PATTERN something@ permet de guarder une référence sur l'intégralité de la liste
capital :: String -> String
capital "" = "Empty string, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

-- |	ghci> capital "spiderman"
-- |	"The first letter of spiderman is s"


-- GUARDS testent certaines propriétés p31

bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
  | a > b = GT
  | a == b = EQ
  | otherwise = LT

-- WHERE permet d'éviter les répétitions

bmiTell' :: (RealFloat a) => a -> a -> String
bmiTell' weight height
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  where bmi = weight / height ^ 2

bmiTell2 :: (RealFloat a) => a -> a -> String
bmiTell2 weight height
  | bmi <= skinny = "You're underweight, you emo, you!"
  | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= fat = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  where bmi = weight / height ^ 2
        skinny = 18.5
        normal = 25.0
        fat = 30.0

initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
  where (f:_) = firstname
        (l:_) = lastname

-- LET BINDING

cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
  let sideArea = 2 * pi * r * h
      topArea = pi * r ^2
  in  sideArea + 2 * topArea

-- il est possible d'utiliser le point-virgule plutôt que l'indentation

semicolons = (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)


-- CASE EXPRESSIONS

head' xs = case xs of [] -> error "No head for empty lists!"
                      (x:_) -> x


-- RECURSION p38

-- maximum
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

--zip
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

--elem
elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
  | a == x = True
  | otherwise = a `elem'` xs

-- Quicksort
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  let smallerSorted = quicksort [a | a <- xs, a <= x]
      biggerSorted = quicksort [a | a <- xs, a > x]
  in smallerSorted ++ [x] ++ biggerSorted

---HIGHER ORDER FUNCTIONS p44







