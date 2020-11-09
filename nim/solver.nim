import strutils
import tables
import algorithm
import strformat

const letters = "abcdefg"
var words: seq[string] = @[]

proc isValid(word: string): bool =
    for letter in word:
        if count(word, letter) > count(letters, letter):
            return false
    
    return true

proc loadValidWords() =
    for line in lines("dictionary.txt"):
        if isValid(line):
            words.add(line)

const scores = {
 'a': 1, 'b': 3, 'c': 3, 'd': 2,
 'e': 1, 'f': 4, 'g': 2, 'h': 4,
 'i': 1, 'j': 8, 'k': 5, 'l': 1,
 'm': 3, 'n': 1, 'o': 1, 'p': 3,
 'q': 10, 'r': 1, 's': 1, 't': 1,
 'u': 1, 'v': 4, 'w': 4, 'x': 8,
 'y': 4, 'z': 10
}.toTable

proc getScore(word: string): int =
    var total = 0

    for letter in word:
        total += scores[letter]
    
    return total

proc sortWords() =
    words.sort(proc (a, b: string): int = (if getScore(a) < getScore(b): -1 else: 1))

proc displayWords() =
    let length = len(words)

    for i in countdown(length, 1):
        let index = length - i
        echo &"{i}. {words[index]}"

loadValidWords()
sortWords()
displayWords()