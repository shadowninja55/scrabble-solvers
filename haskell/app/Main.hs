module Main where

import Data.Char (ord)
import Data.List (sortOn)
import Text.Printf (printf)
import Data.Vector (fromList, (!))

isValid :: String -> String -> Bool
isValid word letters = all f word
  where 
  f letter = count letter word <= count letter letters
  count char = length . filter (== char)

score :: String -> Int 
score = sum . fmap f
  where 
  f letter = scores ! (ord letter - 97)
  scores = fromList [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 
    1, 11, 4, 4, 8, 4, 10]

prettyPrint :: [String] -> String
prettyPrint = unlines . reverse . zipWith f [(1 :: Int)..]
  where f idx word = printf "%d. %s" idx word

process :: String -> String -> String
process letters = prettyPrint . sortOn (negate . score) . filter valid . lines
  where valid = (`isValid` letters)

main :: IO ()
main = do
  content <- readFile "dictionary.txt"
  putStr . process "abcdefg" $ content
