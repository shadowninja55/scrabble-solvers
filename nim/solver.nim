import algorithm, strformat, strutils, sugar, tables

let letters = "abcdefg"

proc isValid(word: string): bool =
    result = true

    for letter in word:
        if word.count(letter) > letters.count(letter):
            return false

proc loadValidWords(): seq[string] =
    for line in lines "dictionary.txt":
        if line.isValid:
            result.add line

proc getScore(word: string): int =
    const scores = {
      'a': 1, 'b': 3, 'c': 3, 'd': 2,
      'e': 1, 'f': 4, 'g': 2, 'h': 4,
      'i': 1, 'j': 8, 'k': 5, 'l': 1,
      'm': 3, 'n': 1, 'o': 1, 'p': 3,
      'q': 10, 'r': 1, 's': 1, 't': 1,
      'u': 1, 'v': 4, 'w': 4, 'x': 8,
      'y': 4, 'z': 10
    }.toTable

    for letter in word:
        result += scores[letter]

func sortWords(words: var seq[string]) =
    words.sort((a, b) => (
        if getScore(a) < getScore(b): -1 else: 1
    ))

proc displayWords(words: seq[string]) =
    for i in countdown(words.len, 1):
        echo &"{i}. {words[^i]}"

var words = loadValidWords()
sortWords words
displayWords words
