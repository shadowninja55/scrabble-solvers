module Main where

import Data.Char (ord)
import Data.List (sortOn)
import Text.Printf (printf)

count :: String -> Char -> Int
count string char = 
  length $ filter (== char) string

isValid :: String -> String -> Bool
isValid word letters = 
  all sufficient word
    where sufficient letter = count word letter <= count letters letter

getScore :: String -> Int 
getScore word = 
  sum $ fmap letterScore word
    where 
      letterScore letter = scores !! (ord letter - 97)
      scores = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 
        11, 4, 4, 8, 4, 10]

displayWords :: [String] -> String
displayWords words =
  unlines $ fmap displayPair (zip words [0..])
    where
      displayPair (word, idx) = printf "%d. %s" (len - idx) word
      len = length words

main :: IO ()
main = do
  content <- readFile "dictionary.txt"
  let letters = "abcdefg"
  let words = filter (`isValid` letters) (lines content)
  let sorted = sortOn getScore words
  putStr $ displayWords sorted
