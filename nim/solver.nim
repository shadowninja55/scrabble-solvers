import algorithm, strformat, strutils, sugar, tables, timeit

const letters = "abcdefg"

proc isValid(word: string): bool =
  for letter in word:
    if word.count(letter) > letters.count(letter):
      return false
    
  true

proc loadValidWords(): seq[string] =
  for line in readFile("dictionary.txt").split("\r\n"):
    if line.isValid():
      result.add line

proc getScore(word: string): int =
  const scores = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 
    1, 1, 11, 4, 4, 8, 4, 10]

  for letter in word:
    result += scores[letter.byte - 97]

func sortWords(words: var seq[string]) =
  words.sort((a, b) => (
    if a.getScore() < b.getScore(): -1 else: 1
  ))

proc displayWords(words: seq[string]) =
  for i in countdown(words.len, 1):
    echo &"{i}. {words[^i]}"

echo timeGo do:
  var words = loadValidWords()
  sortWords words
  displayWords words
