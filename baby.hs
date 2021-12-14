git status-- HASKELL mini doc

-- GHCI
-- changer le prompt
-- |	:set prompt "ghci> "
-- |	sous MAc le caractère | s'obtient avec les touches Shift+Option+L
-- |	:quit pour sortir
-- |  sous Windows :! cls vide la console
-- |	et avec git-bash  :! clear
-- |  :doc haskell_function affiche une description de cette fonction
-- |  Sélection verticale dans SublimeText Windows :
-- |  bouton droit de la souris + Shift

-- Exemples de foncions

doubleUs x y = doubleMe x + doubleMe y
doubleMe x = x + x
doubleSmallNumber' x = if x > 100 then x else x*2

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

-- Autre définition de Quicksort utilisant WHERE
-- | qs :: (Ord a) => [a] -> [a]
-- | qs [] = []
-- | qs (x:xs) = smallerSorted ++ [x] ++ biggerSorted
-- |   where smallerSorted = qs (filter (<=x) xs)
-- |         biggerSorted = qs (filter (>x) xs)



---HIGHER ORDER FUNCTIONS p44

-- une fonction Haskell n'accepte jamais qu'un seul paramètre
-- Démonstration avec max 4 5
--  | ghci> max 4 5
--  | 5
--  | ghci> (max 4) 5
--  | 5 !! (max 4) est une fonction qui n'a qu'un paramètre
--  | ghci> f = (max 4)
--  | ghci> f 5
--  | 5
--  | ghci> f 3
--  | 4

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

-- il est possible de créer une nouvelle fonction en ne passant pas 
-- tous les paramètres

-- | ghci> let multTwoWithNine = multThree 9
-- | ghci> multTwoWithNine 2 3
-- | 54  !! 54 = (9*2)*3 ! 9*2*3

-- | ghci> let multWithEighteen = multTwoWithNine 2
-- | ghci> multWithEighteen 10
-- | 180  !! (9*2) * 10 

-- PARTIAL INFIX FUNCTIONS (notation spéciale)

divideByTen :: (Floating a) => a -> a
divideByTen = (/10)

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

-- Le premier paramètre est une fonction
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

-- | ghci> applyTwice (+3) 10
-- | 16
-- | ghci> applyTwice (++ " HAHA") "HEY"
-- | "HEY HAHA HAHA"
-- | ghci> applyTwice ("HAHA " ++) "HEY"
-- | "HAHA HAHA HEY"
-- | ghci> applyTwice (multThree 2 2) 9
-- | 144
-- | ghci> applyTwice (3:) [1]
-- | [3,3,1]

--ZIPWITH recréation p47


--- MAP ET FILTER p48

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs)
  | p x = x : filter' p xs
  | otherwise = filter' p xs

--TAKEWHILE p51

--Some de tous les carrés impairs et plus petits que 10000

oddSquaresSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

--MAP peut générer une liste de fonction
--ListOfFuns est une liste infinie dont le 1er élément est une fonction 
--multipliant son paramètre par zéro, le 2èmé élément multiplie par 1, le 
--3ème par 2, etc

-- | ghci> let listOfFuns = map (*) [0..]
-- | ghci> (listOfFuns !! 4) 5
-- | 20

--Collatz sequences : à partir d'un nombre N, on applique l'algorithme suivant
--si N est impair, on le multiplie par 3, sinon on le divise par 2.

-- | chain :: (Integral a) => a -> [a]
-- | chain 1 = [1]
-- | chain n
-- |   | even n = n:chain (n `div` 2)
-- |   | odd n = n:chain (n*3 + 1)
-- | 
-- | numLongChains :: Int
-- | numLongChains = length (filter isLong (map chain [1..100]))
-- |   where isLong xs = length xs > 15

-- LAMBDAS fonctions
-- C'est une écriture abrégé pour une fonction qu'on appelera une seule fois

-- | Nouvelle version de numLongChains où isLong est remplacé par une lambda

-- | numLongChains :: Int
-- | numLongChains = length (filter (\xs -> length xs > 15) (map chain [1..100]))

-- (\xs -> length xs > 15) comme isLong est une fonction retournant un booléen.

