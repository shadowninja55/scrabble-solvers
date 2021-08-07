module Main where

import qualified Data.Char as C
import Text.Printf (printf)
import qualified Data.Vector as V 
import qualified Data.List as L
import qualified Data.MultiSet as M

score :: String -> Int
score = sum . fmap f
  where 
    f letter = scores V.! (C.ord letter - 97)
    scores = V.fromList [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 
      1, 11, 4, 4, 8, 4, 10]

render :: [String] -> String
render = unlines . reverse . zipWith f [(1 :: Int)..]
  where 
    f = printf "%d. %s" 

process :: M.MultiSet Char -> String -> String
process letters content = 
    render sorted
  where
    sorted = L.sortOn (negate . score) (V.toList validWords)
    validWords = fmap (wordList V.!) validWordIndices
    validWordIndices = V.findIndices (`M.isSubsetOf` letters) charSetList
    charSetList = M.fromList <$> wordList
    wordList = V.fromList . lines $ content

main :: IO ()
main = do
  content <- readFile "dictionary.txt"
  putStr $ process (M.fromList "abcdefg") content
