import json

def generate_words(letters):
    words = []
    with open('dictionary.txt') as f:
        for word in f.read().split('\n'):
            if all(word.count(letter) <= letters.count(letter) for letter in word):
                words.append(word)

    return words

scores = {
     "a": 1 , "b": 3 , "c": 3 , "d": 2 ,
     "e": 1 , "f": 4 , "g": 2 , "h": 4 ,
     "i": 1 , "j": 8 , "k": 5 , "l": 1 ,
     "m": 3 , "n": 1 , "o": 1 , "p": 3 ,
     "q": 10, "r": 1 , "s": 1 , "t": 1 ,
     "u": 1 , "v": 4 , "w": 4 , "x": 8 ,
     "y": 4 , "z": 10
}

def score(word):
    return sum(scores[c] for c in word)

def display(words):
    for i, word in enumerate(reversed(words), 1):
        print(f"{i}. {words[index]}")

def main():
    letters = input('Letters: ')
    words = generate_words(letters)
    words.sort(key=score)
    display(words)

main()