-- Une lamda peut accepter plusieurs paramètres

-- | ghci> zipWith (\a b -> (a * 30 + 3) / b) [5,4,3,2,1] [1,2,3,4,5]
-- | [153.0,61.5,31.0,15.75,6.6]

-- | ghci> map (\(a,b) -> a + b) [(1,2),(3,5),(6,3),(2,6),(2,5)]
-- | [3,8,9,8,7]

-- FOLDS p53
-- Fold réduit une liste avec un parcours depuis la gauche, foldl ou
-- depuis la droite, foldr.

-- version explicite utilisant une lambda
-- | sum' :: (Num a) => [a] -> a
-- | sum' xs = foldl (\acc x -> acc + x) 0 xs

-- si on note que (\acc x -> acc + x) revient à appliquer (+).

-- | sum' :: (Num a) => [a] -> a
-- | sum' = foldl (+) 0

-- Réécriture de elem (mais elle parcours toute la liste, même si l'élément
-- est trouvé au début). Noter le : "then True else acc" qui conserve le True

-- | elem' :: (Eq a) => a -> [a] -> Bool
-- | elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys

-- Réécriture de MAP avec foldr

-- | map' :: (a -> b) -> [a] -> [b]
-- | map' f xs = foldr (\x acc -> f x : acc) [] xs

--FOLDL1 et FOLDR1 p55
--fonctionne comme foldl et foldr mais sans valeur initiale
--la valeur initiale et la 1ère (foldl1) ou la dernière de la liste

--Les commandes FOLD peuvent s'utiliser pour réécrire les fonctions
--maximun, reverse, product, filter, head, last

-- | maxim = foldr1 (\x acc -> if x > acc then x else acc)
-- | rever = foldl (\acc x -> x : acc) []
-- | produ = foldr1 (*)
-- | Attention partir de la droite, soit foldr
-- | foldl produirait une liste infinie
-- | filte p = foldr (\x acc -> if p x then x : acc else acc) []
-- | head2 = foldr1 (\x _ -> x)
-- | last2 = foldl1 (\_ x -> x)

--SCANL,SCANR, SCANL1, SCANR1 p57
-- Ces fonctions retournent tous les états de l'accumulateur dans une liste

-- | ghci> scanl (+) 0 [3,5,2,1]
-- | [0,3,8,10,11]
-- | ghci> scanr (+) 0 [3,5,2,1]
-- | [11,8,3,1,0]
-- | ghci> scanl1 (\acc x -> if x > acc then x else acc) [3,4,5,3,7,9,2,1]
-- | [3,4,5,5,7,9,9,9]


--FONCTION APPLICATION avec $ p57

-- | ($) :: (a -> b) -> a -> b
-- | f $ x = f x

-- Cette fonction $ permet de ne pas utiliser de parenthèses 
-- car elle a une priorité inférieure à tous les autres opérateurs

-- | ghci> sqrt 4 + 4 + 1
-- | 7.0
-- | ghci> sqrt (4 + 4 + 1)
-- | 3.0
-- | ghci> sqrt $ 4 + 4 + 1
-- | 3.0

--$ permet aussi d'appliquer un paramètre à une liste de fonctions

-- | ghci> map ($ 3) [(4+), (10*), (^2), sqrt]
-- | [7.0,30.0,9.0,1.7320508075688772]

--FONCTION COMPOSITION p58

-- | (.) :: (b -> c) -> (a -> b) -> a -> c
-- | f . g = \x -> f (g x)

--(.) permet de créer des fonctions à la volée et permet de remplacer une lambda.

-- Cette fonction multiplie sont paramètre par 3 puis inverse le signe du résultat

-- | ghci> f = negate.(* 3)
-- | ghci> f 4
-- | -12

-- Exemple : passer tous les éléments d'une liste en négatif
-- Versions lambda et composition

-- | ghci> map (\x -> negate (abs x)) [ -1, 3, -4, 5]
-- | [-1,-3,-4,-5]
-- | ghci> map (negate . abs) [ -1, 3, -4, 5]
-- | [-1,-3,-4,-5]











